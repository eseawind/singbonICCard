<!-- 系统参数设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
	$('#systemParamForm .save').click(function() {
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
	#systemParamForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#systemParamForm dl {
		width: 330px;
	}
	
	#systemParamForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 110px;
	}
	
	#systemParamForm dd {
		width: 200px;
	}
	
	#systemParamForm .error { /* 	position: relative; */
		/* 	top: 0; */
		
	}
	
	#systemParamForm input {
		width: 200px;
		position: relative;
	}
	
	#systemParamForm .button {
 		margin-left: 255px;
	}
	#systemParamForm .pageFormContent dd span.error{
		left: 310px;
	}
</style>
<form id="systemParamForm" method="post" action="${base}/save.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="188" style="width: 500px;margin: 50px 0 0 200px;">
		<dl style="margin: 10px 0;">
			<dt>单位名称：</dt>
			<dd>
				<input type="hidden" name="id" value="${company.id}"/>
				<input type="text" name="companyName" value="${company.companyName}" maxlength="20" class="required" />
			</dd>
		</dl>
<!-- 		<dl style="margin: 10px 0;"> -->
<!-- 			<dt>单位序列号：</dt> -->
<!-- 			<dd> -->
<%-- 				<input type="text" name="serialNumber" value="${company.serialNumber}" maxlength="20" class="digits required" /> --%>
<!-- 			</dd> -->
<!-- 		</dl> -->
<!-- 		<dl style="margin: 10px 0;"> -->
<!-- 			<dt>单位授权号：</dt> -->
<!-- 			<dd> -->
<%-- 				<input type="text" name="authNumber" value="${company.authNumber}" maxlength="20" class="digits required" /> --%>
<!-- 			</dd> -->
<!-- 		</dl> -->
		<dl style="margin: 10px 0;">
			<dt>基本扇区号：</dt>
			<select class="combox" outerw="178" innerw="195" name="baseSection" class="required">
				<c:forEach var="i" begin="1" end="13" step="1">
					<option value="${i}" width="220" <c:if test="${company.baseSection==i}">selected</c:if>>${i}</option>
				</c:forEach>
			</select>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>设备心跳间隔：</dt>
			<dd>
				<input type="text" name="heartInterval" value="${company.heartInterval}" maxlength="20" class="digits required" />
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>数据上传间隔：</dt>
			<dd>
				<input type="text" name="uploadInterval" value="${company.uploadInterval}" maxlength="20" class="digits required" />
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>数据上传容错次数：</dt>
			<dd>
				<input type="text" name="uploadErrTime" value="${company.uploadErrTime}" maxlength="20" class="digits required" />
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>是否启用补助宏冲：</dt>
			<dd>
				<input style="width: 16px;" name="enableSubsidyReset" type="radio" <c:if test="${company.enableSubsidyReset==0}">checked</c:if> value="0"/>启用
				<input style="width: 16px;" name="enableSubsidyReset" type="radio" <c:if test="${company.enableSubsidyReset==1}">checked</c:if> value="1"/>不启用
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>最新补助宏冲日期：</dt>
			<dd>
				${company.subsidyInvalidDate}
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>补助版本号：</dt>
			<dd>
				${company.subsidyVersion}
			</dd>
		</dl>
	</div>
	<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SYSTEMPARAM_SAVE">
	<div class="formBar">
		<div class="panelBar" style="border-style: none;">
			<ul class="toolBar">
				<li><a class="save" href="javascript:;"><span>保存</span></a></li>
			</ul>
		</div>
	</div>
	</security:authorize>
</form>
