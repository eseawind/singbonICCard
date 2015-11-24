<!-- 营业部门 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	var selectedDeptId = -1;
	$(function() {
		$('#deptForm .add').click(function() {
			var parentId='0';
			var deptCount=$('.deptTree a').length;
			if(deptCount==1){
				$('#deptForm input').eq(1).val(0);
			}else{
				parentId=$('#deptForm input').eq(1).val();
			}
			if (parentId==null || parentId=='' || parentId == -1) {
				alertMsg.warn('请选择上级人员部门');
				return;
			}
			$('#deptForm input').eq(0).val('');
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshDeptList();
					refreshdeptTreeList();
					emptyForm();
				} else {

				}
			}, null);
		});
		$('#deptForm .edit').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshDeptList();
					refreshdeptTreeList();
					emptyForm();
				} else {

				}
			}, null);
		});
		$('#deptForm .delete').click(
				function() {
					if (selectedDeptId < 0) {
						alertMsg.warn('请选择人员部门');
						return;
					}
					var size = $(
							'.deptTree li[deptId=' + selectedDeptId
									+ '] ul').size();
					if (size > 0) {
						alertMsg.warn('包含有下级部门不能删除');
						return;
					}
					alertMsg.confirm('确定要删除吗？', {
						okCall : function() {
							$.post('${base }/delete.do?id=' + selectedDeptId,
									function(e) {
										//0失败1成功2包含下级部门3包含人员
										if (e == 1) {
											refreshDeptList();
											refreshdeptTreeList();
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
	function refreshdeptTreeList() {
		$('#deptTree').loadUrl('${base }/treeList.do');
	}
	function refreshDeptList() {
		$('#deptList').loadUrl('${base}/list.do?parentId=' + selectedDeptId,{},function(){
			$('#deptList').find('[layoutH]').layoutH();
		});
	}
	function emptyForm() {
		$('#deptForm input').eq(0).val('');
		$('#deptForm input').eq(1).val('-1');
		$('#deptForm input').eq(2).val('');
	}

	//选择部门
	function selectDept(a) {
		selectedDeptId = a.attr('deptId');
		emptyForm();
		$('#deptForm input').eq(1).val(selectedDeptId);
		if (selectedDeptId != 0) {
			$('#deptForm input').eq(0).val(selectedDeptId);
			$('#deptForm input').eq(2).val(a.html());
		}
		refreshDeptList();
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="deptTree" layoutH="170">
			<jsp:include page="${base }/treeList.do" />
		</div>
		<div class="form">
			<form id="deptForm" method="post" action="${base }/addEdit.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl>
						<dt>部门名称：</dt>
						<dd>
							<input type="hidden" name="id" /> <input type="hidden" name="parentId" /> <input
								type="text" name="deptName" maxlength="20" class="required" />
						</dd>
					</dl>
				</div>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DEPT_ADD,ROLE_DEPT_EDIT,ROLE_DEPT_DEL">
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<security:authorize ifAnyGranted="ROLE_DEPT_ADD,ROLE_ADMIN">
								<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_DEPT_EDIT,ROLE_ADMIN">
								<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							</security:authorize>
							<security:authorize ifAnyGranted="ROLE_DEPT_DEL,ROLE_ADMIN">
								<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
							</security:authorize>
						</ul>
					</div>
				</div>
				</security:authorize>
			</form>
		</div>
	</div>

	<div id="deptList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/list.do" />
	</div>
</div>
