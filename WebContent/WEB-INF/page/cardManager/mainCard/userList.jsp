<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
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
	var userListOps = {
		bindings : {
			'info' : function(t, target) {
				if (selectedDeptId <= "0") {
					alertMsg.warn('请选择部门');
					return;
				}
				var url = "${base}/userInfo.do?editType=0&deptId="
						+ selectedDeptId + "&batchId=" + selectedBatchId;
				// 					alert(url);
				$.pdialog.open(url, "dialog", "信息录入", cardOptions);
			},
			'edit' : function(t, target) {
				var url = "${base}/userInfo.do?editType=1&id="
						+ $(t).attr("attr");
				// 					alert(url);
				$.pdialog.open(url, "dialog", "信息修改", cardOptions);
			},
			'single' : function(t, target) {
			},
			'batch' : function(t, target) {
			}
		}
	};
	$(function(){
		$(".searchBar .search").click(function(){
			searchStr=$("input[name='searchStr']").val();
			refreshUserList();
		});
		$(".searchBar .clear").click(function(){
			searchStr=$("input[name='searchStr']").val("");
			searchStr=null;
			refreshUserList();
		});
	});
</script>
<div class="contextMenu" id="menu" style="display: none;">
	<ul>
		<li id="info">信息录入</li>
		<li id="edit">信息修改</li>
		<li id="single">单个发卡</li>
		<li id="batch">批量发卡</li>
	</ul>
</div>
<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<input type="hidden" name="pageNum" value="1" /> <input type="hidden" name="numPerPage"
		value="${model.numPerPage}" /> <input type="hidden" name="orderField" value="${param.orderField}" />
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />
	<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>编号/姓名：<input type="text" name="searchStr" value="${searchStr }"/>
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
<div class="pageContent" style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="95">
		<thead>
			<tr>
				<th width="80">序号</th>
				<th width="100">编号</th>
				<th width="100">姓名</th>
				<th width="120">性别</th>
				<th width="200">身份证号</th>
				<th width="80">卡类别</th>
				<th width="80">使用状态</th>
			</tr>
		</thead>
		<tbody class="userList">
			<c:forEach var="user" items="${list}">
				<tr attr="${user.id }">
					<td>${index+1}</td>
					<td>${user.userNO}</td>
					<td>${user.username}</td>
					<td>${user.sexDesc}</td>
					<td>${user.cardID}</td>
					<td>${user.cardTypeDesc}</td>
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

		<div class="pagination" rel="jbsxBox" totalCount="200" numPerPage="20" pageNumShown="1"
			currentPage="1"></div>

	</div>
</div>
