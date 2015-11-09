<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var selectUserDeptTree=$('.selectUserDeptTree');
	var list = $('#selectUserDeptTreeLi li');
	if(list.length!=0){
		$('li', selectUserDeptTree).append("<ul class='expand'></ul>");
	}
	list.each(function() {
		var $this = $(this);
		var parentId = $this.attr('parentId');		
		if (parentId == '0') {
			$('.expand', selectUserDeptTree).append($this);
		} else {
			var $li = $('li[deptId="' + parentId + '"]', selectUserDeptTree);
			if ($('>ul', $li).size() == 0) {
				$('<ul></ul>', selectUserDeptTree).appendTo($li);
			}
			$('>ul', $li).append($(this));
		}
	});
</script>

<div id="selectUserDeptTreeLi">
	<c:forEach items="${list }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;" onclick="$.bringBack({deptId:'${d.id}', deptName:'${d.deptName }'})">${d.deptName }</a></li>
	</c:forEach>
</div>

<!-- <ul class="tree collapse selectUserDeptTree"> -->
<ul class="tree expand selectUserDeptTree">
	<li deptId="0"><a href="javascript:;" onclick="$.bringBack({deptId:'-1', deptName:'全部部门'})">部门列表</a>
	</li>
</ul>