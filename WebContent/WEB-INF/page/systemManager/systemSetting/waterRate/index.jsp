<!-- 一控一水控费率设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$('#waterRateForm .add').click(
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
	#waterRateForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#waterRateForm dl {
		width: 350px;
	}
	
/* 	#waterRateForm fieldset dl { */
/* 		padding-left: 30px; */
/* 	} */
	
	#waterRateForm fieldset dl.firstRow {
		width: 240px;
	}
	
	#waterRateForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 90px;
	}
	
	#waterRateForm fieldset dl.firstRow dt {
		width: 60px;
	}
	
	#waterRateForm fieldset dl.firstRow .textInput{
		width: 60px;
	}
	
	#waterRateForm dd {
		width: 250px;
	}
	
	#waterRateForm dl.firstRow dd {
		width: 150px;
	}
	
	#waterRateForm dl.firstRow span {
		float: left;
		padding-top: 5px;
	}
	
	#waterRateForm dd span.error {
		left: 200px;
	}
	
	#waterRateForm dl.firstRow dd span.error {
		left: 130px;
		width: 100px;
	}
	#waterRateForm .cardTypesBox{
		width: 1010px;
	}
	#waterRateForm .cardTypesBox .cardTypes{
		width: 910px;
	}
</style>
<form id="waterRateForm" method="post" action="${base }/save.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="100">
		<dl style="padding-left: 33px;">
			<dt>消费模式：</dt>
			<dd>
				<input name="id" type="hidden" value="${waterRate.id}"/>
				<input name="consumeType" type="radio" <c:if test="${waterRate.consumeType==0}">checked</c:if> value="0"/>余额
				<input name="consumeType" type="radio" <c:if test="${waterRate.consumeType==1}">checked</c:if> value="1"/>时间
				<input name="consumeType" type="radio" <c:if test="${waterRate.consumeType==2}">checked</c:if> value="2"/>流量
			</dd>
		</dl>
		<dl>
			<dt>流水方式：</dt>
			<dd>
				<input name="goWaterType" type="radio" <c:if test="${waterRate.goWaterType==0}">checked</c:if> value="0"/>刷卡流水
				<input name="goWaterType" type="radio" <c:if test="${waterRate.goWaterType==1}">checked</c:if> value="1"/>按键流水
			</dd>
		</dl>
		<dl>
			<dt>停水方式：</dt>
			<dd>
				<input name="stopWaterType" type="radio" <c:if test="${waterRate.stopWaterType==0}">checked</c:if> value="0"/>拿卡停水
				<input name="stopWaterType" type="radio" <c:if test="${waterRate.stopWaterType==1}">checked</c:if> value="1"/>拿卡后到预定流量停水
			</dd>
		</dl>
		<fieldset>
			<legend>费率1</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate1Status" type="radio" <c:if test="${waterRate.rate1Status==0}">checked</c:if> value="1"/>启用
					<input name="rate1Status" type="radio" <c:if test="${waterRate.rate1Status==1}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>消费金额：</dt>
				<dd>
					<input name="rate1ConsumeFare" type="text" class="required digits" value="${waterRate.rate1ConsumeFare}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>消费周期：</dt>
				<dd>
					<input name="rate1ConsumeCycle" type="text" class="required digits" value="${waterRate.rate1ConsumeCycle}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>次日重置：</dt>
				<dd>
					<input name="rate1NextDayReset" type="radio" <c:if test="${waterRate.rate1NextDayReset==0}">checked</c:if> value="1"/>是
					<input name="rate1NextDayReset" type="radio" <c:if test="${waterRate.rate1NextDayReset==1}">checked</c:if> value="0"/>否
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率2</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate2Status" type="radio" <c:if test="${waterRate.rate2Status==0}">checked</c:if> value="1"/>启用
					<input name="rate2Status" type="radio" <c:if test="${waterRate.rate2Status==1}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>开始时间：</dt>
				<dd>
					<input name="rate2BeginTime" type="text" class="required date" datefmt="HH:mm" value="${waterRate.rate2BeginTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>结束时间：</dt>
				<dd>
					<input name="rate2EndTime" type="text" class="required date" datefmt="HH:mm" value="${waterRate.rate2EndTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>费率值：</dt>
				<dd>
					<input name="rate2Value1" type="text" style="width: 40px;" class="required digits" value="${waterRate.rate2Value1}"/>
					<span>/</span>
					<input name="rate2Value2" type="text" style="width: 40px;" class="required digits" value="${waterRate.rate2Value2}"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt>授权卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="rate2CardTypes" value="${waterRate.rate2CardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="rate2CardTypes" value="${i}" <c:if test="${fn:indexOf(rate2CardTypes, str2)!=-1}">checked</c:if>/>${i}类卡
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率3</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate3Status" type="radio" <c:if test="${waterRate.rate3Status==0}">checked</c:if> value="1"/>启用
					<input name="rate3Status" type="radio" <c:if test="${waterRate.rate3Status==1}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>开始时间：</dt>
				<dd>
					<input name="rate3BeginTime" type="text" class="required date" datefmt="HH:mm" value="${waterRate.rate3BeginTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>结束时间：</dt>
				<dd>
					<input name="rate3EndTime" type="text" class="required date" datefmt="HH:mm" value="${waterRate.rate3EndTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>费率值：</dt>
				<dd>
					<input name="rate3Value1" type="text" style="width: 40px;" class="required digits" value="${waterRate.rate3Value1}"/>
					<span>/</span>
					<input name="rate3Value2" type="text" style="width: 40px;" class="required digits" value="${waterRate.rate3Value2}"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt>授权卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="rate3CardTypes" value="${waterRate.rate3CardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="rate3CardTypes" value="${i}" <c:if test="${fn:indexOf(rate3CardTypes, str2)!=-1}">checked</c:if>/>${i}类卡
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率4</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate4Status" type="radio" <c:if test="${waterRate.rate4Status==0}">checked</c:if> value="1"/>启用
					<input name="rate4Status" type="radio" <c:if test="${waterRate.rate4Status==1}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>开始时间：</dt>
				<dd>
					<input name="rate4BeginTime" type="text" class="required date" datefmt="HH:mm" value="${waterRate.rate4BeginTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>结束时间：</dt>
				<dd>
					<input name="rate4EndTime" type="text" class="required date" datefmt="HH:mm" value="${waterRate.rate4EndTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>费率值：</dt>
				<dd>
					<input name="rate4Value1" type="text" style="width: 40px;" class="required digits" value="${waterRate.rate4Value1}"/>
					<span>/</span>
					<input name="rate4Value2" type="text" style="width: 40px;" class="required digits" value="${waterRate.rate4Value2}"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt>授权卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="rate4CardTypes" value="${waterRate.rate4CardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="rate4CardTypes" value="${i}" <c:if test="${fn:indexOf(rate4CardTypes, str2)!=-1}">checked</c:if>/>${i}类卡
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率5</legend>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate5DeductFare" type="text" class="required digits" value="${waterRate.rate5DeductFare}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费间隔：</dt>
				<dd>
					<input name="rate5DeductCycle" type="text" class="required digits" value="${waterRate.rate5DeductCycle}"/>
				</dd>
			</dl>
		</fieldset>
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