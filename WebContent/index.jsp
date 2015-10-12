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
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">
	var isInit=false;
	$(function(){
		$('#login-box #loginButton').click(function(){
			var valErr=false;
			$('#login-box input:not(:radio):not(:hidden)').each(function(){
				var val=$(this).val().trim();
				if(val==''){
					valErr=true;
					$(this).next().show();
				}
			});
			if(valErr){
				return;
			}
			var loginType=$('#login-box :radio[checked]').val();
// 			if(loginType==1){
				$('#loginForm').submit();
// 			}else{
// 				var companyName=$('#login-box input[name=companyName]').val();
// 				var username=$('#login-box input[name=username]').val();
// 				var password=$('#login-box input[name=password]').val();
// 				$.post("/login.do?companyName="+companyName+"&loginName="+username+"&loginPwd="+password, function(e){
// 					var e2 = eval('(' + e + ')');
// 					if(e2.r==0){
// 						$('#login-box #error').show();
// 					}else if(e2.r==1){
// 						$('#login-box #noDevice').show();						
// 					}else if(e2.r==2){
// 						$('#login-box #offline').show();						
// 					}else if(e2.r==3){
// 						$('#login-box input[name=cardNO]').val(e2.cardNO);
// 						$('#login-box input[name=cardSN]').val(e2.cardSN);
// 						if(!isInit){
// 							$('#loginComet').load('/loginComet.jsp?sn='+e2.sn);
// 						}else{
// 							valCashierCard();
// 						}
// 					}
// 				});
// 			}
		});

		$('#login-box input:not(:radio)').click(function(){
			$('#login-box .error').hide();
			$(this).next().hide();
		});
		
	});
	
	function valCashierCard(){
		$.post("/valCashierCard.do");
	}
	
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
		<div id="loginComet"></div>
		<form id='loginForm' action="<c:url value='disuserlogin.htm' />" method='POST'>
			<table>
				<tr>
					<td>&nbsp;</td>
					<td>
						<div id="error" class="error">公司名称、用户名或密码错误</div>
						<div id="noDevice" class="error">该用户没有绑定读卡机</div>
						<div id="offline" class="error">读卡机不在线</div>
						<div id="errInfo" class="error">卡信息和用户信息不匹配</div>
						<input type="hidden" name="cardNO"/>
						<input type="hidden" name="cardSN"/>
					</td>
				</tr>
				<tr>
					<td>单位名称:</td>
					<td><input type='text' name='companyName' value='河南郑州电子有限公司'/><span>单位名称不能为空</span> </td>
<!-- 					<td><input type='text' name='companyName' value='1'/><span>单位名称不能为空</span> </td> -->
				</tr>
				<tr>
					<td>用户名:</td>
					<td><input type='text' name='username' value='1'/><span>用户名不能为空</span></td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input type='password' name='password' value="1"/><span>密码不能为空</span></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<button id="loginButton" type="button"></button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
