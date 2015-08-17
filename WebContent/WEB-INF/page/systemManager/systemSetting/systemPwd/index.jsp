<!-- 批次设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
	$('#systemPwdForm button').click(function() {
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
	.systemPwdForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	.systemPwdForm dl {
		width: 300px;
	}
	
	.systemPwdForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 80px;
	}
	
	.systemPwdForm dd {
		width: 170px;
	}
	
	.systemPwdForm .error { /* 	position: relative; */
		/* 	top: 0; */
		
	}
	
	.systemPwdForm input {
		width: 200px;
		position: relative;
	}
	.systemPwdForm .button {
 		margin-left: 255px;
	}
	.systemPwdForm .pageFormContent dd span.error{
		left: 310px;
	}
</style>
<div class=" systemPwdForm"
	style="float:left;display: block; overflow: auto; width: 500px; line-height: 21px;margin: 50px 0 0 200px;">
	<form id="systemPwdForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
			<dl style="margin: 10px 0;">
				<dt>公司名称：</dt>
				<dd>
					<input type="hidden" name="id" value="${sessionScope.company.id}"/>
					<input type="text" name="companyName" value="${sessionScope.company.companyName}" maxlength="20" class="required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>公司序列号：</dt>
				<dd>
					<input type="text" name="serialNumber" value="${sessionScope.company.serialNumber}" maxlength="20" class="digits required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>公司授权号：</dt>
				<dd>
					<input type="text" name="authNumber" value="${sessionScope.company.authNumber}" maxlength="20" class="digits required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>基本扇区号：</dt>
				<select class="combox" outerw="178" innerw="195" name="baseSection" class="required">
					<c:forEach var="i" begin="1" end="13" step="1">
						<option value="${i}" width="220" <c:if test="${sessionScope.company.baseSection==i}">selected</c:if>>${i}</option>
					</c:forEach>
				</select>
			</dl>
			
		</div>
		<div class="buttonActive button">
			<div class="buttonContent">
				<button type="button">保存</button>
			</div>
		</div>
	</form>
</div>
