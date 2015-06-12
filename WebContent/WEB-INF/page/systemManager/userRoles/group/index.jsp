<!-- 授权分组 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var selectedDeptId = -1;
	$(function() {
		$("#userDeptForm .add").click(function() {
			if ($("#userDeptForm input").eq(1).val() == -1) {
				alertMsg.warn('请选择上级人员部门');
				return;
			}
			$("#userDeptForm input").eq(0).val("");
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					$("#userDeptForm input").eq(1).val(-1);
					refreshUserDeptList();
					refreshUserDeptTreeList();
					emptyForm();
				} else {

				}
			}, null);
		});
		$("#userDeptForm .edit").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					$("#userDeptForm input").eq(1).val(-1);
					refreshUserDeptList();
					refreshUserDeptTreeList();
					emptyForm();
				} else {

				}
			}, null);
		});
		$("#userDeptForm .delete").click(
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
											$("#userDeptForm input").eq(1).val(
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
		$("#userDeptForm input").eq(0).val("");
		$("#userDeptForm input").eq(1).val(-1);
		$("#userDeptForm input").eq(2).val("");
		// 		$("#userDeptForm select").eq(0).val(0);
	}

	//选择部门
	function selectUserDept(a) {
		selectedDeptId = a.attr("deptId");
		emptyForm();
		$("#userDeptForm input").eq(1).val(selectedDeptId);
		if (selectedDeptId != 0) {
			$("#userDeptForm input").eq(0).val(selectedDeptId);
			$("#userDeptForm input").eq(2).val(a.html());
			var select = $("#userDeptForm select");
			select
					.prev()
					.val(a.attr("batchId"))
					.html(
							$("option[value=" + a.attr("batchId") + "]", select)
									.html());
		}
		refreshUserDeptList();
	};
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="userDeptTree" layoutH="30">
			<ul class="tree treeCheck treeFolder expand funcTree">
				<li><a href="javascript:;" tvalue="ROLE_SYSTEMMANAGER">系统管理</a>
					<ul>
						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">系统设置</a>
							<ul>
								<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAMETER">系统参数</a></li>
								<li><a href="javascript:;" tvalue="ROLE_BATCH">批次设置</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_BATCH_ADD">添加</a></li>
										<li><a href="javascript:;" tvalue="ROLE_BATCH_EDIT">修改</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_USERDEPT">人员部门设置</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_USERDEPT_ADD">添加</a></li>
										<li><a href="javascript:;" tvalue="ROLE_USERDEPT_EDIT">修改</a></li>
										<li><a href="javascript:;" tvalue="ROLE_USERDEPT_DEL">删除</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_DISCOUNT">优惠方案设置</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_DISCOUNT_ADD">添加</a></li>
										<li><a href="javascript:;" tvalue="ROLE_DISCOUNT_EDIT">修改</a></li>
										<li><a href="javascript:;" tvalue="ROLE_DISCOUNT_DEL">删除</a></li>
									</ul></li>
							</ul></li>
					</ul></li>
				<li><a href="javascript:;" tvalue="ROLE_CARDCENTER">制卡中心</a>
					<ul>
						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">功能卡制作</a></li>
						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">卡管理</a></li>
					</ul></li>
				<li><a href="javascript:;" tvalue="ROLE_CARDCENTER">结算中心</a>
					<ul>
<!-- 						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">功能卡制作</a></li> -->
<!-- 						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">卡管理</a></li> -->
					</ul></li>
			</ul>
		</div>
	</div>

	<div id="groupList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/list.do" />
	</div>
</div>
