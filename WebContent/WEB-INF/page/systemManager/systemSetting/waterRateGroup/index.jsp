<!-- 一控一水控参数分组 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	var selectedwaterRateGroupId = -1;
	$(function() {
		$('#waterRateGroupForm .add').click(function() {
			$('#waterRateGroupForm input').eq(0).val('');
			validateCallback($(this).parents('form'), function(e) {
				if (e > 0) {
					emptyForm();
// 					selectedwaterRateGroupId=e;
// 					refreshWaterRateGroupEdit();
					refreshWaterRateGroupList();
				} else {
					alertMsg.warn('添加失败！');
				}
			}, null);
		});
		$('#waterRateGroupForm .edit').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshWaterRateGroupList();
// 					refreshWaterRateGroupListList();
					emptyForm();
				} else {
					alertMsg.warn('修改失败！');
				}
			}, null);
		});
		$('#waterRateGroupForm .delete').click(
			function() {
				alertMsg.confirm('确定要删除吗？', {
					okCall : function() {
						$.post('${base }/delete.do?id=' + selectedwaterRateGroupId,
							function(e) {
								//0失败1成功2有设备引用
								if (e == 1) {
									refreshWaterRateGroupList();
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
	function refreshWaterRateGroupList() {
		$('#waterRateGroupList').loadUrl('${base }/list.do');
	}
	function refreshWaterRateGroupEdit() {
		$('#waterRateGroupEdit').loadUrl('${base}/edit.do?id=' + selectedwaterRateGroupId,{},function(){
			$('#waterRateGroupEdit').find('[layoutH]').layoutH();
		});
	}
	function emptyForm() {
		$('#waterRateGroupForm input').eq(0).val('');
		$('#waterRateGroupForm input').eq(1).val('');
	}

	//选择分组
	function waterRateGroupClick(a) {
		selectedwaterRateGroupId = a.attr('id');
		$('#waterRateGroupForm input').eq(0).val(selectedwaterRateGroupId);
		$('#waterRateGroupForm input').eq(1).val(a.find('div').html());
		refreshWaterRateGroupEdit();
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="waterRateGroupList" layoutH="170">
			<jsp:include page="${base }/list.do" />
		</div>
		<div class="form">
			<form id="waterRateGroupForm" method="post" action="${base }/addEdit.do"
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
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_WATERRATEGROUP_ADD,ROLE_WATERRATEGROUP_EDIT,ROLE_WATERRATEGROUP_DEL">
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<security:authorize ifAnyGranted="ROLE_WATERRATEGROUP_ADD,ROLE_ADMIN">
								<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_WATERRATEGROUP_EDIT,ROLE_ADMIN">
								<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_WATERRATEGROUP_DEL,ROLE_ADMIN">
								<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
							</security:authorize>
						</ul>
					</div>
				</div>
				</security:authorize>
			</form>
		</div>
	</div>

	<div id="waterRateGroupEdit" class="unitBox" style="margin-left: 246px;">
	</div>
</div>
