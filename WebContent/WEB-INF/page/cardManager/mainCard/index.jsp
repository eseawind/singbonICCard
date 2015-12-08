<!-- 卡制作 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var deviceSn='${device.sn}';
	var selectedDeptId = -1;
	var selectedBatchId = -1;

	//选择部门
	function selectUserDept(a) {
		selectedDeptId = a.attr('deptId');
		selectedBatchId = a.attr('batchId');
		$('#userList #pagerForm input[name=deptId]').val(selectedDeptId);
		if($('#userDeptTree input[name=includeSub]').attr('checked')){
			$('#userList #pagerForm input[name=includeSub]').val(1);				
		}else{
			$('#userList #pagerForm input[name=includeSub]').val('');				
		}
		refreshUserList();
	};
	function refreshUserList() {
		divSearch($('#userList #pagerForm'), 'userList');
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
				<jsp:include page="${base }/list.do?deptId=-1&pageNum=1&numPerPage=50" />
			</div>

		</div>
	</div>
</div>