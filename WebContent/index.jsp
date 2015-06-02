<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统登录</title>
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#login").click(function(){
			$("#loginform").submit();
		});
	});
</script>
</head>
<body>
	<%=java.lang.Runtime.getRuntime().  
			freeMemory() / (1024*1024)+"M/"+java.lang.Runtime.getRuntime()
			.totalMemory()/(1024*1024)+"M" %>
	<div style="loginform">
		<form id="loginform" action="/login.do" method="post">
			管理员账号：<input name="superAdmin"/>
			出纳员账号：<input name="loginName" value="1"/>
			密码：<input type="password" name="loginPwd" value="1"/>
			<input id="login" type="button" value="登录"/>
		</form>
	</div>
</body>
</html>