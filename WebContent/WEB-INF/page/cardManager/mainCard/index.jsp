<!-- 卡制作 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var deviceSn="${device.sn}";
	var selectedDeptId = -1;
	var selectedBatchId = -1;
	var searchStr=null;

	//选择部门
	function selectUserDept(a) {
		selectedDeptId = a.attr("deptId");
		selectedBatchId = a.attr("batchId");
		refreshUserList();
	};
	function refreshUserList() {
		$("#userList")
				.loadUrl("${base}/list.do?deptId=" + selectedDeptId+"&searchStr="+searchStr, {}, function(){
					$("#userList").find("[layoutH]").layoutH();
				});
	}
</script>

<style type="text/css">
</style>

<div class="tabs">
	<div class="tabsContent" style="border: none;">
		<div>
			<div
				style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
				<div id="userDeptTree" layoutH="10">
					<jsp:include page="${base }/treeList.do" />
				</div>
			</div>

			<div id="userList" class="unitBox" style="margin-left: 246px;">
				<jsp:include page="${base }/list.do" />
			</div>

		</div>
	</div>
</div>