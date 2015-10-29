<!-- 添加补助 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
var userDeptTree=$('#userDeptTree');
var list = $('#userDeptTreeLi li');
list.each(function() {
	var $this = $(this);
	var parentId = $this.attr('parentId');
	if (parentId == '0') {
		$('.expand',userDeptTree).append($this);
	} else {
		var $li = $('li[deptId="' + parentId + '"]', userDeptTree);
		if ($('>ul', $li).size() == 0) {
			$('<ul></ul>', userDeptTree).appendTo($li);
		}
		$('>ul', $li).append($(this));
	}
});
</script>

<div id="userDeptTreeLi">
	<c:forEach items="${userDeptList }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;"
			deptId="${d.id }" >${d.deptName }</a></li>
	</c:forEach>
</div>

<div>
	<div style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<ul id="userDeptTree" class="tree collapse treeCheck treeFolder" layoutH="64">
			<li deptId="-1"><a href="javascript:;" deptId="-1">部门列表</a>
				<ul class="expand">
				</ul>
			</li>
		</ul>
	</div>

	<div id="userList2" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/userList.do?pageNum=1&numPerPage=50" />
	</div>
</div>
