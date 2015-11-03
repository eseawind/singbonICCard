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
		menuStyle : {
			width : '120px'
		},
		bindings : {
			'info' : function(t, target) {
				if (selectedDeptId <= '0') {
					alertMsg.warn('请选择部门');
					return;
				}
				var url = '${base}/userInfo.do?editType=0&deptId='+ selectedDeptId + '&batchId=' + selectedBatchId;
				$.pdialog.open(url, 'dialog', '信息录入', cardOptions);
			},
			'edit' : function(t, target) {
				var url = '${base}/userInfo.do?editType=1&userId='+ $(t).attr('userId');
				$.pdialog.open(url, 'dialog', '信息修改', cardOptions);
			},
			'dept' : function(t, target) {
				var userId = -1;
				if ($(t).attr('userId') != null) {
					userId = $(t).attr('userId');
				}
				var url = '${base}/deptAdjust.do?userId=' + userId
				$.pdialog.open(url, 'dialog', '部门调整', deptAdjustOptions);
			},
			'single' : function(t, target) {
				if (selectedDeptId <= '0') {
					alertMsg.warn('请选择部门！');
					return;
				}
				if (!checkDeviceSn()) {
					return;
				}

				var url = '${base}/userInfo.do?editType=2&deptId='+ selectedDeptId + '&batchId=' + selectedBatchId;
				$.pdialog.open(url, 'dialog', '单个发卡', cardOptions);
			},
			'infoCard' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if ($(t).attr('status') == 0) {
					var url = '${base}/userInfo.do?editType=3&userId='+ $(t).attr('userId');
					$.pdialog.open(url, 'dialog', '信息发卡', cardOptions);
				} else {
					alertMsg.warn('该用户已发卡不能重复操作！');
				}
			},
			'batch' : function(t, target) {
				if (selectedDeptId <= '0') {
					alertMsg.warn('请选择部门！');
					return;
				}
				if (!checkDeviceSn()) {
					return;
				}

				var url = '${base}/userInfo.do?editType=4&deptId='+ selectedDeptId + '&batchId=' + selectedBatchId;
				$.pdialog.open(url, 'dialog', '批量发卡', batchCardOptions);
			},
			'readCard' : function(t, target) {
				var url = '${base}/readCard.do';
				$.pdialog.open(url, 'dialog', '读卡修正', cardOptions);
			},
			'loss' : function(t, target) {
				if ($(t).attr('status') == 241) {
					var url = '${base}/changeCard.do?editType=0&userId='+ $(t).attr('userId');
					$.pdialog.open(url, 'dialog', '挂失', cardOptions);
				} else {
					alertMsg.warn('该卡不是正常卡，不能进行挂失操作！');
				}
			},
			'unloss' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if ($(t).attr('status') == 243) {
					var url = '${base}/changeCard.do?editType=1&userId='+ $(t).attr('userId');
					$.pdialog.open(url, 'dialog', '解挂', cardOptions);
				} else {
					alertMsg.warn('该卡不是挂失卡，不能进行解挂操作！');
				}
			},
			'remakeCard' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if ($(t).attr('status') == 243) {
					var url = '${base}/changeCard.do?editType=2&userId='+ $(t).attr('userId');
					$.pdialog.open(url, 'dialog', '补卡', cardOptions);
				} else {
					alertMsg.warn('该卡不是挂失卡，不能进行补卡操作！');
				}
			},
			'changeCard' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if ($(t).attr('status') == 241) {
					var url = '${base}/changeCard.do?editType=3&userId='+ $(t).attr('userId');
					$.pdialog.open(url, 'dialog', '换卡', cardOptions);
				} else {
					alertMsg.warn('该卡不是正常卡，不能进行换卡操作！');
				}
			},
			'offWithCard' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				if ($(t).attr('status') == 0) {
					alertMsg.warn('该卡尚未发卡，不能进行有卡注销操作！');
				}else if($(t).attr('status') == 244){
					alertMsg.warn('该卡已经注销，不能重复进行有卡注销操作！');					
				} else {
					var url = '${base}/changeCard.do?editType=5&userId='+ $(t).attr('userId');
					$.pdialog.open(url, 'dialog', '有卡注销', cardOptions);
				}
			},
			'offNoCard' : function(t, target) {
				alertMsg.confirm('确定要注销该人员吗？', {
					okCall : function() {
						$.post('${base}/doChangeCard.do?editType=4&userId='+ $(t).attr('userId')+'&cardNO='+$(t).attr('cardNO'), function(e) {
							refreshUserList();
						});
					}
				});
			},
			'charge' : function(t, target) {
				if (!checkDeviceSn()) {
					return;
				}
				var url = '${base}/charge.do';
				$.pdialog.open(url, 'dialog', '存取款', cardOptions);
			},
			'delete' : function(t, target) {
				var userIds = '';
				$('.userList input:checkbox').each(
						function() {
							if ($(this).attr('checked')
									&& $(this).attr('status') == 0) {
								userIds += $(this).val() + ',';
							}
						});
				if (userIds != '') {
					userIds = userIds.substring(0, userIds.length - 1);
					alertMsg.confirm('确定要删除未发卡人员吗？', {
						okCall : function() {
							$.post('${base}/delete.do?checkedUserIds='+ userIds, function(e) {
								refreshUserList();
							});
						}
					});
				} else {
					alertMsg.warn('请选择未发卡人员！');
				}
			}
		},
		onShowMenu : function(e, menu) {
			if (!$(e.target).parents('tbody').hasClass('userList')) {
				$('#edit', menu).remove();
			}
			return menu;
		}
	};

	function checkDeviceSn() {
		if (deviceSn == '') {
			alertMsg.warn('请先绑定读卡机再进行操作！');
			return false;
		}
		return true;
	}
	$(function() {
		$(function() {
			$('.search').click(function() {
				divSearch($('#pagerForm'), 'userList');
			});
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
		<li id="offWithCard">有卡注销</li>
		<li id="offNoCard">无卡注销</li>
		<li id="charge">存、取款</li>
		<li id="delete">删除选中未发卡人员</li>
	</ul>
</div>
<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<form action="${base}/list.do" id="pagerForm">
		<input type="hidden" name="pageNum" value="${pageNum}" /> <input
			type="hidden" name="numPerPage" value="${numPerPage}" /> <input
			type="hidden" name="totalCount" value="${totalCount}" />
		<div class="searchBar">
			<table border="0">
				<tr align="right">
					<td>用户信息：</td>
					<td><input type="text" name="nameStr" size="10"
						value="${nameStr }" /> <input type="hidden" name="deptId"
						value="${deptId}" /></td>
					<td style="padding-left: 10px;">
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" class="search">&nbsp;&nbsp;查询&nbsp;&nbsp;</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>
<div class="pageContent"
	style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="125">
		<thead>
			<tr>
				<th width="10"><input type="checkbox" group="userIds"
					class="checkboxCtrl"></th>
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
				<tr userId="${user.userId }" status="${user.status }" cardNO="${user.cardNO}">
					<td><input name="userIds" value="${user.userId }" status="${user.status}" type="checkbox"></td>
					<td>${status.index+1}</td>
					<td>${user.userNO}</td>
					<td>${user.username}</td>
					<td>${user.sexDesc}</td>
					<td>${user.cardID}</td>
					<td>${user.cardTypeId}类卡</td>
					<td>${user.statusDesc}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'userList')">
				<c:forEach begin="1" end="20" var="i" step="1">
					<option value='${i*10 }'
						<c:if test="${i*10==numPerPage }">selected</c:if>>${i*10 }</option>
				</c:forEach>
			</select> <span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" rel="userList" totalCount="${totalCount }"
			numPerPage="${numPerPage }" pageNumShown="10"
			currentPage="${pageNum }"></div>
	</div>
</div>
