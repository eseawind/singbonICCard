<!-- 设备管理 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var selecteddeviceGroupId = -1;
	$(function() {
		$('#deviceGroupForm .add').click(function() {
			if ($('#deviceGroupForm input').eq(1).val() == -1) {
				alertMsg.warn('请选择上级人员部门');
				return;
			}
			$('#deviceGroupForm input').eq(0).val('');
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					$('#deviceGroupForm input').eq(1).val(-1);
					refreshdeviceGroupList();
					refreshdeviceGroupTreeList();
					emptyForm();
				} else {

				}
			}, null);
		});
		$('#deviceGroupForm .edit').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					$('#deviceGroupForm input').eq(1).val(-1);
					refreshdeviceGroupList();
					refreshdeviceGroupTreeList();
					emptyForm();
				} else {

				}
			}, null);
		});
		$('#deviceGroupForm .delete').click(
				function() {
					if (selecteddeviceGroupId < 0) {
						alertMsg.warn('请选择人员部门');
						return;
					}
					var size = $('.deviceGroupTree li[deptId=' + selecteddeviceGroupId+ '] ul').size();
					if (size > 0) {
						alertMsg.warn('包含有下级部门不能删除');
						return;
					}
					alertMsg.confirm('确定要删除吗？', {
						okCall : function() {
							$.post('${base }/delete.do?id=' + selecteddeviceGroupId,
									function(e) {
										//0失败1成功2包含下级部门3包含人员
										if (e == 1) {
											$('#deviceGroupForm input').eq(1).val(-1);
											refreshdeviceGroupList();
											refreshdeviceGroupTreeList();
											emptyForm();
										} else if (e == 0) {
											alertMsg.warn('删除失败');
										} else if (e == 2) {
											alertMsg.warn('包含有下级部门不能删除');
										} else if (e == 3) {
											alertMsg.warn('包含有人员不能删除');
										}
									});
						}
					});
				});
	});
	function refreshdeviceGroupTreeList() {
		$('#deviceGroupTree').loadUrl('${base }/treeList.do');
	}
	function refreshdeviceGroupList() {
		$('#deviceGroupList').loadUrl('${base}/list.do?parentId=' + selecteddeviceGroupId);
	}
	function emptyForm() {
		$('#deviceGroupForm input').eq(0).val('');
		$('#deviceGroupForm input').eq(1).val(-1);
		$('#deviceGroupForm input').eq(2).val('');
	}

	//选择部门
	function selectdeviceGroup(a) {
		selecteddeviceGroupId = a.attr('deptId');
		emptyForm();
		$('#deviceGroupForm input').eq(1).val(selecteddeviceGroupId);
		if (selecteddeviceGroupId != 0) {
			$('#deviceGroupForm input').eq(0).val(selecteddeviceGroupId);
			$('#deviceGroupForm input').eq(2).val(a.html());
			var select = $('#deviceGroupForm select');
			select.prev().val(a.attr('batchId')).html(
							$('option[value=' + a.attr('batchId') + ']', select).html());
		}
		refreshdeviceGroupList();
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="deviceGroupTree" layoutH="0">
			<jsp:include page="${base }/treeList.do" />
		</div>
	</div>

	<div id="deviceGroupList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/deviceForm.do" />
	</div>
</div>
