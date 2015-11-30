<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录</title>
<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>

<!-- <script src="/js/comet4j.js" type="text/javascript"></script> -->
<script type="text/javascript">
	$(function(){
		var companyName=$.cookie('companyName');
		if(companyName!=null && companyName!=''){
			$('#login-box input[name=companyName]').val(companyName);
		}
		$('#login-box #loginButton').click(function(){
			var valErr=false;
			$('#login-box input:not(:hidden)').each(function(){
				var val=$.trim($(this).val());
				if(val==''){
					valErr=true;
					$(this).parent().next().find('div').show();
				}
			});
			if(valErr){
				return;
			}
			$('#loginForm').submit();
		});

		$('#login-box input').click(function(){
			$('#login-box .error').hide();
			$(this).parent().next().find('div').hide();
		});
		
	});	
</script>
<style type="text/css">
	#login-box{
		position: absolute;
		top:210px;
		right:150px;
		width:500px;
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
		width: 170px;
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
	#login-box .note{
		color: white;
		background-color: red;
		width: 120px;
		padding: 2px;
  		display: none;
 		width: 120px;
	}
</style>
</head>
<body>
	<img src="/img/loginBg.png" width="100%" style="margin-top: 220px;"/>
	<div id="login-box">
		<div id="loginComet"></div>
		<form id='loginForm' action="/userlogin.do" method='POST'>
			<table>
				<tr>
					<td colspan="3">
						<div id="error" class="error">公司名称、用户名或密码错误或者没有分配权限</div>
					</td>
				</tr>
				<tr>
					<td>单位名称:</td>
					<td><input type='text' name='companyName' value=''/></td>
	 				<td><div class="note">单位名称不能为空</div></td>
				</tr>
				<tr>
					<td>用户名:</td>
					<td><input type='text' name='username' value='admin'/></td>
	 				<td><div class="note">用户名不能为空</div></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input type='password' name='password' value="0"/></td>
	 				<td><div class="note">密码不能为空</div></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<button id="loginButton" type="button"></button>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
