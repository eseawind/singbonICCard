<!-- 一控多水控费率设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">
$(function() {
	$('#multiWaterRateForm .add').click(
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
	#multiWaterRateForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#multiWaterRateForm dl {
		width: 500px;
	}
	
	#multiWaterRateForm fieldset dl {
		padding-left: 30px;
	}
	
	#multiWaterRateForm fieldset dl.firstRow {
		width: 240px;
	}
	
	#multiWaterRateForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 90px;
	}
	
	#multiWaterRateForm fieldset dl.firstRow dt {
		width: 60px;
	}
	
	#multiWaterRateForm fieldset dl.firstRow .textInput{
/* 		width: 60px; */
	}
	
	#multiWaterRateForm dd {
		width: 250px;
	}
	
	#multiWaterRateForm dl.firstRow dd {
		width: 150px;
	}
	
	#multiWaterRateForm dd span.error {
		left: 200px;
	}
	
	#multiWaterRateForm dl.firstRow dd span.error {
		left: 130px;
		width: 100px;
	}
	#multiWaterRateForm .cardTypesBox{
		width: 1010px;
	}
	#multiWaterRateForm .cardTypesBox .cardTypes{
		width: 910px;
	}
</style>
<form id="multiWaterRateForm" method="post" action="${base }/save.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="138">
		<div style="margin:30px 0 20px 33px;">
			<dl>
				<dt>消费模式：</dt>
				<dd>
					<input name="id" type="hidden" value="${multiWaterRate.id}"/>
					<input name="consumeType" type="radio" <c:if test="${multiWaterRate.consumeType==0}">checked</c:if> value="0"/>余额
					<input name="consumeType" type="radio" <c:if test="${multiWaterRate.consumeType==1}">checked</c:if> value="1"/>时间
					<input name="consumeType" type="radio" <c:if test="${multiWaterRate.consumeType==2}">checked</c:if> value="2"/>流量
				</dd>
			</dl>
			<dl>
				<dt>是否找零：</dt>
				<dd>
					<input name="chargeType" type="radio" <c:if test="${multiWaterRate.chargeType==0}">checked</c:if> value="1"/>启用
					<input name="chargeType" type="radio" <c:if test="${multiWaterRate.chargeType==1}">checked</c:if> value="0"/>不启用
				</dd>
			</dl>
		</div>
		<fieldset>
			<legend>费率设置1</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate1Status" type="radio" <c:if test="${multiWaterRate.rate1Status==1}">checked</c:if> value="1"/>启用
					<input name="rate1Status" type="radio" <c:if test="${multiWaterRate.rate1Status==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate1DeductFare" type="text" class="required digits" value="${multiWaterRate.rate1DeductFare}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费间隔：</dt>
				<dd>
					<input name="rate1DeductCycle" type="text" class="required digits" value="${multiWaterRate.rate1DeductCycle}"/>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率设置2</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate2Status" type="radio" <c:if test="${multiWaterRate.rate2Status==1}">checked</c:if> value="1"/>启用
					<input name="rate2Status" type="radio" <c:if test="${multiWaterRate.rate2Status==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate2DeductFare" type="text" class="required digits" value="${multiWaterRate.rate2DeductFare}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费间隔：</dt>
				<dd>
					<input name="rate2DeductCycle" type="text" class="required digits" value="${multiWaterRate.rate2DeductCycle}"/>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率设置3</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate3Status" type="radio" <c:if test="${multiWaterRate.rate3Status==1}">checked</c:if> value="1"/>启用
					<input name="rate3Status" type="radio" <c:if test="${multiWaterRate.rate3Status==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate3DeductFare" type="text" class="required digits" value="${multiWaterRate.rate3DeductFare}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费间隔：</dt>
				<dd>
					<input name="rate3DeductCycle" type="text" class="required digits" value="${multiWaterRate.rate3DeductCycle}"/>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率设置4</legend>
			<dl class="firstRow">
				<dt>状态：</dt>
				<dd>
					<input name="rate4Status" type="radio" <c:if test="${multiWaterRate.rate4Status==1}">checked</c:if> value="1"/>启用
					<input name="rate4Status" type="radio" <c:if test="${multiWaterRate.rate4Status==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate4DeductFare" type="text" class="required digits" value="${multiWaterRate.rate4DeductFare}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费间隔：</dt>
				<dd>
					<input name="rate4DeductCycle" type="text" class="required digits" value="${multiWaterRate.rate4DeductCycle}"/>
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