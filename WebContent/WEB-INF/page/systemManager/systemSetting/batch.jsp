<!-- 批次设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function() {
		$(".submitAdd").click(function() {
			$("#batchForm input").eq(0).val("");
			validateCallback($(this).parents("form"), function(e) {
				if(e==1){
					refresh();
				}else{
					
				}
			}, null);
		});
		$(".submitEdit").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if(e==1){
					$("#batchForm input").eq(0).val("");
					refresh();
				}else{
					
				}
			}, null);
		});
	});
	function refresh(){
		$("#batchList").loadUrl("/systemManager/systemSetting/batchList.do");
	}
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
</style>
<div class="form" layoutH="30"
	style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
	<form id="batchForm" method="post" action="/systemManager/systemSetting/addEditBatch.do"
		class="pageForm required-validate">
		<div class="pageFormContent" style="padding-top: 100px;">
			<dl style="margin: 10px 0;">
				<dt>批次名称：</dt>
				<dd>
					<input type="hidden" name="id" /> <input type="text"
						name="batchName" maxlength="20" class="required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>开始日期：</dt>
				<dd>
					<input type="text" name="beginDate" maxlength="20"
						class="date required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>结束日期：</dt>
				<dd>
					<input type="text" name="endDate" maxlength="20"
						class="date required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0 50px;">
				<dt>失效日期：</dt>
				<dd>
					<input type="text" name="invalidDate" maxlength="20"
						class="date required" />
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive">
						<div class="buttonContent">
							<button class="submitAdd" type="button">添加</button>
						</div>
					</div></li>
				<li><div class="buttonActive">
						<div class="buttonContent">
							<button class="submitEdit" type="button">修改</button>
						</div>
					</div></li>
			</ul>
		</div>
	</form>
</div>

<div id="batchList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="/systemManager/systemSetting/batchList.do" />
</div>
