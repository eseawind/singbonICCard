<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var list = $('#userDeptTree li');
	list.each(function() {
		var $this = $(this);
		var parentId = $this.attr('parentId');
		if (parentId == '0') {
			$('.expand').append($this);
		} else {
			var $li = $('li[deptId="' + parentId + '"]');
			if ($('>ul', $li).size() == 0) {
				$('<ul></ul>').appendTo($li);
			}
			$('>ul', $li).append($(this));
		}
	});
</script>

<div id="userDeptTree">
	<c:forEach items="${list }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;" module="mainCard"
			deptId="${d.id }" batchId="${d.batchId }">${d.deptName }</a></li>
	</c:forEach>
</div>
<ul class="tree collapse userDeptTree" layotH="10">
	<li deptId="-1"><a href="javascript:;" module="userDept" deptId="-1">部门列表</a>
		<ul class="expand">

		</ul></li>
</ul>
<div style="position:absolute;top:5px;left: 150px;">
	<input type="checkbox" name="includeSub" style="width: 13px;position:relative; top:2px; "/>包含下级
</div> 
