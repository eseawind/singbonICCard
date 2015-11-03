<!-- 消费机管理 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	var selectGroupId=0;
	var selectDeviceId=0;
	$(function() {
		//分组
		$('#groupForm .add').click(function() {
			$('#groupForm input').eq(0).val('');
			validateCallback($(this).parents('form'), function(e) {
				if (e==1) {
					$('#groupForm').clearForm();
					refreshgroupList();
					alertMsg.correct('添加成功！');
				} else {
					alertMsg.warn('添加失败！');
				}
			}, null);
		});
		$('#groupForm .edit').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshgroupList();
					alertMsg.correct('修改成功！');
				} else {
					alertMsg.warn('修改失败！');
				}
			}, null);
		});
		$('#groupForm .delete').click(function() {
			if(selectGroupId==0){
				alertMsg.warn('请选择分组！');
				return;
			}
			var groupName=$('#groupForm input[name=groupName]').val();
			alertMsg.confirm('确定要删除'+groupName+'吗？', {
				okCall : function() {
					$.post('${base }/deleteGroup.do?id=' + selectGroupId,function(e) {
						//0失败1成功2有设备引用
						if (e == 1) {
							refreshgroupList();
							$('#groupForm').clearForm();
							selectGroupId=0;
							alertMsg.correct('删除成功！');
						} else if (e == 0) {
							alertMsg.warn('删除失败');
						} else if (e == 2) {
							alertMsg.warn('有消费机关联此分组不能删除！');
						}
					});
				}
			});
		});
		
		//设备
		$('#posForm .add').click(function() {
			$('#posForm input').eq(0).val('');
			$('#posForm input').eq(1).val(selectGroupId);		
			
			var form = $(this).parents('form');
			if(form.valid()){
				var deviceNum=$('#posForm input[name=deviceNum]').val().trim();
				var deviceCount=$('#posList tr[target][deviceNum='+deviceNum+']').length;
				if(deviceCount>0){
					alertMsg.warn('该机器号已存在！');
					return;
				}
				var sn=$('#posForm input[name=sn]').val().trim();
				deviceCount=$('#posList tr[target][sn='+sn+']').length;
				if(deviceCount>0){
					alertMsg.warn('该序列号已存在！');
					return;
				}else{
					var reg=/^[0-9a-fA-F]{32}$/;
					if(!reg.test(sn)){
						alertMsg.warn('序列号不合法！');
						return;
					}
				}
				
				validateCallback(form, function(e) {
					if (e==1) {
						$('#posForm').clearForm();
						refreshPosList();
						alertMsg.correct('添加成功！');
					} else {
						alertMsg.warn('添加失败！');
					}
				}, null,true);				
			}
			
		});
		$('#posForm .edit').click(function() {
			var form = $(this).parents('form');
			if(form.valid()){
				var deviceNum=$('#posForm input[name=deviceNum]').val().trim();
				var deviceCount=$('#posList tr[target][id!='+selectDeviceId+'][deviceNum='+deviceNum+']').length;
				if(deviceCount>0){
					alertMsg.warn('该机器号已存在！');
					return;
				}
				var sn=$('#posForm input[name=sn]').val().trim();
				deviceCount=$('#posList tr[target][id!='+selectDeviceId+'][sn='+sn+']').length;
				if(deviceCount>0){
					alertMsg.warn('该序列号已存在！');
					return;
				}else{
					var reg=/^[0-9a-fA-F]{32}$/;
					if(!reg.test(sn)){
						alertMsg.warn('序列号不合法！');
						return;
					}
				}
				
				validateCallback(form, function(e) {
					if (e == 1) {
						refreshPosList();
						alertMsg.correct('修改成功！');
					} else {
						alertMsg.warn('修改失败！');
					}
				}, null, true);
			}
		});
		$('#posForm .delete').click(function() {
			if(selectDeviceId==0){
				alertMsg.warn('请选择设备！');
				return;
			}
			var deviceName=$('#posForm input[name=deviceName]').val();
			alertMsg.confirm('确定要删除'+deviceName+'吗？', {
				okCall : function() {
					$.post('${base }/deleteDevice.do?id=' + selectDeviceId,function(e) {
						if (e == 1) {
							refreshPosList();
							$('#posForm').clearForm();
							selectDeviceId=0;
							alertMsg.correct('删除成功！');
						} else if (e == 0) {
							alertMsg.warn('删除失败');
						}
					});
				}
			});
		});
	});
	function refreshgroupList() {
		$('#groupList').loadUrl('${base }/groupList.do');
	}
	function refreshPosList() {
		$('#posList').loadUrl('${base }/posList.do?groupId='+selectGroupId);
	}

	//选择分组
	function posGroupClick(tr) {
		selectGroupId=tr.attr('id');
		$('#groupForm input').eq(0).val(selectGroupId);
		$('#groupForm input').eq(1).val(tr.attr('groupName'));
		refreshPosList();
	};
	//选择设备
	function posListClick(tr) {
		selectDeviceId=tr.attr('id');
		$('#posForm input').eq(0).val(selectDeviceId);
		$('#posForm input').eq(2).val(tr.attr('deviceNum'));
		$('#posForm input').eq(3).val(tr.attr('deviceName'));
		$('#posForm input').eq(5).val(tr.attr('sn'));
		var enable = tr.attr('enable');
		if(enable==0){
			$('#posForm input[name=status]').attr('checked',false);
		}else{
			$('#posForm input[name=status]').attr('checked',true);			
		}
		var select = $('#posForm select');
		var posParamGroupId=tr.attr('posParamGroupId');
		select.eq(0).val(posParamGroupId);
		select.eq(0).prev().attr('value',posParamGroupId).html($('option[value=' + posParamGroupId + ']', select.eq(0)).html());

		var deviceType=tr.attr('deviceType');
		select.eq(1).val(deviceType);
		select.eq(1).prev().attr('value',deviceType).html($('option[value=' + deviceType + ']', select.eq(1)).html());
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.posForm input {
		width: 230px;
	}
	.posForm dd span.error {
		left: 180px;
		width: 220px;
	}
</style>

<div>
	<div style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="groupList" layoutH="131">
			<jsp:include page="${base }/groupList.do" />
		</div>
		<div class="form">
			<form id="groupForm" method="post" action="${base }/addEditGroup.do" class="pageForm required-validate">
				<div class="pageFormContent">
					<dl>
						<dt>分组名称：</dt>
						<dd>
							<input type="hidden" name="id" /> 
							<input type="text" name="groupName" maxlength="20" class="required" />
						</dd>
					</dl>
				</div>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DEVICEMANAGER_GROUP_ADD,ROLE_DEVICEMANAGER_GROUP_EDIT,ROLE_DEVICEMANAGER_GROUP_DEL">
					<div class="formBar">
						<div class="panelBar" style="border-style: none;">
							<ul class="toolBar">
								<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_GROUP_ADD,ROLE_ADMIN">
									<li><a class="add" href="javascript:;"><span>添加</span></a></li>
								</security:authorize>
								<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_GROUP_EDIT,ROLE_ADMIN">
									<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
								</security:authorize>
								<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_GROUP_DEL,ROLE_ADMIN">
									<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
								</security:authorize>
							</ul>
						</div>
					</div>
				</security:authorize>
			</form>
		</div>
	</div>

	<div id="posList" layoutH="161">
	</div>
	<div class="form posForm">
		<form id="posForm" method="post" action="${base }/addEditDevice.do" class="pageForm required-validate">
			<div class="pageFormContent" style="width: 900px;">
				<dl style="width: 420px;">
					<dt>机器号：</dt>
					<dd style="width: 350px;">
						<input type="hidden" name="id" /> 
						<input type="hidden" name="groupId" /> 
						<input type="text" name="deviceNum" min="1" max="99999999" class="required digits" />
						<span style="float: left;margin: 5px;">(范围 1-99999999)</span>
					</dd>
				</dl>
				<dl style="width: 350px;">
					<dt>设备名称：</dt>
					<dd>
						<input type="text" name="deviceName" maxlength="20" class="required" />
					</dd>
				</dl>
				<dl style="width: 100px;">
					<dd>
						<input type="checkbox" name="status" checked="checked" style="width: 13px;" />是否启用
					</dd>
				</dl>
				<dl style="width: 420px;">
					<dt>序列号：</dt>
					<dd>
						<input type="text" name="sn" minlength="32" maxlength="32" class="required" />
					</dd>
				</dl>
				<dl style="width: 240px;">
					<dt>参数分组：</dt>
					<dd>
						<select class="combox" name="posParamGroupId" outerw="128" innerw="145">
							<c:forEach items="${posParamGroupList }" var="p">
								<option value="${p.id }">${p.groupName }</option>
							</c:forEach>
						</select>
					</dd>
				</dl>
				<dl style="width: 240px;">
					<dt>设备类型：</dt>
					<dd>
						<select class="combox" name="deviceType"  outerw="128" innerw="145">
							<option value="2">点餐机</option>
							<option value="3">水控机</option>
						</select>
					</dd>
				</dl>
			</div>
			<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DEVICEMANAGER_POS_ADD,ROLE_DEVICEMANAGER_POS_EDIT,ROLE_DEVICEMANAGER_POS_DEL">
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_POS_ADD,ROLE_ADMIN">
								<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_POS_EDIT,ROLE_ADMIN">
								<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_POS_DEL,ROLE_ADMIN">
								<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
							</security:authorize>
						</ul>
					</div>
				</div>
			</security:authorize>
		</form>
	</div>
</div>
