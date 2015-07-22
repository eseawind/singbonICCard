<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	// 0信息录入，1修改，2单个发卡，3信息发卡
	var cardOptions = {
		width : 600,
		height : 500,
		max : false,
		mask : true,
		mixable : false,
		minable : false,
		resizable : true,
		drawable : true,
		fresh : false
	};
	var deptAdjustOptions = {
		width : 900,
		height : 550,
		max : false,
		mask : true,
		mixable : false,
		minable : false,
		resizable : true,
		drawable : true,
		fresh : false
	};
	var batchCardOptions = {
		width : 850,
		height : 500,
		max : false,
		mask : true,
		mixable : false,
		minable : false,
		resizable : true,
		drawable : true,
		fresh : false
	};
	var userListOps = {
		bindings : {
			'info' : function(t, target) {
				if (selectedDeptId <= "0") {
					alertMsg.warn('请选择部门');
					return;
				}
				var url = "${base}/userInfo.do?editType=0&deptId="
						+ selectedDeptId + "&batchId=" + selectedBatchId;
				$.pdialog.open(url, "dialog", "信息录入", cardOptions);
			},
			'edit' : function(t, target) {
				var url = "${base}/userInfo.do?editType=1&userId="
						+ $(t).attr("userId");
				$.pdialog.open(url, "dialog", "信息修改", cardOptions);
			},
			'delete' : function(t, target) {
				var userId=$(t).attr("userId");
				if (userId== null) {
					alertMsg.warn('请选择人员！');
					return;
				}
				alertMsg.confirm("确定要删除该人员吗？", {
					okCall : function() {
						$.post("${base}/delete.do?userId=" + userId,
								function(e) {
									refreshUserList();
								});
					}
				});
			},
			'dept' : function(t, target) {
				var userId=-1;
				if($(t).attr("userId")!=null){
					userId=$(t).attr("userId");
				}
				var url = "${base}/deptAdjust.do?userId="+userId
				$.pdialog.open(url, "dialog", "部门调整", deptAdjustOptions);
			},
			'single' : function(t, target) {
				if (selectedDeptId <= "0") {
					alertMsg.warn('请选择部门！');
					return;
				}
				if (!checkDeviceSn()) {
					return;
				}
				
				var url = "${base}/userInfo.do?editType=2&deptId="
						+ selectedDeptId + "&batchId=" + selectedBatchId;
				$.pdialog.open(url, "dialog", "单个发卡", cardOptions);
			},
			'infoCard' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if($(t).attr("status")==0){
					var url = "${base}/userInfo.do?editType=3&userId="
							+ $(t).attr("userId");
					$.pdialog.open(url, "dialog", "信息发卡", cardOptions);
				}else{
					alertMsg.warn('该用户已发卡不能重复操作！');
				}
			},
			'batch' : function(t, target) {
				if (selectedDeptId <= "0") {
					alertMsg.warn('请选择部门！');
					return;
				}
				if (!checkDeviceSn()) {
					return;
				}
				
				var url = "${base}/userInfo.do?editType=4&deptId="
						+ selectedDeptId + "&batchId=" + selectedBatchId;
				$.pdialog.open(url, "dialog", "批量发卡", batchCardOptions);
			},
			'readCard' : function(t, target) {
				var url = "${base}/readCard.do";
				$.pdialog.open(url, "dialog", "读卡修正", cardOptions);
			},
			'loss' : function(t, target) {
				if($(t).attr("status")==1){
					var url = "${base}/changeCard.do?editType=0&userId="
							+ $(t).attr("userId");
					$.pdialog.open(url, "dialog", "挂失", cardOptions);
				}else{
					alertMsg.warn('该卡不是正常卡，不能进行挂失操作！');
				}				
			},
			'unloss' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if($(t).attr("status")==2){
					var url = "${base}/changeCard.do?editType=1&userId="
							+ $(t).attr("userId");
					$.pdialog.open(url, "dialog", "解挂", cardOptions);
				}else{
					alertMsg.warn('该卡不是挂失卡，不能进行解挂操作！');
				}				
			},
			'remakeCard' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if($(t).attr("status")==2){
					var url = "${base}/changeCard.do?editType=2&userId="
							+ $(t).attr("userId");
					$.pdialog.open(url, "dialog", "补卡", cardOptions);
				}else{
					alertMsg.warn('该卡不是挂失卡，不能进行补卡操作！');
				}				
			},
			'changeCard' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if($(t).attr("status")==1){
					var url = "${base}/changeCard.do?editType=3&userId="
							+ $(t).attr("userId");
					$.pdialog.open(url, "dialog", "换卡", cardOptions);
				}else{
					alertMsg.warn('该卡不是正常卡，不能进行换卡操作！');
				}				
			}
		},
		onShowMenu : function(e, menu) {
			if (!$(e.target).parents("tbody").hasClass("userList")) {
				$('#edit', menu).remove();
			}
			return menu;
		}
	};

	function checkDeviceSn() {
		if (deviceSn == "") {
			alertMsg.warn('请先绑定读卡机再进行操作！');
			return false;
		}
		return true;
	}
	$(function() {
		$(".searchBar .search").click(function() {
			searchStr = $("input[name='searchStr']").val();
			refreshUserList();
		});
		$(".searchBar .clear").click(function() {
			searchStr = $("input[name='searchStr']").val("");
			searchStr = null;
			refreshUserList();
		});
	});
