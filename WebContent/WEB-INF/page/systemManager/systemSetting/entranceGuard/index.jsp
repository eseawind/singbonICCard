<!-- 制卡参数设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
	$('#entranceGuardForm button').click(function() {
		validateCallback($(this).parents('form'), function(e) {
			if (e == 1) {
				alertMsg.correct('保存成功！');
			} else if(e==0) {
				alertMsg.warn('保存失败！');					
			}
		}, null);
	});
</script>

<style type="text/css">
	#entranceGuardForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#entranceGuardForm dl {
		width: 400px;
	}
	
	#entranceGuardForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 100px;
	}
	
	#entranceGuardForm dd {
		width: 170px;
	}
	
	#entranceGuardForm .error { /* 	position: relative; */
		/* 	top: 0; */
	}
	
	#entranceGuardForm .textInput {
		width: 200px;
		position: relative;
	}
	#entranceGuardForm .button {
 		margin-left: 255px;
	}
	#entranceGuardForm .pageFormContent dd span.error{
		left: 310px;
	}
</style>
<div style="float:left;display: block; overflow: auto; width: 500px; line-height: 21px;margin: 50px 0 0 200px;">
	<form id="entranceGuardForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
			<dl style="margin: 10px 0;">
				<dt>开门延时/s：</dt>
				<dd>
					<input type="hidden" name="id" value="${entranceGuard.id}"/>
					<input type="text" name="openDelay" value="${entranceGuard.openDelay}" maxlength="20" class="digits required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>刷卡模式：</dt>
				<dd>
					<input name="cardPwdType" type="radio" <c:if test="${entranceGuard.cardPwdType==1}">checked</c:if> value="1"/>启用密码
					<input name="cardPwdType" type="radio" <c:if test="${entranceGuard.cardPwdType==0}">checked</c:if> value="0"/>不启用
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>记录模式：</dt>
				<dd>
					<input name="recordType" type="radio" <c:if test="${entranceGuard.recordType==1}">checked</c:if> value="1"/>覆盖
					<input name="recordType" type="radio" <c:if test="${entranceGuard.recordType==0}">checked</c:if> value="0"/>不覆盖
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>授权验证模式：</dt>
				<dd>
					<input name="authType" type="radio" <c:if test="${entranceGuard.authType==1}">checked</c:if> value="1"/>启用
					<input name="authType" type="radio" <c:if test="${entranceGuard.authType==0}">checked</c:if> value="0"/>不启用
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>门正常状态：</dt>
				<dd>
					<input name="openStatus" type="radio" <c:if test="${entranceGuard.openStatus==0}">checked</c:if> value="0"/>正常
					<input name="openStatus" type="radio" <c:if test="${entranceGuard.openStatus==1}">checked</c:if> value="1"/>常开
					<input name="openStatus" type="radio" <c:if test="${entranceGuard.openStatus==2}">checked</c:if> value="2"/>常闭
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>操作密码：</dt>
				<dd>
					<input name="operPwd" type="text" value="${entranceGuard.operPwd}" class="required digits" maxlength="6" minlength="6"/>
				</dd>
			</dl>
		</div>
		<div class="buttonActive button">
			<div class="buttonContent">
				<button type="button">保存</button>
			</div>
		</div>
	</form>
</div>
