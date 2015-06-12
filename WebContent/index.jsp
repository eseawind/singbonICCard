<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
<%-- <link rel="Stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login.css" /> --%>
</head>
<body>
	<%=java.lang.Runtime.getRuntime().freeMemory() / (1024 * 1024) + "M/" + java.lang.Runtime.getRuntime().totalMemory() / (1024 * 1024) + "M"%>
	<div id="login-box">
		<h3>Login with Username and Password</h3>
		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>
		<form name='loginForm'
			action="<c:url value='disuserlogin.htm' />" method='POST'>
			<table>
				<tr>
					<td>company:</td>
					<td><input type='text' name='companyName' value='1'></td>
				</tr>
				<tr>
					<td>User:</td>
					<td><input type='text' name='username' value='1'></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type='password' name='password' value="1"/></td>
				</tr>
				<tr>
					<td colspan='2'><input name="submit" type="submit"
						value="submit" /></td>
				</tr>
			</table>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
	</div>
</body>
</html>
