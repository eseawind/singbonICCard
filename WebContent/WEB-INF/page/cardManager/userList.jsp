<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function() {
		$('.userList').contextMenu('menu', {
			bindings : {
				'info' : function(t, target) {
					var deptId=$("#deptId").val();
					if(deptId==""){
						alertMsg.error('请先选择部门');
						return;
					}
					$("#cardMake").attr("title","信息设置");
					$("#cardMake").click();
				},
				'single' : function(t, target) {
					var deptId=$("#deptId").val();
					if(deptId==""){
						alertMsg.error('请先选择部门');
						return;
					}
					$("#cardMake").attr("title","单个发卡");
					$("#cardMake").click();
				},
				'batch' : function(t, target) {
				}
			},
			onContextMenu : function(e) {
// 				if ($(e.target).parent().attr("attr") == undefined) {
// 					return false;
// 				}
				return true;
			},
			onShowMenu : function(e, menu) {
				//$("#save", menu).remove(); 
				return menu;
			}
		});
	});
	
	function info(deptId){
		
	}
</script>
<div class="contextMenu" id="menu" style="display: none;">
	<ul>
		<li id="info">信息设置</li>
		<li id="single">单个发卡</li>
		<li id="batch">批量发卡</li>
	</ul>
</div>
<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<form id="pagerForm" onsubmit="return divSearch(this, 'jbsxBox');"
		action="demo/pagination/list1.html" method="post">
		<input type="hidden" name="pageNum" value="1" /> <input type="hidden"
			name="numPerPage" value="${model.numPerPage}" /> <input
			type="hidden" name="orderField" value="${param.orderField}" /> <input
			type="hidden" name="orderDirection" value="${param.orderDirection}" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>编号：<input type="text" name="keyword" />
					</td>
					<td><div class="buttonActive">
							<div class="buttonContent">
								<button type="submit">检索</button>
							</div>
						</div></td>
				</tr>
			</table>
		</div>
	</form>
</div>

<input type="hidden" id="deptId" value="${deptId }"/>
<a href="/cardManager/cardMake.do" target="dialog" id="cardMake" title="">打开窗台</a>
<div class="pageContent userList"
	style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="110" rel="jbsxBox">
		<thead>
			<tr>
				<th width="80">序号</th>
				<th width="100">学(工)号</th>
				<th width="100">姓名</th>
				<th width="120">性别</th>
				<th width="200">身份证号</th>
				<th width="80">卡类别</th>
				<th width="80">使用状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${userList}">
				<tr>
					<td attr="${user.id}">${index+1}</td>
					<td attr="${user.id}">${user.userNO}</td>
					<td attr="${user.id}">${user.username}</td>
					<td attr="${user.id}">${user.sexDesc}</td>
					<td attr="${user.id}">${user.cardID}</td>
					<td attr="${user.id}">${user.cardTypeDesc}</td>
					<td attr="${user.id}">${user.cardStatusDesc}</td>
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
