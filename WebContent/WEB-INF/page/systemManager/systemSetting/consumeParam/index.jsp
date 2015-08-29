<!-- 消费参数设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">

</script>

<style type="text/css">

</style>
<form id="deviceGroup" method="post" action="${base }/addEdit.do" class="pageForm required-validate">
	<div class="pageFormContent">
		<fieldset>
			<legend>卡底金</legend>
			<dl>
				<dt>金额/元：</dt>
				<dd>
					<input name="id" type="hidden" value="${consumeParam.id }"/> 
					<input name="cardMinFare" type="text" class="required digits" />
				</dd>
			</dl>
			<dl>
				<dt>授权卡类型：</dt>
				<dd>
					<c:forEach begin="0" end="15" step="1" var="i">
						<input type="checkbox" name="cardMinFareCardTypes" value="${i}"/>${i}类卡
					</c:forEach>
				</dd>
			</dl>
		</fieldset>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="buttonActive">
					<div class="buttonContent add">
						<button type="button">添加</button>
					</div>
				</div></li>
			<li><div class="button">
					<div class="buttonContent edit">
						<button type="button">修改</button>
					</div>
				</div></li>
			<li><div class="button">
					<div class="buttonContent del">
						<button type="button">删除</button>
					</div>
				</div></li>
		</ul>
	</div>
</form>