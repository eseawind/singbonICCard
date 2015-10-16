<!-- 一控一水控费率设置编辑 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="w" value="${waterRateGroup}"/>
<script type="text/javascript">
	$(function() {
		setDisplay('${w.consumeType}');
		setNumDisplay('${w.updateNum}');
		$('#waterRateGroupForm .save').click(
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
	
	$('#waterRateGroupForm .selectAll').click(function(){
		if($(this).attr('checked')){
			$(this).siblings().attr("checked",true);
		}else{
			$(this).siblings().attr("checked",false);			
		}
	});
	$('#waterRateGroupForm input[name=consumeType]').click(function(){
		var type=$(this).val();
		setDisplay(type);
	});
	function setDisplay(type){
		if(type==33){
// 			$('#waterRateGroupForm #waterPrecision').show();
			$('#waterRateGroupForm input[name^=rate][name*=Water]').removeClass('disabled');
			$('#waterRateGroupForm input[name=waterPrecision]').removeClass('disabled');
			$('#waterRateGroupForm input[name^=rate][name*=Fare]').addClass('disabled');
			$('#waterRateGroupForm input[name^=rate][name*=Cycle]').addClass('disabled');
		}else{
// 			$('#waterRateGroupForm #waterPrecision').hide();
			$('#waterRateGroupForm input[name^=rate][name*=Water]').addClass('disabled');
			$('#waterRateGroupForm input[name=waterPrecision]').addClass('disabled');
			$('#waterRateGroupForm input[name^=rate][name*=Fare]').removeClass('disabled');
			$('#waterRateGroupForm input[name^=rate][name*=Cycle]').removeClass('disabled');
		}
	}
	$('#waterRateGroupForm input[name=updateNum]').click(function(){
		var type=$(this).val();		
		setNumDisplay(type);
	});
	
	function setNumDisplay(type){
		if(type==1){
			$('#waterRateGroupForm input[name=deviceNum]').removeClass('disabled');
		}else{
			$('#waterRateGroupForm input[name=deviceNum]').addClass('disabled');
		}
	}
</script>

<style type="text/css">
	#waterRateGroupForm .disabled{
		background-color: #D1D1D1;
	}
	#waterRateGroupForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#waterRateGroupForm dl {
		width: 270px;
	}
	
	
	#waterRateGroupForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 60px;
	}
	
	
	#waterRateGroupForm dd {
		width: 180px;
	}
	
	#waterRateGroupForm dd span.error {
		left: 180px;
	}
	
	#waterRateGroupForm fieldset dl.firstRow {
		width: 180px;
	}
	#waterRateGroupForm fieldset dl.firstRow dt {
		width: 60px;
	}
	
	#waterRateGroupForm fieldset dl.firstRow .textInput{
		width: 80px;
	}
	
	#waterRateGroupForm dl.firstRow dd {
		width: 110px;
	}
	
	#waterRateGroupForm dl.firstRow .ratio {
		float: left;
		padding-top: 5px;
	}
	
	#waterRateGroupForm dl.firstRow dd span.error {
		left: 100px;
		width: 80px;
	}
	#waterRateGroupForm .cardTypesBox{
		width: 860px;
	}
	#waterRateGroupForm .cardTypesBox .cardTypes{
		width: 760px;
	}
</style>

