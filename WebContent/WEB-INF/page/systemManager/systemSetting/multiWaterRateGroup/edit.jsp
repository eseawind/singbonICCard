<!-- 一控多水控水龙头设置编辑 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="w" value="${multiWaterRateGroup}"/>
<script type="text/javascript">
	$(function() {
		setDisplay('${w.consumeType}');
		setNumDisplay('${w.updateNum}');
		$('#multiWaterRateGroupForm .save').click(
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
	
	$('#multiWaterRateGroupForm .selectAll').click(function(){
		if($(this).attr('checked')){
			$(this).siblings().attr("checked",true);
		}else{
			$(this).siblings().attr("checked",false);			
		}
	});
	$('#multiWaterRateGroupForm input[name=consumeType]').click(function(){
		var type=$(this).val();
		setDisplay(type);
	});
	function setDisplay(type){
		if(type==33){
			$('#multiWaterRateGroupForm input[name^=rate][name*=Water]').removeClass('disabled');
			$('#multiWaterRateGroupForm input[name=waterPrecision]').removeClass('disabled');
			$('#multiWaterRateGroupForm input[name^=rate][name*=Fare]').addClass('disabled');
			$('#multiWaterRateGroupForm input[name^=rate][name*=Cycle]').addClass('disabled');
		}else{
			$('#multiWaterRateGroupForm input[name^=rate][name*=Water]').addClass('disabled');
			$('#multiWaterRateGroupForm input[name=waterPrecision]').addClass('disabled');
			$('#multiWaterRateGroupForm input[name^=rate][name*=Fare]').removeClass('disabled');
			$('#multiWaterRateGroupForm input[name^=rate][name*=Cycle]').removeClass('disabled');
		}
	}
	$('#multiWaterRateGroupForm input[name=updateNum]').click(function(){
		var type=$(this).val();		
		setNumDisplay(type);
	});
	
	function setNumDisplay(type){
		if(type==1){
			$('#multiWaterRateGroupForm input[name=deviceNum]').removeClass('disabled');
		}else{
			$('#multiWaterRateGroupForm input[name=deviceNum]').addClass('disabled');
		}
	}
</script>

<style type="text/css">
	#multiWaterRateGroupForm .disabled{
		background-color: #D1D1D1;
	}
	#multiWaterRateGroupForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#multiWaterRateGroupForm dl {
		width: 270px;
	}
	
	
	#multiWaterRateGroupForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 60px;
	}
	
	
	#multiWaterRateGroupForm dd {
		width: 180px;
	}
	
	#multiWaterRateGroupForm dd span.error {
		left: 180px;
	}
	
	#multiWaterRateGroupForm fieldset dl.firstRow {
		width: 200px;
	}
	#multiWaterRateGroupForm fieldset dl.firstRow dt {
		width: 60px;
	}
	
	#multiWaterRateGroupForm fieldset dl.firstRow .textInput{
		width: 100px;
	}
	
	#multiWaterRateGroupForm dl.firstRow dd {
		width: 130px;
	}
	
	#multiWaterRateGroupForm dl.firstRow .ratio {
		float: left;
		padding-top: 5px;
	}
	
	#multiWaterRateGroupForm dl.firstRow dd span.error {
		left: 100px;
		width: 80px;
	}
	#multiWaterRateGroupForm .cardTypesBox{
		width: 860px;
	}
	#multiWaterRateGroupForm .cardTypesBox .cardTypes{
		width: 760px;
	}
</style>

