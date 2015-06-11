<!-- 授权分组列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	
</script>
<style type="text/css">
</style>
<table class="table" width="99%" layoutH="120" rel="jbsxBox">
	<thead>
		<tr>
			<th width="100">分组名称</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="g">
			<tr>
				<td>${g.groupName }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div class="form">
	<form id="authGroup" method="post" action="${base }/addEdit.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
			<dl>
				<dt>分组名称：</dt>
				<dd>
					<input type="hidden" name="id" /> <input type="hidden"
						name="parentId" /> <input type="text" name="groupName"
						maxlength="20" class="required" />
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