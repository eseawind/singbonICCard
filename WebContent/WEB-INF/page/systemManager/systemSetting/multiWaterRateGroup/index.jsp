<!-- 一控多水控参数分组 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var selectedmultiWaterRateGroupId = -1;
	$(function() {
		$('#multiWaterRateGroupForm .add').click(function() {
			$('#multiWaterRateGroupForm input').eq(0).val('');
			validateCallback($(this).parents('form'), function(e) {
				if (e > 0) {
					emptyForm();
// 					selectedmultiWaterRateGroupId=e;
// 					refreshMultiWaterRateGroupEdit();
					refreshMultiWaterRateGroupList();
				} else {
					alertMsg.warn('添加失败！');
				}
			}, null);
		});
		$('#multiWaterRateGroupForm .edit').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshMultiWaterRateGroupList();
// 					refreshMultiWaterRateGroupListList();
					emptyForm();
				} else {
					alertMsg.warn('修改失败！');
				}
			}, null);
		});
		$('#multiWaterRateGroupForm .delete').click(
			function() {
				alertMsg.confirm('确定要删除吗？', {
					okCall : function() {
						$.post('${base }/delete.do?id=' + selectedmultiWaterRateGroupId,
							function(e) {
								//0失败1成功2有设备引用
								if (e == 1) {
									refreshMultiWaterRateGroupList();
									emptyForm();
								} else if (e == 0) {
									alertMsg.warn('删除失败');
								} else if (e == 2) {
									alertMsg.warn('有消费机关联此分组不能删除！');
								}
							});
					}
				});
			});
	});
	function refreshMultiWaterRateGroupList() {
		$('#multiWaterRateGroupList').loadUrl('${base }/list.do');
	}
	function refreshMultiWaterRateGroupEdit() {
		$('#multiWaterRateGroupEdit').loadUrl('${base}/edit.do?id=' + selectedmultiWaterRateGroupId,{},function(){
			$('#multiWaterRateGroupEdit').find('[layoutH]').layoutH();
		});
	}
	function emptyForm() {
		$('#multiWaterRateGroupForm input').eq(0).val('');
		$('#multiWaterRateGroupForm input').eq(1).val('');
	}

	//选择分组
	function multiWaterRateGroupClick(a) {
		selectedmultiWaterRateGroupId = a.attr('id');
		$('#multiWaterRateGroupForm input').eq(0).val(selectedmultiWaterRateGroupId);
		$('#multiWaterRateGroupForm input').eq(1).val(a.find('div').html());
		refreshMultiWaterRateGroupEdit();
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="multiWaterRateGroupList" layoutH="170">
			<jsp:include page="${base }/list.do" />
		</div>
		<div class="form">
			<form id="multiWaterRateGroupForm" method="post" action="${base }/addEdit.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl>
						<dt>分组名称：</dt>
						<dd>
							<input type="hidden" name="id" />
							<input type="text" name="groupName" maxlength="20" class="required" />
						</dd>
					</dl>
				</div>
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
						</ul>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="multiWaterRateGroupEdit" class="unitBox" style="margin-left: 246px;">
	</div>
</div>
