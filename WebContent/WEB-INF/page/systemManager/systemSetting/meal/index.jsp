<!-- 餐别设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function() {
		$('#mealForm .save').click(function() {
			if ($(this).parents('form').valid()) {
				if ($('#mealForm input[name=beginTime]').val() >= $('#mealForm input[name=endTime]').val()) {
					alertMsg.warn('起始时间应小于结束时间！');
					return;
				}
			} else {
				return;
			}
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					alertMsg.correct('保存成功！');
					$('#mealForm input').eq(0).val('');
					refreshmealList();
					$('#mealForm input').each(function(){
						$(this).val('');
					});
				} else {
					alertMsg.error('保存失败！');
				}
			}, null,true);
		});
	});
	function refreshmealList() {
		$('#mealList').loadUrl('${base}/list.do');
	}
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">

</style>

<div class="form"
	style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
	<form id="mealForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent" style="padding-top: 100px;">
			<dl style="margin: 10px 0;">
				<dt>餐别名称：</dt>
				<dd>
					<input type="hidden" name="id" />
					<input type="text" name="mealName" maxlength="20" class="required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>起始时间：</dt>
				<dd>
					<input type="text" name="beginTime" maxlength="20"
						class="date required" datefmt="HH:mm:ss" readonly="readonly" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>结束时间：</dt>
				<dd>
					<input type="text" name="endTime" maxlength="20"
						class="date required" datefmt="HH:mm:ss" readonly="readonly" />
				</dd>
			</dl>
			<dl style="margin: 10px 0 50px;">
				<dt>次数限制：</dt>
				<dd>
					<input type="text" name="timeLimit" maxlength="20"
						class="digits required"/>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul class="toolBar">
				<li><div class="buttonActive">
						<div class="buttonContent save">
							<button type="button">保存</button>
						</div>
					</div></li>
			</ul>
		</div>
	</form>
</div>
<div id="mealList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/list.do" />
</div>