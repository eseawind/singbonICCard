<!-- 批次列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
	function batchClick(tr){
		var i=0;
		$('#batchForm input').eq(i++).val(tr.attr('batchId'));
		tr.find('td').each(function(){
			$('#batchForm input').eq(i++).val($('div',this).html());
		});
	}
</script>
<style type="text/css">
</style>
<table class="table" width="99%" layoutH="30" rel="jbsxBox">
	<thead>
		<tr>
			<th width="100">批次名称</th>
			<th width="100">开始日期</th>
			<th width="100">结束日期</th>
			<th width="100">状态</th>
<!-- 			<th width="100">失效日期</th> -->
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="b">
			<tr target="batch" batchId="${b.id }">
				<td batchId="${b.id}" batchName="${b.batchName}">${b.batchName }</td>
				<td><fmt:formatDate value="${b.beginDate}" pattern="yyyy-MM-dd"/></td>
				<td><fmt:formatDate value="${b.endDate}" pattern="yyyy-MM-dd"/></td>
				<td>${b.statusDesc}</td>
<%-- 				<td><fmt:formatDate value="${b.invalidDate}" pattern="yyyy-MM-dd"/></td> --%>
			</tr>
		</c:forEach>
	</tbody>
</table>