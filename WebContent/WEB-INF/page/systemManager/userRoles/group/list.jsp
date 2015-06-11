<!-- 授权分组列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	$(function() {
		$("#authGroupForm .add").click(function() {
			
			$("#authGroupForm input").eq(0).val("");
			$("#authTree input:checked").each(function(){
				alert();
			});
// 			validateCallback($(this).parents("form"), function(e) {
// 				if (e == 1) {
// 					$("#authGroupForm input").eq(1).val(-1);
// 					refreshUserDeptList();
// 					refreshUserDeptTreeList();
// 					emptyForm();
// 				} else {

// 				}
// 			}, null);
		});
		$("#authGroupForm .edit").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					$("#authGroupForm input").eq(1).val(-1);
					refreshUserDeptList();
					refreshUserDeptTreeList();
					emptyForm();
				} else {

				}
			}, null);
		});
		$("#authGroupForm .delete").click(
				function() {
					if (selectedDeptId < 0) {
						alertMsg.warn('请选择人员部门');
						return;
					}
					var size = $(
							".userDeptTree li[deptId=" + selectedDeptId
									+ "] ul").size();
					if (size > 0) {
						alertMsg.warn('包含有下级部门不能删除');
						return;
					}
					alertMsg.confirm("确定要删除吗？", {
						okCall : function() {
							$.post("${base }/delete.do?id=" + selectedDeptId,
									function(e) {
										//0失败1成功2包含下级部门3包含人员
										if (e == 1) {
											$("#authGroupForm input").eq(1).val(
													-1);
											refreshUserDeptList();
											refreshUserDeptTreeList();
											emptyForm();
										} else if (e == 0) {
											alertMsg.warn("删除失败");
										} else if (e == 2) {
											alertMsg.warn("包含有下级部门不能删除");
										} else if (e == 3) {
											alertMsg.warn("包含有人员不能删除");
										}
									});
						}
					});
				});
	});
	function refreshUserDeptTreeList() {
		$("#userDeptTree").loadUrl("${base }/treeList.do");
	}
	function refreshUserDeptList() {
		$("#userDeptList")
				.loadUrl("${base}/list.do?parentId=" + selectedDeptId);
	}
	function emptyForm() {
		$("#authGroupForm input").eq(0).val("");
		$("#authGroupForm input").eq(1).val(-1);
		$("#authGroupForm input").eq(2).val("");
		// 		$("#authGroupForm select").eq(0).val(0);
	}

	function authGroupClick(tr) {
		$("#authGroupForm input").eq(0).val(tr.attr("groupId"));
		$("#authGroupForm input").eq(2).val(tr.find("div").html());
	}
</script>
<style type="text/css">
</style>
<table class="table" width="99%" layoutH="120" rel="jbsxBox">
	<thead>
		<tr>
			<th width="100">分组名称</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="g">
			<tr target="authGroup" groupId="${g.id }">
				<td>${g.groupName }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="form">
	<form id="authGroupForm" method="post" action="${base }/addEdit.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
			<dl>
				<dt>分组名称：</dt>
				<dd>
					<input type="hidden" name="id" /><input type="hidden" name="roles" /><input type="text"
						name="groupName" maxlength="20" class="required" />
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