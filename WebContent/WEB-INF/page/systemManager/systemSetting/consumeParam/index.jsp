<!-- 消费参数设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">
$(function() {
	$('#consumeParamForm .add').click(
			function() {
				validateCallback($(this).parents('form'), function(e) {
					if (e == 1) {
						alertMsg.correct('保存成功！');
					} else {
						alertMsg.error('保存失败！');
					}
				}, null, false);
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
		width: 700px;
		padding:0;
	}
	#consumeParamForm .cardTypesBox .cardTypesTitle{
		padding:5px 0;
	}
	#consumeParamForm .cardTypesBox .cardTypes{
		width: 500px;
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
				<dt class="cardTypesTitle">授权卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="cardMinFareCardTypes" value="${consumeParam.cardMinFareCardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="cardMinFareCardTypes" value="${i}" <c:if test="${fn:indexOf(cardMinFareCardTypes, str2)!=-1}">checked</c:if>/>${i}类卡
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
				<dt class="cardTypesTitle">授权卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="dayLimitFareCardTypes" value="${consumeParam.dayLimitFareCardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="dayLimitFareCardTypes" value="${i}" <c:if test="${fn:indexOf(dayLimitFareCardTypes, str2)!=-1}">checked</c:if>/>${i}类卡
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
				<dt class="cardTypesTitle">授权卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="timeLimitFareCardTypes" value="${consumeParam.timeLimitFareCardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="timeLimitFareCardTypes" value="${i}" <c:if test="${fn:indexOf(timeLimitFareCardTypes, str2)!=-1}">checked</c:if>/>${i}类卡
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<dl style="padding-left: 33px;">
			<dt>用户密码：</dt>
			<dd>
				<input name="userPwd" type="text" class="required digits" minlength="5" maxlength="5" value="${consumeParam.userPwd}"/>
			</dd>
		</dl>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="buttonActive">
					<div class="buttonContent add">
						<button type="button">保存</button>
					</div>
				</div></li>
		</ul>
	</div>
</form>