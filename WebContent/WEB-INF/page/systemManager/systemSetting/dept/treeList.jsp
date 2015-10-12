<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var deptTree=$('.deptTree');
	var list = $('#deptTreeLi li');
	if(list.length!=0){
		$('li', deptTree).append("<ul class='expand'></ul>");
	}
	list.each(function() {
		var $this = $(this);
		var parentId = $this.attr('parentId');		
		if (parentId == '0') {
			$('.expand', deptTree).append($this);
		} else {
			var $li = $('li[deptId="' + parentId + '"]', deptTree);
			if ($('>ul', $li).size() == 0) {
				$('<ul></ul>', deptTree).appendTo($li);
			}
			$('>ul', $li).append($(this));
		}
	});
</script>

<div id="deptTreeLi">
	<c:forEach items="${treeList }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;" module="dept"
			deptId="${d.id }">${d.deptName }</a></li>
	</c:forEach>
</div>
<ul class="tree expand deptTree">
	<li deptId="0"><a href="javascript:;" module="dept" deptId="0">营业部门列表</a>
	</li>
</ul>