<form id="multiWaterRateGroupForm" method="post" action="${base }/addEdit.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="138">
		<table>
			<tr>
				<td>
					<dl>
						<dt>消费模式：</dt>
						<dd>
							<input name="id" type="hidden" value="${w.id}"/>
							<input name="consumeType" type="radio" <c:if test="${w.consumeType==97}">checked</c:if> value="97"/>余额
							<input name="consumeType" type="radio" <c:if test="${w.consumeType==73}">checked</c:if> value="73"/>时间
							<input name="consumeType" type="radio" <c:if test="${w.consumeType==33}">checked</c:if> value="33"/>流量
						</dd>
					</dl>
					<dl id="waterPrecision" style="width: 500px;">
						<dt style="width: 90px;margin-left: 10px;">流量扣费精度：</dt>
						<dd style="width: 300px;">
							<input name="waterPrecision" type="text" class="required digits" value="${w.waterPrecision}"/>（单位：毫升/脉冲）
						</dd>
					</dl>
				</td>
			</tr>
		</table>
		<fieldset>
			<legend>水龙头1</legend>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate1Fare" type="text" class="required digits" value="${w.rate1Fare}"/>分
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费周期：</dt>
				<dd>
					<input name="rate1Cycle" type="text" class="required digits" value="${w.rate1Cycle}"/>秒
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费水量：</dt>
				<dd>
					<input name="rate1Water" type="text" class="required digits" value="${w.rate1Water}"/>毫升
				</dd>
			</dl>
			<dl>
				<dt style="margin-left: 20px;width: 40px;">启用：</dt>
				<dd>
					<input name="rate1Status" type="radio" <c:if test="${w.rate1Status==1}">checked</c:if> value="1"/>是
					<input name="rate1Status" type="radio" <c:if test="${w.rate1Status==0}">checked</c:if> value="0"/>否
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>水龙头2</legend>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate2Fare" type="text" class="required digits" value="${w.rate2Fare}"/>分
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费周期：</dt>
				<dd>
					<input name="rate2Cycle" type="text" class="required digits" value="${w.rate2Cycle}"/>秒
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费水量：</dt>
				<dd>
					<input name="rate2Water" type="text" class="required digits" value="${w.rate2Water}"/>毫升
				</dd>
			</dl>
			<dl>
				<dt style="margin-left: 20px;width: 40px;">启用：</dt>
				<dd>
					<input name="rate2Status" type="radio" <c:if test="${w.rate2Status==1}">checked</c:if> value="1"/>是
					<input name="rate2Status" type="radio" <c:if test="${w.rate2Status==0}">checked</c:if> value="0"/>否
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>水龙头3</legend>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate3Fare" type="text" class="required digits" value="${w.rate3Fare}"/>分
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费周期：</dt>
				<dd>
					<input name="rate3Cycle" type="text" class="required digits" value="${w.rate3Cycle}"/>秒
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费水量：</dt>
				<dd>
					<input name="rate3Water" type="text" class="required digits" value="${w.rate3Water}"/>毫升
				</dd>
			</dl>
			<dl>
				<dt style="margin-left: 20px;width: 40px;">启用：</dt>
				<dd>
					<input name="rate3Status" type="radio" <c:if test="${w.rate3Status==1}">checked</c:if> value="1"/>是
					<input name="rate3Status" type="radio" <c:if test="${w.rate3Status==0}">checked</c:if> value="0"/>否
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>水龙头4</legend>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate4Fare" type="text" class="required digits" value="${w.rate4Fare}"/>分
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费周期：</dt>
				<dd>
					<input name="rate4Cycle" type="text" class="required digits" value="${w.rate4Cycle}"/>秒
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费水量：</dt>
				<dd>
					<input name="rate4Water" type="text" class="required digits" value="${w.rate4Water}"/>毫升
				</dd>
			</dl>
			<dl>
				<dt style="margin-left: 20px;width: 40px;">启用：</dt>
				<dd>
					<input name="rate4Status" type="radio" <c:if test="${w.rate4Status==1}">checked</c:if> value="1"/>是
					<input name="rate4Status" type="radio" <c:if test="${w.rate4Status==0}">checked</c:if> value="0"/>否
				</dd>
			</dl>
		</fieldset>
		<fieldset style="padding-right: 150px;">
			<legend>其他</legend>
			<dl class="firstRow">
				<dt>配置密码：</dt>
				<dd>
					<input name="pwd" type="text" class="required digits" value="${w.pwd}"/>
				</dd>
			</dl>
			<dl class="firstRow" style="width: 200px;">
				<dt>波特率：</dt>
				<dd style="width: 120px;">
					<input name="bound" type="radio" <c:if test="${w.bound==1}">checked</c:if> value="1"/>9600
					<input name="bound" type="radio" <c:if test="${w.bound==3}">checked</c:if> value="3"/>115200
				</dd>
			</dl>
			<dl class="firstRow" style="width: 170px;">
				<dt style="width: 80px;">更新机器号：</dt>
				<dd style="width: 80px;">
					<input name="updateNum" type="radio" <c:if test="${w.updateNum==1}">checked</c:if> value="1"/>是
					<input name="updateNum" type="radio" <c:if test="${w.updateNum==0}">checked</c:if> value="0"/>否
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>机器号：</dt>
				<dd>
					<input name="deviceNum" type="text" class="required digits" value="${w.deviceNum}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt style="width: 90px;">优先消费补助：</dt>
				<dd style="width: 80px;">
					<input name="subsidyFirst" type="radio" <c:if test="${w.subsidyFirst==0}">checked</c:if> value="0"/>是
					<input style="margin-left: 16px;" name="subsidyFirst" type="radio" <c:if test="${w.subsidyFirst==1}">checked</c:if> value="1"/>否
				</dd>
			</dl>
			<dl class="firstRow" >
				<dt>补助清零：</dt>
				<dd>
					<input name="subsidyReset" type="radio" <c:if test="${w.subsidyReset==1}">checked</c:if> value="1"/>启用
					<input name="subsidyReset" type="radio" <c:if test="${w.subsidyReset==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt style="width: 40px;">找零：</dt>
				<dd>
					<input name="enableCharge" type="radio" <c:if test="${w.enableCharge==1}">checked</c:if> value="1"/>启用
					<input name="enableCharge" type="radio" <c:if test="${w.enableCharge==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt style="width: 40px;">校时：</dt>
				<dd>
					<input name="enableCheckTime" type="radio" <c:if test="${w.enableCheckTime==1}">checked</c:if> value="1"/>启用
					<input name="enableCheckTime" type="radio" <c:if test="${w.enableCheckTime==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
		</fieldset>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="buttonActive">
					<div class="buttonContent save">
						<button type="button">保存</button>
					</div>
				</div></li>
		</ul>
	</div>
</form>