</script>
<div class="contextMenu" id="menu" style="display: none;">
	<ul>
		<li id="info">信息录入</li>
		<li id="edit">信息修改</li>
		<li id="dept">部门调整</li>
		<li class="divide" />
		<li id="single">单个发卡</li>
		<li id="infoCard">信息发卡</li>
		<li id="batch">批量发卡</li>
		<li class="divide" />
		<li id="readCard">读卡</li>
		<li id="loss">挂失</li>
		<li id="unloss">解挂</li>
		<li id="remakeCard">补卡</li>
		<li id="changeCard">换卡</li>		
		<li id="delete">删除未发卡人员</li>
	</ul>
</div>
<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<input type="hidden" name="pageNum" value="1" /> <input type="hidden"
		name="numPerPage" value="${model.numPerPage}" /> <input type="hidden"
		name="orderField" value="${param.orderField}" /> <input type="hidden"
		name="orderDirection" value="${param.orderDirection}" />
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>编号/姓名：<input type="text" name="searchStr"
					value="${searchStr }" />
				</td>
				<td><div class="buttonActive">
						<div class="buttonContent">
							<button type="button" class="search">检索</button>
						</div>
					</div></td>
				<td><div class="buttonActive">
						<div class="buttonContent">
							<button type="button" class="clear">清除</button>
						</div>
					</div></td>
			</tr>
		</table>
	</div>
</div>
<div class="pageContent"
	style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="95">
		<thead>
			<tr>
				<th width="80">序号</th>
				<th width="100">编号</th>
				<th width="100">姓名</th>
				<th width="120">性别</th>
				<th width="200">身份证号</th>
				<th width="80">卡类别</th>
				<th width="80">状态</th>
			</tr>
		</thead>
		<tbody class="userList">
			<c:forEach var="user" items="${list}" varStatus="status">
				<tr userId="${user.userId }" status="${user.status }">
					<td>${status.index+1}</td>
					<td>${user.userNO}</td>
					<td>${user.username}</td>
					<td>${user.sexDesc}</td>
					<td>${user.cardID}</td>
					<td>${user.cardType}类卡</td>
					<td>${user.statusDesc}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'jbsxBox')">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select> <span>条，共50条</span>
		</div>

		<div class="pagination" rel="jbsxBox" totalCount="200" numPerPage="20"
			pageNumShown="1" currentPage="1"></div>

	</div>
</div>
