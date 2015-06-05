<!-- 优惠方案设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function() {
		$("#discountForm .edit").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					$("#discountForm input").eq(0).val("");
					refreshdiscountList();
				} else {
					
				}
			}, null);
		});
	});
	function refreshdiscountList() {
		$("#discountList").loadUrl("${base}/discountList.do");
	}
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
</style>
<div id="discountList" class="unitBox">
	<jsp:include page="${base}/discountList.do" />
</div>
<div class="form"
	style="display: block; overflow: auto; border: solid 1px #CCC; line-height: 21px; background: #fff;margin-top:5px;">
	<form id="discountForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent" layoutH="480" style="width: 500px;margin:0 auto;overflow: hidden;padding-top: 30px;">
			<dl>
				<dt>扣费比例：</dt>
				<dd>
					<input type="hidden" name="id" /> 
					<select class="combox" name="rate" class="required">
						<c:forEach var="i" begin="1" end="200" step="1">
							<option value="${i}">${i}</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>补助金额：</dt>
				<dd>
					<input type="text" name="subsidy" maxlength="20" class="digits"/>
				</dd>
			</dl>
			<dl style="width: 300px;">
				<dt>充值送费：</dt>
				<dd>
					<input style="margin: 0;width: 30px;" type="radio" name="giveCashType" checked="checked" value="0" />充多少送多少<br/>
						<input style="margin: 0;width: 30px;"
						type="radio" name="giveCashType" value="1" />固定值 <input type="text" name="giveCash" maxlength="20" class="digits"/>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<div class="panelBar" style="border-style: none;">
				<ul class="toolBar">
					<li><a class="save" href="javascript:;"><span>保存</span></a></li>
				</ul>
			</div>
		</div>
	</form>
</div>
