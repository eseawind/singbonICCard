<!-- 系统用户列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
	
</script>
<style type="text/css">

</style>
<table class="table" width="99%" layoutH="30" rel="jbsxBox">
	<thead>
		<tr>
			<th width="100">登录名</th>
			<th width="100">读卡机</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="s">
			<tr target="sysUser" operId="${s.operId}" loginName="${s.loginName}" loginPwd="${s.loginPwd}" deviceId="${s.deviceId}" deviceName="${s.deviceName}" remark="${s.remark }">
				<td loginName>${s.loginName }</td>
				<td>${s.deviceName }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>