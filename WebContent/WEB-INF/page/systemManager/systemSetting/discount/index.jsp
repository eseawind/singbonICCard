<!-- 优惠方案设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	$(function() {
		$('#discountForm .save').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					alertMsg.correct('保存成功！');
					$('#discountForm input').eq(0).val('');
					refreshdiscountList();
					$('#discountForm input').each(function(){
						$(this).val('');
					});
				} else {
					alertMsg.error('保存失败！');
				}
			}, null);
		});
	});
	function refreshdiscountList() {
		$('#discountList').loadUrl('${base}/list.do',{},function(){
			$('#discountList').find('[layoutH]').layoutH();
		});
	}
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">

</style>

<div class="form"
	style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
	<div layoutH="271"></div>
	<form id="discountForm" method="post" action="${base}/save.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
			<dl style="margin: 10px 0;">
				<dt>补助金额：</dt>
				<dd>
					<input type="hidden" name="id"/>
					<input type="text" name="subsidy" maxlength="20" class="digits required"/>
				</dd>
			</dl>
			<dl style="margin-bottom: 50px;">
				<dt>扣费比例：</dt>
				<dd>
					<select class="combox" outerw="78" innerw="95"
						name="rate" class="required">
						<c:forEach var="i" begin="1" end="200" step="1">
							<option value="${i}" width="95">${i}</option>
						</c:forEach>
					</select>范围1-200
				</dd>
			</dl>
		</div>
		<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DISCOUNT_SAVE">
		<div class="formBar">
			<div class="panelBar" style="border-style: none;">
				<ul class="toolBar">
					<li><a class="save" href="javascript:;"><span>保存</span></a></li>
				</ul>
			</div>
		</div>
		</security:authorize>
	</form>
</div>
<div id="discountList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/list.do" />
</div>