<!-- 选择消费机首页 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	var selectDeptId=0;

	function refreshselectPosList() {
		divSearch($('#selectPosList #pagerForm'), 'selectPosList');
	}

	//选择部门
	function selectDeviceDept(deptId) {
		selectDeptId = deptId;
		$('#selectPosList #pagerForm input[name=deptId]').val(selectDeptId);
		if($('.selectPosForm input[name=includeSub]').attr('checked')){
			$('#selectPosList #pagerForm input[name=includeSub]').val(1);				
		}else{
			$('#selectPosList #pagerForm input[name=includeSub]').val('');				
		}
		refreshselectPosList();
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.selectPosForm input,.form input {
		width: 230px;
	}
	.selectPosForm dd span.error {
		left: 65px;
		width: 230px;
		top:25px;
	}
</style>

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
	<c:forEach items="${deptList }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;" onclick="selectDeviceDept(${d.id });">${d.deptName }</a></li>
	</c:forEach>
</div>

<div class="form selectPosForm" style="float: left; display: block; overflow: auto; width: 205px; border: solid 1px #CCC; line-height: 21px;">
	<div style="background: #fff;" layoutH="0">
		<ul class="tree expand deptTree">
			<li deptId="0"><a href="javascript:;" onclick="selectDeviceDept(0);">营业部门列表</a>
			</li>
		</ul>
		<div style="position:absolute;top:33px;left: 130px;">
			<input type="checkbox" name="includeSub" style="width: 13px;top:2px; " <c:if test="${includeSub=='on'}">checked</c:if>/>包含下级
		</div>
	</div>
</div>

<div id="selectPosList" style="margin-left: 210px;">
	<jsp:include page="/selectPosList.do?pageNum=1&numPerPage=50" />
</div>
