<!-- 添加补助 -->
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
	<c:forEach items="${userDeptList }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;"
			deptId="${d.id }" >${d.deptName }</a></li>
	</c:forEach>
</div>

<div>
	<div style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<ul id="userDeptTree" class="tree collapse treeCheck treeFolder userDeptTree" layoutH="50">
			<li deptId="-1"><a href="javascript:;" deptId="-1">部门列表</a>
				<ul class="expand">
				</ul>
			</li>
		</ul>
	</div>

	<div id="addUserList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/userList.do?pageNum=1&numPerPage=50" />
	</div>
</div>
