<!-- 生成补助 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var list = $('#generateUserDeptTree li');
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

<div id="generateUserDeptTree">
	<c:forEach items="${userDeptList }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;"
			deptId="${d.id }" >${d.deptName }</a></li>
	</c:forEach>
</div>

<div>
	<div style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<ul class="tree collapse treeCheck treeFolder generateUserDeptTree" layoutH="201">
			<li deptId="-1"><a href="javascript:;" deptId="-1">部门列表</a>
				<ul class="expand">
				</ul>
			</li>
		</ul>
		<div class="form">
			<form id="userDeptForm" method="post" action="${base }/addEdit.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl>
						<dt>部门名称：</dt>
						<dd>
							<input type="hidden" name="id" /> <input type="hidden" name="parentId"/> <input
								type="text" name="deptName" maxlength="20" class="required" />
						</dd>
					</dl>
					<dl>
						<dt>批次：</dt>
						<dd>
							<select class="combox" name="batchId" outerw="78" innerw="95">
								<c:forEach items="${batchList }" var="b">
									<option value="${b.id }">${b.batchName }</option>
								</c:forEach>
							</select>
						</dd>
					</dl>
				</div>
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
						</ul>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="generateUserList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/subsidyUserList.do?pageNum=1&numPerPage=50" />
	</div>
</div>
