<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var userDeptTree=$('.userDeptTree');
	var list = $('#userDeptTree li');
	list.each(function() {
		var $this = $(this);
		var parentId = $this.attr('parentId');		
		if (parentId == '0') {
			$('.expand', userDeptTree).append($this);
		} else {
			var $li = $('li[deptId="' + parentId + '"]', userDeptTree);
			if ($('>ul', $li).size() == 0) {
				$('<ul></ul>', userDeptTree).appendTo($li);
			}
			$('>ul', $li).append($(this));
		}
	});
</script>

<div id="userDeptTree">
	<c:forEach items="${list }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;" module="userDept"
			deptId="${d.id }" batchId="${d.batchId }">${d.deptName }</a></li>
	</c:forEach>
</div>
<ul class="tree collapse userDeptTree">
	<li deptId="0"><a href="javascript:;" module="userDept" deptId="0">部门列表</a>
		<ul class="expand">

		</ul></li>
</ul>
