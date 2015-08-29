<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">

</script>

<style type="text/css">
.dialog .pageFormContent {
	border-width: 0;
}

.dialog .pageFormContent dl {
	width: 270px;
}

.dialog .pageFormContent dt {
	width: 75px;
}

.dialog .pageFormContent dd {
	width: 120px;
}

.dialog .pageFormContent dd span.error {
	width: 85px;
	left: 85px;
}
</style>
<form id="deviceGroup" method="post" action="${base }/addEdit.do" class="pageForm required-validate">
	<div class="pageFormContent">
		<fieldset>
			<legend>设备分组信息</legend>
			<dl>
				<dt>分组名称：</dt>
				<dd>
					<input name="id" type="hidden" /> 
					<input name="groupName" type="text" class="required" />
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
<form id="device" method="post" action="${base }/addEdit.do" class="pageForm required-validate">
	<div class="pageFormContent">
		<fieldset>
			<legend>设备信息</legend>
			<dl>
				<dt>设备名称：</dt>
				<dd>
					<input name="id" type="hidden" /> 
					<input name="deviceName" type="text" class="required" />
				</dd>
			</dl>
			<dl>
				<dt>姓名简拼：</dt>
				<dd>
					<input name="shortName" type="text" class="required" value="${user.shortName }" />
				</dd>
			</dl>
			<dl>
				<dt>编号：</dt>
				<dd>
					<input class="required" name="userNO" type="text" value="${user.userNO }" />
				</dd>
			</dl>
			<dl>
				<dt>性别：</dt>
				<dd>
					<label><input type="radio" name="sex"
						<c:if test="${user.sex==null || user.sex==0}">checked="checked"</c:if> value="0" />男</label> <label><input
						type="radio" name="sex" value="1" <c:if test="${user.sex==1}">checked="checked"</c:if> />女</label>
				</dd>
			</dl>
			<dl>
				<dt>身份证号：</dt>
				<dd>
					<input name="cardID" type="text" value="${user.cardID==null?'123456789012345678':user.cardID }" />
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