<!-- 系统用户管理 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	$(function() {
		$('#sysUserForm .add').click(function() {
			$('#sysUserForm input').eq(0).val('');
			var form = $(this).parents('form');
			if(form.valid()){
				var err=false;
				var loginName=$.trim($('#sysUserForm input[name=loginName]').val());
				$('#sysUserList td[loginName] div').each(function(e){
					if($.trim($(this).html())==loginName){
						alertMsg.warn('用户名已存在！');
						err=true;
						return false;
					}
				});
				if(err)
					return;
				var deviceId=$('#sysUserForm select').val();
				if(deviceId!=0){
					var deviceCount=$('#sysUserList tr[target][deviceId='+deviceId+']').length;
					if(deviceCount>0){
						alertMsg.warn('该读卡机已被绑定！');
						return;
					}
				}
				validateCallback(form, function(e) {
					if (e == 1) {
						alertMsg.correct('添加成功！');					
						form.clearForm();
						refreshsysUserList();
					} else {
						alertMsg.error('添加失败！');
					}
				}, null,true);
			}
		});
	
		$('#sysUserForm .edit').click(function() {
			var form = $(this).parents('form');
			if(form.valid()){
				var err=false;
				var operId=$.trim($('#sysUserForm input[name=operId]').val());
				var currLoginName=$.trim($('#sysUserForm input[name=loginName]').val());
				$('#sysUserList tr[operId!='+operId+'] td[loginName] div').each(function(e){
					if($.trim($(this).html())==currLoginName){
						alertMsg.warn('用户名已存在！');
						err=true;
						return false;
					}
				});
				if(err)
					return;
				var deviceId=$('#sysUserForm select').val();
				if(deviceId!=0){
					var deviceCount=$('#sysUserList tr[target][operId!='+operId+'][deviceId='+deviceId+']').length;
					if(deviceCount>0){
						alertMsg.warn('该读卡机已被绑定！');
						return;
					}
				}
				validateCallback(form, function(e) {
					if (e == 1) {
						alertMsg.correct('修改成功！');					
						refreshsysUserList();
					} else {
						alertMsg.error('修改失败！');
					}
				}, null, true);
			}
		});
		$('#sysUserForm .delete').click(function(){
			var form = $(this).parents('form');
			var id = $('#sysUserForm input[name=operId]').val();
			if(id==''){
				alertMsg.error('请选择用户！');				
			}else{
				var loginName = $('#sysUserForm input[name=loginName]').val();
				alertMsg.confirm('确定要删除'+loginName+'吗？', {
					okCall : function() {
						$.post('${base }/delete.do?operId=' + id,function(e){
							if (e == 1) {
								alertMsg.correct('删除成功！');
								refreshsysUserList();
							} else {
								alertMsg.warn('删除失败！');
							} 
						});
					}
				});
			}
		});
	});
	
	function refreshsysUserList() {
		$('#sysUserList').loadUrl('${base}/list.do',{},function(){
			$('#sysUserList').find('[layoutH]').layoutH();
		});
	}
	
	//选择用户
	function sysUserClick(tr) {
		$('#sysUserForm input').eq(0).val(tr.attr('operId'));
		$('#sysUserForm input').eq(1).val(tr.attr('loginName'));
		$('#sysUserForm input').eq(2).val(tr.attr('loginPwd'));
		$('#sysUserForm input').eq(3).val(tr.attr('loginPwd'));
		var select = $('#sysUserForm select');
		var deviceId=tr.attr('deviceId');
		select.val(deviceId);
		select.prev().attr('value',deviceId).html($('option[value=' + deviceId + ']', select).html());
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	
</style>

<div>
	<div style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div layoutH="354"></div>
		<div class="form">
			<form id="sysUserForm" method="post" action="${base }/addEdit.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl style="margin: 10px 0;">
						<dt>登录名：</dt>
						<dd>
							<input type="hidden" name="operId" />
							<input type="text" name="loginName" maxlength="20" class="required" />
						</dd>
					</dl>
					<dl style="margin: 10px 0;">
						<dt>登录密码：</dt>
						<dd>
							<input type="password" id="loginPwd" name="loginPwd" maxlength="20" class="required alphanumeric" />
						</dd>
					</dl>
					<dl style="margin: 10px 0;">
						<dt>重复密码：</dt>
						<dd>
							<input type="password" name="reLoginPwd" maxlength="20" class="required alphanumeric" equalto="#loginPwd"/>
						</dd>
					</dl>
					<dl style="margin: 10px 0 50px;">
						<dt>读卡机：</dt>
						<dd>
							<select class="combox" name="deviceId" outerw="78" innerw="95">
								<option value="0">无</option>
								<c:forEach items="${deviceList }" var="d">
									<option value="${d.id }">${d.deviceName }</option>
								</c:forEach>
							</select>
						</dd>
					</dl>
				</div>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SYSUSER_ADD,ROLE_SYSUSER_EDIT,ROLE_SYSUSER_DEL">
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<security:authorize ifAnyGranted="ROLE_SYSUSER_ADD,ROLE_ADMIN">
								<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_SYSUSER_EDIT,ROLE_ADMIN">
								<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_SYSUSER_DEL,ROLE_ADMIN">
								<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
							</security:authorize>
						</ul>
					</div>
				</div>
				</security:authorize>
			</form>
		</div>
	</div>

	<div id="sysUserList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/list.do" />
	</div>
</div>
