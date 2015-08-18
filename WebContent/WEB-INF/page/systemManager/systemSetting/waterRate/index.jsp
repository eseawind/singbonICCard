<!-- 水控费率2、3、4 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function() {
		$('#waterRateForm .save').click(function() {
			if ($(this).parents('form').valid()) {
				if ($('#waterRateForm input[name=beginTime]').val() >= $('#waterRateForm input[name=endTime]').val()) {
					alertMsg.warn('起始时间应小于结束时间！');
					return;
				}
			} else {
				return;
			}
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					alertMsg.correct('保存成功！');
					$('#waterRateForm input').eq(0).val('');
					refreshwaterRateList();
					$('#waterRateForm input:not(:checkbox)').each(function(){
						$(this).val('');
					});
					$('#waterRateForm input:checkbox').each(function(){
						$(this).attr('checked',false);
					});
				} else {
					alertMsg.error('保存失败！');
				}
			}, null,true);
		});
	});
	function refreshwaterRateList() {
		$('#waterRateList').loadUrl('${base}/list.do');
	}
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	#authCard input{
		width:13px;
	}
</style>

<div class="form"
	style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
	<form id="waterRateForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent" style="padding-top: 20px;">
			<dl style="margin: 5px 0;">
				<dt>费率名称：</dt>
				<dd>
					<input type="hidden" name="id" />
					<input type="text" name="waterRateName" maxlength="20" class="required" />
				</dd>
			</dl>
			<dl style="margin: 5px 0;">
				<dt>起始时间：</dt>
				<dd>
					<input type="text" name="beginTime" maxlength="20"
						class="date required" datefmt="HH:mm" readonly="readonly" />
				</dd>
			</dl>
			<dl style="margin: 5px 0;">
				<dt>结束时间：</dt>
				<dd>
					<input type="text" name="endTime" maxlength="20"
						class="date required" datefmt="HH:mm" readonly="readonly" />
				</dd>
			</dl>
			<dl style="margin: 5px 0;">
				<dt>费率值：</dt>
				<dd>
					<input type="text" name="rate1" maxlength="5" class="digits required"/>
					<br>
					<input type="text" name="rate2" maxlength="5" class="digits required"/>
				</dd>
			</dl>
			<dl style="margin: 20px 0 140px;">
				<dt>授权卡：</dt>
				<dd id="authCard">
					<input type="checkbox" name="authCard" value="0"/>0类卡
					<input type="checkbox" name="authCard" value="1"/>1类卡
					<input type="checkbox" name="authCard" value="2"/>2类卡
					<input type="checkbox" name="authCard" value="3"/>3类卡
					<input type="checkbox" name="authCard" value="4"/>4类卡
					<input type="checkbox" name="authCard" value="5"/>5类卡
					<input type="checkbox" name="authCard" value="6"/>6类卡
					<input type="checkbox" name="authCard" value="7"/>7类卡
					<input type="checkbox" name="authCard" value="8"/>8类卡
					<input type="checkbox" name="authCard" value="9"/>9类卡
					<input type="checkbox" name="authCard" value="10"/>10类卡
					<br>
					<input type="checkbox" name="authCard" value="11"/>11类卡
					<input type="checkbox" name="authCard" value="12"/>12类卡
					<br>
					<input type="checkbox" name="authCard" value="13"/>13类卡
					<input type="checkbox" name="authCard" value="14"/>14类卡
					<br>					
					<input type="checkbox" name="authCard" value="15"/>15类卡
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
<div id="waterRateList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/list.do" />
</div>