<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var list = $("#userDeptTree li");
	list.each(function() {
		var $this = $(this);
		var parendDeptId = $this.attr("parentDeptId");
		if (parendDeptId == "0") {
			$(".expand").append($this);
		} else {
			var $li = $("li[deptId='" + parendDeptId + "']");
			if ($(">ul", $li).size() == 0) {
				$("<ul></ul>").appendTo($li);
			}
			$(">ul", $li).append($(this));
		}
	});
	function selectUserDept(a) {
		selectedDeptId = a.attr("deptId");
		$("#userDeptForm input").eq(0).val(selectedDeptId);
		$("#userDeptForm input").eq(1).val("");
		$("#userDeptForm input").eq(2).val(0);
		if (selectedDeptId != 0) {
			$("#userDeptForm input").eq(1).val(a.html());
			$("#userDeptForm input").eq(2).val(a.attr("batchId"));
		}
		refreshUserDeptList();
	};
</script>

<div id="userDeptTree">
	<c:forEach items="${list }" var="d">
		<li deptId="${d.id }" parentDeptId="${d.parentId }"><a href="javascript:;" module="userDept"
			deptId="${d.id }" batchId="${d.batchId }">${d.deptName }</a></li>
	</c:forEach>
</div>
<ul class="tree collapse" layoutH="150">
	<li deptId="0"><a href="javascript:;" module="userDept" deptId="0">部门列表</a>
		<ul class="expand">

		</ul></li>
</ul>
