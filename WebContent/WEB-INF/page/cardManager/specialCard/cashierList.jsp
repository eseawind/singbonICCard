<!-- 出纳员列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">
	function cashierCardClick(tr){
		$("#cashierForm input[name=id]").val(tr.attr("id"));
		$("#cashierForm input[name=invalidDate]").val(tr.attr("invalidDate"));
	}
</script>

<div class="pageContent"
	style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="180">
		<thead>
			<tr>
				<th width="80">序号</th>
				<th width="150">登陆名</th>
				<th width="150">姓名</th>
				<th width="150">所属部门</th>
				<th width="100">是否启用</th>
				<th width="100">状态</th>
				<th width="200">卡有效期</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${list}" varStatus="status">
				<tr target="cashierCard" id="${user.id}" status="${user.status}" invalidDate="<fmt:formatDate value="${user.invalidDate}" pattern="yyyy-MM-dd HH:mm:ss"/>">
					<td>${status.index+1}</td>
					<td>${user.loginName}</td>
					<td>${user.name}</td>
					<td>${user.deptDesc}</td>
					<td><c:if test="${user.enabled==1 }" >启用</c:if><c:if test="${user.enabled==0 }" >禁用</c:if></td>
					<td>${user.statusDesc}</td>
					<td><fmt:formatDate value="${user.invalidDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
