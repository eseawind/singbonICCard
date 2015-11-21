<!-- 中转设备首页 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	var selectTransferId=0;
	$(function() {
		$('#transferForm .add').click(function() {
			$('#transferForm input').eq(0).val('');
			$('#transferForm input').eq(1).val(1);
			var form = $(this).parents('form');
			if(form.valid()){
				var deviceNum=$('#transferForm input[name=deviceNum]').val().trim();
				var deviceCount=$('#transferList tr[target][deviceNum='+deviceNum+']').length;
				if(deviceCount>0){
					alertMsg.warn('该机器号已存在！');
					return;
				}
				var sn=$('#transferForm input[name=sn]').val().trim();
				deviceCount=$('#transferList tr[target][sn='+sn+']').length;
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
						$('#transferForm').clearForm();
						refreshtransferList();
						alertMsg.correct('添加成功！');
					}else if (e==2) {
						alertMsg.warn('序列号不合法！');
					}else if (e==3) {
						alertMsg.warn('机器号已存在！');
					}else if (e==4) {
						alertMsg.warn('序列号已存在！');
					} else {
						alertMsg.warn('添加失败！');
					}
				}, null,true);				
			}
			
		});
		$('#transferForm .edit').click(function() {
			$('#transferForm input').eq(1).val(1);
			var form = $(this).parents('form');
			if(form.valid()){
				var deviceNum=$('#transferForm input[name=deviceNum]').val().trim();
				var deviceCount=$('#transferList tr[target][id!='+selectTransferId+'][deviceNum='+deviceNum+']').length;
				if(deviceCount>0){
					alertMsg.warn('该机器号已存在！');
					return;
				}
				var sn=$('#transferForm input[name=sn]').val().trim();
				deviceCount=$('#transferList tr[target][id!='+selectTransferId+'][sn='+sn+']').length;
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
						refreshtransferList();
						alertMsg.correct('修改成功！');
					}else if (e==2) {
						alertMsg.warn('序列号不合法！');
					}else if (e==3) {
						alertMsg.warn('机器号已存在！');
					}else if (e==4) {
						alertMsg.warn('序列号已存在！');
					} else {
						alertMsg.warn('修改失败！');
					}
				}, null, true);
			}
		});
		$('#transferForm .delete').click(function() {
			if(selectTransferId==0){
				alertMsg.warn('请选择读卡机！');
				return;
			}
			var deviceName=$('#transferForm input[name=deviceName]').val();
			alertMsg.confirm('确定要删除'+deviceName+'吗？', {
				okCall : function() {
					var sn=$('#transferForm input[name=sn]').val();
					$.post('${base }/deleteTransfer.do?id=' + selectTransferId+'&sn='+sn,function(e) {
						if (e == 1) {
							refreshtransferList();
							$('#transferForm').clearForm();
							selectTransferId=0;
							alertMsg.correct('删除成功！');
						} else if (e == 0) {
							alertMsg.warn('删除失败！');
						} else if (e == 2) {
							alertMsg.warn('该中转有从属设备不能删除！');
						}
					});
				}
			});
		});
	});

	function refreshtransferList() {
		$('#transferList').loadUrl('${base }/transferList.do');
	}

	//选择设备
	function transferClick(tr) {
		selectTransferId=tr.attr('id');
		$('#transferForm input').eq(0).val(selectTransferId);
		$('#transferForm input').eq(2).val(tr.attr('deviceNum'));
		$('#transferForm input').eq(3).val(tr.attr('deviceName'));
		$('#transferForm input').eq(4).val(tr.attr('sn'));
	};
</script>
<!-- <link href="themes/css/custom.css" rel="stylesheet" type="text/css" /> -->
<style type="text/css">
	.transferForm input, .form input {
		width: 230px;
	}
	.transferForm dd span.error {
		left: 65px;
		width: 230px;
		top:25px;
	}
</style>

<div style="background: #fff;">
	<div id="transferList" layoutH="146">
		<jsp:include page="${base}/transferList.do"/>
	</div>
	<div class="form transferForm">
		<form id="transferForm" method="post" action="${base }/addEdit.do" class="pageForm required-validate">
			<div class="pageFormContent" style="padding-bottom: 15px;">
				<dl style="width: 420px;">
					<dt>机器号：</dt>
					<dd style="width: 350px;">
						<input type="hidden" name="id" /> 
						<input type="hidden" name="deviceType"/>
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
				<dl style="width: 420px;">
					<dt>序列号：</dt>
					<dd>
						<input type="text" name="sn" minlength="32" maxlength="32" class="required" />
					</dd>
				</dl>
			</div>
			<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DEVICEMANAGER_TRANSFER_ADD,ROLE_DEVICEMANAGER_TRANSFER_EDIT,ROLE_DEVICEMANAGER_TRANSFER_DEL">
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_TRANSFER_ADD,ROLE_ADMIN">
								<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_TRANSFER_EDIT,ROLE_ADMIN">
								<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_TRANSFER_DEL,ROLE_ADMIN">
								<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
							</security:authorize>
						</ul>
					</div>
				</div>
			</security:authorize>
		</form>
	</div>
</div>
