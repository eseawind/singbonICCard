<!-- 营业部门列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>
<style type="text/css">

</style>
<table class="table" width="99%" layoutH="30" rel="jbsxBox">
	<thead>
		<tr>
			<th width="100">营业部门名称</th>
			<th width="100">所属营业部门</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="b">
			<tr>
				<td>${b.deptName }</td>
				<td>${b.parentName }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>