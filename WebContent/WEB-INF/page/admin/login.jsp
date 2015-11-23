<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>兴邦IC卡管理系统——后台登录</title>
<script type="text/javascript" src="/js/jquery-1.7.2.js"></script>

<script type="text/javascript">
	$(function(){
		$('#login-box #loginButton').click(function(){
			var valErr=false;
			$('#login-box input:not(:hidden)').each(function(){
				var val=$(this).val().trim();
				if(val==''){
					valErr=true;
					$(this).next().show();
				}
			});
			if(valErr){
				return;
			}
			var username=$('#login-box input[name=username]').val();
			var password=$('#login-box input[name=password]').val();
			$.post("${base}/loginin.do?loginName="+username+"&loginPwd="+password, function(e){
				if(e==1){
					window.location.href='${base}/setting/index.do';
				}
			});
		});
		
		$('#login-box input').click(function(){
			$('#login-box .error').hide();
			$(this).next().hide();
		});
	});
</script>
<style type="text/css">
	#login-box{
		position: absolute;
		top:210px;
		right:150px;
		width:400px;
		height:218px;
		font-size:13px;
/* 		background-image: url("/img/loginForm.png"); */
	}
	#login-box table{
		margin: 60px 0 0 60px;
	}
	#login-box input{
		background-color:#f6fbfd;
		border: 1px solid #c0c0c0;
	}
	#login-box input:hover{
		border-bottom: 1px solid #fc6f07;
	}
	#login-box #loginButton{
		border: none;
		width:73px;
		height:28px;
		cursor:pointer;
		margin:5px 0 0 5px;
		background-image: url("/img/loginButton1.png");
	}
	#login-box #loginButton:hover{
		background-image: url("/img/loginButton2.png");
	}
	input:-webkit-autofill { 
		-webkit-box-shadow: 0 0 0 1000px #f6fbfd inset;
	}
	#login-box #error{
		color: red;
		display: none;		
		<c:if test="${param.error==true }">
		display: block;		
		</c:if>
	}
	#login-box #noDevice,#login-box #offline,#login-box #errInfo{
		color: red;
		display: none;		
	}
	#login-box span{
		color: white;
		background-color: red;
		width: 120px;
		padding: 2px;
		margin-top:2px;
		position: absolute;
		display: none;
	}
</style>
</head>
<body>
	<img src="/img/loginBg.png" width="100%" style="margin-top: 220px;"/>
	<div id="login-box">
		<table>
			<tr>
				<td>&nbsp;</td>
				<td>
					<div id="error" class="error">用户名或密码错误</div>
				</td>
			</tr>
			<tr>
				<td>用户名:</td>
				<td><input type='text' name='username' value='admin'/><span>用户名不能为空</span></td>
			</tr>
			<tr>
				<td>密码:</td>
				<td><input type='password' name='password' value=""/><span>密码不能为空</span></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<button id="loginButton" type="button"></button>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
