<!-- 批次设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
	$(function() {
		$('#batchForm .add').click(
				function() {
					$('#batchForm input').eq(0).val('');

					var form = $(this).parents('form');
					if (form.valid()) {
						var batchName = $('#batchForm input[name=batchName]').val();
						var len = $('#batchList td[batchName="' + batchName + '"]').length;
						if (len > 0) {
							alertMsg.warn('批次名称重复！');
							return;
						}
						if (!comparaDate()) {
							return;
						}
					} else {
						return;
					}
					validateCallback(form, function(e) {
						if (e == 1) {
							alertMsg.correct('添加成功！');
							form.clearForm();
							refreshBatchList();
						} else {
							alertMsg.error('添加失败！');
						}
					}, null, true);
				});

		$('#batchForm .edit').click(
				function() {
					var form = $(this).parents('form');
					if (form.valid()) {
						var batchId = $('#batchForm input[name=id]').val();
						var batchName = $('#batchForm input[name=batchName]').val();
						var len = $('#batchList td[batchId!=' + batchId+ '][batchName="' + batchName + '"]').length;
						if (len > 0) {
							alertMsg.warn('批次名称重复！');
							return;
						}
						if (!comparaDate()) {
							return;
						}
					} else {
						return;
					}
					validateCallback(form, function(e) {
						if (e == 1) {
							alertMsg.correct('修改成功！');
// 							form.clearForm();
							refreshBatchList();
						} else {
							alertMsg.error('修改失败！');
						}
					}, null, true);
				});
		$('#batchForm .delete').click(function(){
			var form = $(this).parents('form');
			var batchId = $('#batchForm input[name=id]').val();
			if(batchId==''){
				alertMsg.error('请选择一个批次！');				
			}else{
				var batchName = $('#batchForm input[name=batchName]').val();
				alertMsg.confirm('确定要挂失'+batchName+'吗？挂失后不允许恢复正常！', {
					okCall : function() {
						$.post('${base }/black.do?batchId=' + batchId,function(e){
							if (e == 1) {
								alertMsg.correct('挂失成功！');
								refreshBatchList();
							} else {
								alertMsg.warn('挂失失败！');
							} 
						});
					}
				});
			}
		});
	});

	function comparaDate() {
		if ($('#batchForm input[name=beginDate]').val() >= $(
				'#batchForm input[name=endDate]').val()) {
			alertMsg.warn('开始日期应小于结束日期！');
			return false;
		}
// 		if ($('#batchForm input[name=endDate]').val() > $(
// 				'#batchForm input[name=invalidDate]').val()) {
// 			alertMsg.warn('结束日期应不大于失效日期！');
// 			return false;
// 		}
		return true;
	}

	function refreshBatchList() {
		$('#batchList').loadUrl('${base}/list.do',{},function(){
			$('#batchList').find('[layoutH]').layoutH();
		});
	}
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">

</style>
<div class="form" layoutH="30"
	style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
	<div layoutH="332"></div>
	<form id="batchForm" method="post" action="${base}/addEdit.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
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
						class="date required" readonly="readonly" />
				</dd>
			</dl>
			<dl style="margin: 10px 0 50px">
				<dt>结束日期：</dt>
				<dd>
					<input type="text" name="endDate" maxlength="20"
						class="date required" readonly="readonly" />
				</dd>
			</dl>
<!-- 			<dl style="margin: 10px 0 50px;"> -->
<!-- 				<dt>失效日期：</dt> -->
<!-- 				<dd> -->
<!-- 					<input type="text" name="invalidDate" maxlength="20" -->
<!-- 						class="date required" readonly="readonly" /> -->
<!-- 				</dd> -->
<!-- 			</dl> -->
		</div>
		<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_BATCH_ADD,ROLE_BATCH_EDIT,ROLE_BATCH_DEL">
		<div class="formBar">
			<div class="panelBar" style="border-style: none;">
				<ul class="toolBar">
					<security:authorize ifAnyGranted="ROLE_BATCH_ADD,ROLE_ADMIN">
						<li><a class="add" href="javascript:;"><span>添加</span></a></li>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_BATCH_EDIT,ROLE_ADMIN">
						<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
					</security:authorize>
					<security:authorize ifAnyGranted="ROLE_BATCH_DEL,ROLE_ADMIN">
						<li><a class="delete" href="javascript:;"><span>挂失</span></a></li>
					</security:authorize>
				</ul>
			</div>
		</div>
		</security:authorize>
	</form>
</div>

<div id="batchList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/list.do" />
</div>
