<!-- 消费机参数分组 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var selectedPosParamGroupId = -1;
	$(function() {
		$('#posParamGroupForm .add').click(function() {
			$('#posParamGroupForm input').eq(0).val('');
			validateCallback($(this).parents('form'), function(e) {
				if (e > 0) {
					emptyForm();
// 					selectedPosParamGroupId=e;
// 					refreshPosParamGroupEdit();
					refreshPosParamGroupList();
				} else {
					alertMsg.warn('添加失败！');
				}
			}, null);
		});
		$('#posParamGroupForm .edit').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshPosParamGroupList();
// 					refreshPosParamGroupListList();
					emptyForm();
				} else {
					alertMsg.warn('修改失败！');
				}
			}, null);
		});
		$('#posParamGroupForm .delete').click(
			function() {
				alertMsg.confirm('确定要删除吗？', {
					okCall : function() {
						$.post('${base }/delete.do?id=' + selectedPosParamGroupId,
							function(e) {
								//0失败1成功2有设备引用
								if (e == 1) {
									refreshPosParamGroupList();
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
	function refreshPosParamGroupList() {
		$('#posParamGroupList').loadUrl('${base }/list.do');
	}
	function refreshPosParamGroupEdit() {
		$('#posParamGroupEdit').loadUrl('${base}/edit.do?id=' + selectedPosParamGroupId,{},function(){
			$('#posParamGroupEdit').find('[layoutH]').layoutH();
		});
	}
	function emptyForm() {
		$('#posParamGroupForm input').eq(0).val('');
		$('#posParamGroupForm input').eq(1).val('');
	}

	//选择分组
	function posParamGroupClick(a) {
		selectedPosParamGroupId = a.attr('id');
		$('#posParamGroupForm input').eq(0).val(selectedPosParamGroupId);
		$('#posParamGroupForm input').eq(1).val(a.find('div').html());
		refreshPosParamGroupEdit();
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="posParamGroupList" layoutH="170">
			<jsp:include page="${base }/list.do" />
		</div>
		<div class="form">
			<form id="posParamGroupForm" method="post" action="${base }/addEdit.do"
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

	<div id="posParamGroupEdit" class="unitBox" style="margin-left: 246px;">
	</div>
</div>
