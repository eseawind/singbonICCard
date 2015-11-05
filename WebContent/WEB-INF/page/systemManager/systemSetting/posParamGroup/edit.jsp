<!-- 消费机参数分组编辑 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
	$('#posParamGroupEditForm .save').click(function() {
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
	#posParamGroupEditForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#posParamGroupEditForm dl {
		width: 330px;
	}
	
	#posParamGroupEditForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 110px;
	}
	
	#posParamGroupEditForm dd {
		width: 200px;
	}
	
	#posParamGroupEditForm input{
		width: 20px;
	}
</style>
<form id="posParamGroupEditForm" method="post" action="${base}/addEdit.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="188" style="width: 500px;margin: 50px 0 0 200px;">
		<dl style="margin: 10px 0;">
			<dt>是否优先消费补助：</dt>
			<dd>
				<input name="subsidyFirst" type="radio" <c:if test="${posParamGroup.subsidyFirst==0}">checked</c:if> value="0"/>是
				<input style="margin-left: 16px;" name="subsidyFirst" type="radio" <c:if test="${posParamGroup.subsidyFirst==1}">checked</c:if> value="1"/>否
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>是否启用补助清零：</dt>
			<dd>
				<input type="hidden" name="id" value="${posParamGroup.id}"/>
				<input name="subsidyReset" type="radio" <c:if test="${posParamGroup.subsidyReset==0}">checked</c:if> value="0"/>启用
				<input name="subsidyReset" type="radio" <c:if test="${posParamGroup.subsidyReset==1}">checked</c:if> value="1"/>禁用
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>是否启用卡底金：</dt>
			<dd>
				<input name="enableCardMinFare" type="radio" <c:if test="${posParamGroup.enableCardMinFare==1}">checked</c:if> value="1"/>启用
				<input name="enableCardMinFare" type="radio" <c:if test="${posParamGroup.enableCardMinFare==0}">checked</c:if> value="0"/>禁用
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>是否启用次限额：</dt>
			<dd>
				<input name="enableTimeLimitFare" type="radio" <c:if test="${posParamGroup.enableTimeLimitFare==1}">checked</c:if> value="1"/>启用
				<input name="enableTimeLimitFare" type="radio" <c:if test="${posParamGroup.enableTimeLimitFare==0}">checked</c:if> value="0"/>禁用
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>是否启用日限额：</dt>
			<dd>
				<input name="enableDayLimitFare" type="radio" <c:if test="${posParamGroup.enableDayLimitFare==1}">checked</c:if> value="1"/>启用
				<input name="enableDayLimitFare" type="radio" <c:if test="${posParamGroup.enableDayLimitFare==0}">checked</c:if> value="0"/>禁用
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>是否启用优惠方案：</dt>
			<dd>
				<input name="enableDiscount" type="radio" <c:if test="${posParamGroup.enableDiscount==1}">checked</c:if> value="1"/>启用
				<input name="enableDiscount" type="radio" <c:if test="${posParamGroup.enableDiscount==0}">checked</c:if> value="0"/>禁用
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>是否启用餐别限次：</dt>
			<dd>
				<input name="enableMeal" type="radio" <c:if test="${posParamGroup.enableMeal==1}">checked</c:if> value="1"/>启用
				<input name="enableMeal" type="radio" <c:if test="${posParamGroup.enableMeal==0}">checked</c:if> value="0"/>禁用
			</dd>
		</dl>
		<dl style="margin: 10px 0;">
			<dt>波特率：</dt>
			<dd>
				<input name="bound" type="radio" <c:if test="${posParamGroup.bound==1}">checked</c:if> value="1"/>9600
				<input name="bound" type="radio" <c:if test="${posParamGroup.bound==3}">checked</c:if> value="3"/>115200
			</dd>
		</dl>
	</div>
	<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_POSPARAMGROUP_SAVE">
	<div class="formBar">
		<div class="panelBar" style="border-style: none;">
			<ul class="toolBar">
				<li><a class="save" href="javascript:;"><span>保存</span></a></li>
			</ul>
		</div>
	</div>
	</security:authorize>
</form>