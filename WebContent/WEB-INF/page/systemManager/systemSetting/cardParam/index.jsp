<!-- 制卡参数设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
	$('#cardParamForm button').click(function() {
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
	#cardParamForm .pageFormContent {
		overflow: hidden;
		padding: 0;
	}
	
	#cardParamForm dl {
		width: 300px;
	}
	
	#cardParamForm dt {
		margin: 0 0 0 5px;
		padding: 0;
		width: 80px;
	}
	
	#cardParamForm dd {
		width: 170px;
	}
	
	#cardParamForm .error { /* 	position: relative; */
		/* 	top: 0; */
	}
	
	#cardParamForm input {
		width: 200px;
		position: relative;
	}
	#cardParamForm .button {
 		margin-left: 255px;
	}
	#cardParamForm .pageFormContent dd span.error{
		left: 310px;
	}
</style>
<div style="float:left;display: block; overflow: auto; width: 500px; line-height: 21px;margin: 50px 0 0 200px;">
	<form id="cardParamForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
			<dl style="margin: 10px 0;">
				<dt>卡成本：</dt>
				<dd>
					<input type="hidden" name="id" value="${cardParam.id}"/>
					<input type="text" name="cardCost" value="${cardParam.cardCost}" maxlength="20" class="digits required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>卡押金：</dt>
				<dd>
					<input type="text" name="cardDeposit" value="${cardParam.cardDeposit}" maxlength="20" class="digits required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>预付金额：</dt>
				<dd>
					<input type="text" name="prepayFare" value="${cardParam.prepayFare}" maxlength="20" class="digits required" />
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