<form id="waterRateGroupForm" method="post" action="${base }/save.do" class="pageForm required-validate">
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
					<dl>
						<dt>流水方式：</dt>
						<dd>
							<input name="goWaterType" type="radio" <c:if test="${w.goWaterType==0}">checked</c:if> value="0"/>刷卡流水
							<input name="goWaterType" type="radio" <c:if test="${w.goWaterType==1}">checked</c:if> value="1"/>按键流水
						</dd>
					</dl>
					<dl>
						<dt>停水方式：</dt>
						<dd>
							<input name="stopWaterType" type="radio" <c:if test="${w.stopWaterType==0}">checked</c:if> value="0"/>拿卡延时停水
							<input name="stopWaterType" type="radio" <c:if test="${w.stopWaterType==1}">checked</c:if> value="1"/>拿卡停水
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
			<legend>费率1</legend>
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
			<dl class="firstRow">
				<dt>次日重置：</dt>
				<dd>
					<input name="rate1NextDayReset" type="radio" <c:if test="${w.rate1NextDayReset==0}">checked</c:if> value="1"/>是
					<input name="rate1NextDayReset" type="radio" <c:if test="${w.rate1NextDayReset==1}">checked</c:if> value="0"/>否
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>启用：</dt>
				<dd>
					<input name="rate1Status" type="radio" <c:if test="${w.rate1Status==1}">checked</c:if> value="1"/>是
					<input name="rate1Status" type="radio" <c:if test="${w.rate1Status==0}">checked</c:if> value="0"/>否
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt style="width: 80px;">启用卡类型：</dt>
				<dd class="cardTypes">
					<input type="checkbox" class="selectAll">全选
				 	<c:set var="rate4CardTypes" value="${w.rate4CardTypes}"/>
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="rate4CardTypes" value="${i}" <c:if test="${fn:indexOf(rate4CardTypes, str2)!=-1}">checked</c:if>/>${i}类
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率2</legend>
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
			<dl class="firstRow">
				<dt>开始时间：</dt>
				<dd>
					<input name="rate2BeginTime" type="text" class="required date" datefmt="HH:mm" value="${w.rate2BeginTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>结束时间：</dt>
				<dd>
					<input name="rate2EndTime" type="text" class="required date" datefmt="HH:mm" value="${w.rate2EndTime}"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt style="width: 80px;">启用卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="rate2CardTypes" value="${w.rate2CardTypes}"/>
				 	<input type="checkbox" class="selectAll">全选
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="rate2CardTypes" value="${i}" <c:if test="${fn:indexOf(rate2CardTypes, str2)!=-1}">checked</c:if>/>${i}类
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率3</legend>
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
			<dl class="firstRow">
				<dt>开始时间：</dt>
				<dd>
					<input name="rate3BeginTime" type="text" class="required date" datefmt="HH:mm" value="${w.rate3BeginTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>结束时间：</dt>
				<dd>
					<input name="rate3EndTime" type="text" class="required date" datefmt="HH:mm" value="${w.rate3EndTime}"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt style="width: 80px;">启用卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="rate3CardTypes" value="${w.rate3CardTypes}"/>
				 	<input type="checkbox" class="selectAll">全选
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="rate3CardTypes" value="${i}" <c:if test="${fn:indexOf(rate3CardTypes, str2)!=-1}">checked</c:if>/>${i}类
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率4</legend>
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
			<dl class="firstRow">
				<dt>开始时间：</dt>
				<dd>
					<input name="rate4BeginTime" type="text" class="required date" datefmt="HH:mm" value="${w.rate4BeginTime}"/>
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>结束时间：</dt>
				<dd>
					<input name="rate4EndTime" type="text" class="required date" datefmt="HH:mm" value="${w.rate4EndTime}"/>
				</dd>
			</dl>
			<dl class="cardTypesBox">
				<dt style="width: 80px;">启用卡类型：</dt>
				<dd class="cardTypes">
				 	<c:set var="rate4CardTypes" value="${w.rate4CardTypes}"/>
				 	<input type="checkbox" class="selectAll">全选
					<c:forEach begin="0" end="15" step="1" var="i">
						<c:set var="str2" value=",${i},"/>
						<input type="checkbox" name="rate4CardTypes" value="${i}" <c:if test="${fn:indexOf(rate4CardTypes, str2)!=-1}">checked</c:if>/>${i}类
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>费率5</legend>
			<dl class="firstRow">
				<dt>扣费金额：</dt>
				<dd>
					<input name="rate5Fare" type="text" class="required digits" value="${w.rate5Fare}"/>分
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费周期：</dt>
				<dd>
					<input name="rate5Cycle" type="text" class="required digits" value="${w.rate5Cycle}"/>秒
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>扣费水量：</dt>
				<dd>
					<input name="rate5Water" type="text" class="required digits" value="${w.rate5Water}"/>毫升
				</dd>
			</dl>
		</fieldset>
		<fieldset style="padding-right: 70px;">
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
				<dt>校时：</dt>
				<dd>
					<input name="enableCheckTime" type="radio" <c:if test="${w.enableCheckTime==1}">checked</c:if> value="1"/>启用
					<input name="enableCheckTime" type="radio" <c:if test="${w.enableCheckTime==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow" style="width: 180px;">
				<dt style="width: 85px;">优先消费补助：</dt>
				<dd style="width: 70px;">
					<input name="subsidyFirst" type="radio" <c:if test="${w.subsidyFirst==0}">checked</c:if> value="0"/>是
					<input name="subsidyFirst" type="radio" <c:if test="${w.subsidyFirst==1}">checked</c:if> value="1"/>否
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>补助清零：</dt>
				<dd>
					<input name="subsidyReset" type="radio" <c:if test="${w.subsidyReset==1}">checked</c:if> value="1"/>启用
					<input name="subsidyReset" type="radio" <c:if test="${w.subsidyReset==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>卡底金：</dt>
				<dd>
					<input name="enableCardMinFare" type="radio" <c:if test="${w.enableCardMinFare==1}">checked</c:if> value="1"/>启用
					<input name="enableCardMinFare" type="radio" <c:if test="${w.enableCardMinFare==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>次限额：</dt>
				<dd>
					<input name="enableTimeLimitFare" type="radio" <c:if test="${w.enableTimeLimitFare==1}">checked</c:if> value="1"/>启用
					<input name="enableTimeLimitFare" type="radio" <c:if test="${w.enableTimeLimitFare==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>日限额：</dt>
				<dd>
					<input name="enableDayLimitFare" type="radio" <c:if test="${w.enableDayLimitFare==1}">checked</c:if> value="1"/>启用
					<input name="enableDayLimitFare" type="radio" <c:if test="${w.enableDayLimitFare==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>优惠方案：</dt>
				<dd>
					<input name="enableDiscount" type="radio" <c:if test="${w.enableDiscount==1}">checked</c:if> value="1"/>启用
					<input name="enableDiscount" type="radio" <c:if test="${w.enableDiscount==0}">checked</c:if> value="0"/>禁用
				</dd>
			</dl>
			<dl class="firstRow">
				<dt>餐别限次：</dt>
				<dd>
					<input name="enableMeal" type="radio" <c:if test="${w.enableMeal==1}">checked</c:if> value="1"/>启用
					<input name="enableMeal" type="radio" <c:if test="${w.enableMeal==0}">checked</c:if> value="0"/>禁用
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