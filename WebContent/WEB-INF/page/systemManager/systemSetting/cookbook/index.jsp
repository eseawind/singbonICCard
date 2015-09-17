<!-- 菜肴清单设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function() {
		$('#cookbookForm .save').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					alertMsg.correct('保存成功！');
					$('#cookbookForm input').eq(0).val('');
					refreshcookbookList();
					$('#cookbookForm input').each(function(){
						$(this).val('');
					});
				} else {
					alertMsg.error('保存失败！');
				}
			}, null);
		});
	});
	function refreshcookbookList() {
		$('#cookbookList').loadUrl('${base}/list.do',{},function(){
			$('#cookbookList').find('[layoutH]').layoutH();
		});
	}
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
</style>

<div class="form"
	style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
	<form id="cookbookForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent" style="padding: 200px 0 50px;">
			<dl>
				<dt>菜名：</dt>
				<dd>
					<input type="hidden" name="id"/>
					<input type="text" name="cookbookName" maxlength="20" class="required"/>
				</dd>
			</dl>
			<dl style="width: 300px;">
				<dt>单价：</dt>
				<dd>
					<input type="text" name="price" maxlength="20" class="digits required" max="167772"/>元
				</dd>
			</dl>
			<dl>
				<dt>备注：</dt>
				<dd>
					<input type="text" name="remark" maxlength="20" class=""/>
				</dd>
			</dl>
			<dl>
				<dt>&nbsp;</dt>
				<dd>
					<input type="checkbox" name="status" checked="checked" style="width:13px;"/>是否启用
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
<div id="cookbookList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/list.do" />
</div>