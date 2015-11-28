<!-- 消费参数设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
$(function() {
	$('#consumeParamForm .save').click(
			function() {
				validateCallback($(this).parents('form'), function(e) {
					if (e == 1) {
						alertMsg.correct('保存成功！');
					} else {
						alertMsg.error('保存失败！');
					}
				}, null, false);
			});
	
	$('#consumeParamForm .selectAll').click(function(){
		if($(this).attr('checked')){
			$(this).siblings().attr("checked",true);
		}else{
			$(this).siblings().attr("checked",false);			
		}
	});
});
</script>

<style type="text/css">
	#consumeParamForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#consumeParamForm dl {
		width: 350px;
	}
	
	#consumeParamForm fieldset dl {
		padding-left: 30px;
	}
	
	#consumeParamForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 90px;
	}
	
	#consumeParamForm dd {
		width: 250px;
	}
	
	#consumeParamForm dd span.error {
		left: 200px;
	}
	#consumeParamForm .cardTypesBox{
		width: 1000px;
		padding:5px 0 0 10px;
	}
	#consumeParamForm .cardTypesBox .cardTypes{
		width: 800px;
	}
	#consumeParamForm fieldset{
		padding: 3px 0 20px 3px;
	}
</style>
<form id="consumeParamForm" method="post" action="${base }/save.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="138">
		<fieldset style="margin-top: 50px;">
			<legend>卡底金</legend>
			<dl>
				<dt>金额/元：</dt>
				<dd>
					<input name="id" type="hidden" value="${consumeParam.id }"/> 
					<input name="cardMinFare" type="text" class="required digits" value="${consumeParam.cardMinFare}" />
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt>授权卡类型：</dt>
				<dd class="cardTypes">
					<input type="checkbox" class="selectAll">全选
				 	<c:set var="cardMinFareCardTypes" value="${consumeParam.cardMinFareCardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="cardMinFareCardTypes" value="${i}" <c:if test="${fn:indexOf(cardMinFareCardTypes, str2)!=-1}">checked</c:if>/>${i}类
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>日限额</legend>
			<dl>
				<dt>金额/元：</dt>
				<dd>
					<input name="dayLimitFare" type="text" class="required digits" value="${consumeParam.dayLimitFare }"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt>授权卡类型：</dt>
				<dd class="cardTypes">
					<input type="checkbox" class="selectAll">全选
				 	<c:set var="dayLimitFareCardTypes" value="${consumeParam.dayLimitFareCardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="dayLimitFareCardTypes" value="${i}" <c:if test="${fn:indexOf(dayLimitFareCardTypes, str2)!=-1}">checked</c:if>/>${i}类
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>次限额</legend>
			<dl>
				<dt>金额/元：</dt>
				<dd>
					<input name="timeLimitFare" type="text" class="required digits" value="${consumeParam.timeLimitFare }"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt>授权卡类型：</dt>
				<dd class="cardTypes">
					<input type="checkbox" class="selectAll">全选
				 	<c:set var="timeLimitFareCardTypes" value="${consumeParam.timeLimitFareCardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="timeLimitFareCardTypes" value="${i}" <c:if test="${fn:indexOf(timeLimitFareCardTypes, str2)!=-1}">checked</c:if>/>${i}类
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<dl style="padding-left: 33px;">
			<dt>用户密码：</dt>
			<dd>
				<input name="userPwd" type="text" class="required digits" minlength="4" maxlength="4" value="${consumeParam.userPwd}"/>
			</dd>
		</dl>
	</div>
	<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_CONSUMEPARAM_SAVE">
	<div class="formBar">
		<div class="panelBar" style="border-style: none;">
			<ul class="toolBar">
				<li><a class="save" href="javascript:;"><span>保存</span></a></li>
			</ul>
		</div>
	</div>
	</security:authorize>
</form>