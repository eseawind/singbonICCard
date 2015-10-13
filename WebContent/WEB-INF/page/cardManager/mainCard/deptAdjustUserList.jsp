<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type='text/javascript'>
	
	$(function() {
		$('#adjustSearchList .searchAdjust').click(function() {
			searchAdjustUserList();
		});
		$('#adjustSearchList .clearAdjust').click(function() {
			$('input[name=searchStr]').val('');
			searchAdjustUserList();
		});
	});
	function searchAdjustUserList(){
		$('#adjustUserList')
		.loadUrl('${base}/adjustUserList.do?load=true&searchStr='+$('#adjustSearchList input[name=searchStr]').val(), {}, function(){
			$('#adjustUserList').find('[layoutH]').layoutH();
		});
	}
</script>
<div id="adjustSearchList" style="padding: 10px 5px 0 0;">
	<div class="pageHeader" style="border: 1px #B8D0D6 solid;">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>编号/姓名：<input type="text" name="searchStr"
						value="${searchStr }" />
					</td>
					<td><div class="buttonActive">
							<div class="buttonContent">
								<button type="button" class="searchAdjust">检索</button>
							</div>
						</div></td>
					<td><div class="buttonActive">
							<div class="buttonContent">
								<button type="button" class="clearAdjust">清除</button>
							</div>
						</div></td>
				</tr>
			</table>
		</div>
	</div>
	<div 
		style="background-color: #fff;" layoutH="80">
		<table class="table" width="100%">
			<thead>
				<tr>
					<th width="80">序号</th>
					<th width="100">编号</th>
					<th width="100">姓名</th>
					<th width="120">性别</th>
					<th width="80">卡类别</th>
					<th width="80">状态</th>
				</tr>
			</thead>
			<tbody class="userList">
				<c:forEach var="user" items="${list}" varStatus="status">
					<tr>
						<td>${status.index+1}<input type="hidden" name="userIds" value="${user.userId }"/></td>
						<td>${user.userNO}</td>
						<td>${user.username}</td>
						<td>${user.sexDesc}</td>
						<td>${user.cardTypeId}类卡</td>
						<td>${user.statusDesc}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>