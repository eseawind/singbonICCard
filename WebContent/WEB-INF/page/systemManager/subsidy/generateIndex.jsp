<!-- 生成补助 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var generateUserDeptTree=$('#generateUserDeptTree');
	var list = $('#generateUserDeptTreeLi li');
	list.each(function() {
		var $this = $(this);
		var parentId = $this.attr('parentId');
		if (parentId == '0') {
			$('.expand',generateUserDeptTree).append($this);
		} else {
			var $li = $('li[deptId="' + parentId + '"]', generateUserDeptTree);
			if ($('>ul', $li).size() == 0) {
				$('<ul></ul>', generateUserDeptTree).appendTo($li);
			}
			$('>ul', $li).append($(this));
		}
	});
	
	$('#generateSubsidyForm .add').click(
		function() {
			var form = $(this).parents('form');
			validateCallback(form, function(e) {
				if (e == 2) {
					alertMsg.error('不能重复生成补助信息！');					
				}else if (e == 1) {
					alertMsg.correct('生成补助成功！');
					searchSubsidyUserList();
				} else {
					alertMsg.error('生成补助失败！');
				}
			}, null);
		});

</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css"/>

<div id="generateUserDeptTreeLi">
	<c:forEach items="${userDeptList }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;"
			deptId="${d.id }" >${d.deptName }</a></li>
	</c:forEach>
</div>

<div>
	<div style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<ul id="generateUserDeptTree" class="tree collapse treeCheck treeFolder" layoutH="151">
			<li deptId="-1"><a href="javascript:;" deptId="-1">部门列表</a>
				<ul class="expand">
				</ul>
			</li>
		</ul>
		<div class="form">
			<form id="generateSubsidyForm" method="post" action="${base }/generateSubsidy.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl style="margin: 10px 0 10px">
						<dt>宏冲日期：</dt>
						<dd>
							<input type="text" name="invalidDate" maxlength="20" class="date required" readonly="readonly" />
						</dd>
					</dl>
				</div>
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<li><a class="add" href="javascript:;"><span>生成补助</span></a></li>
						</ul>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="subsidyUserList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/subsidyUserList.do?pageNum=1&numPerPage=50" />
	</div>
</div>
