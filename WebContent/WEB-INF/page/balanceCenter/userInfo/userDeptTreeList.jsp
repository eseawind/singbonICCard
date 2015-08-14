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
		<li parentId="${d.parentId }" deptId="${d.id }"><a href="javascript:;" onclick="$.bringBack({deptId:'${d.id}', deptName:'${d.deptName }'})">${d.deptName }</a></li>
	</c:forEach>
</div>
<ul class="tree expand userDeptTree">
	<li><a href="javascript:;" onclick="$.bringBack({deptId:'-1', deptName:'全部部门'})">部门列表</a>
		<ul>

		</ul></li>
</ul>