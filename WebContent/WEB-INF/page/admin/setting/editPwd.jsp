<!-- 修改密码 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	$(function() {
		$('#pwdForm .save').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					alertMsg.correct('修改成功！');					
				}else if (e == 2) {
					alertMsg.warn('原密码不正确！');
				} else {
					alertMsg.error('添加失败！');
				}
			}, null);
		});
	});
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	.dialog .dialogContent{
		padding: 1px;
	}
	.dialog .pageFormContent{
		border-style: none;
		margin: 20px 0 10px 40px;
	}
	#cardReader #result div{
		color: #15428b;
		font-size: 13px;
		font-weight: bold;
		margin: 0 0 15px 60px;
	}
	#cardReader #result img{
		float: right;
		display: none;
	}
</style>

<div>
	<div style=" line-height: 21px;">
		<div class="form">
			<form id="pwdForm" method="post" action="${base }/savePwd.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl>
						<dt>原密码：</dt>
						<dd>
							<input type="password" name="oldPwd" maxlength="20" class="required alphanumeric" />
						</dd>
					</dl>
					<dl>
						<dt>密码：</dt>
						<dd>
							<input type="password" id="loginPwd" name="newPwd" maxlength="20" class="required alphanumeric" />
						</dd>
					</dl>
					<dl>
						<dt>重复密码：</dt>
						<dd>
							<input type="password" name="reLoginPwd" maxlength="20" class="required alphanumeric" equalto="#loginPwd"/>
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
	</div>
</div>
