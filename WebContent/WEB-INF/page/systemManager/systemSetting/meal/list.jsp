<!-- 餐别设置列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function mealClick(tr) {
		$('#mealForm input').eq(0).val(tr.attr('mealId'));
		var tds = tr.find('td');
		tds.each(function(e){
			$('#mealForm input').eq(e+1).val($(this).find('div').html());
		});
	}
</script>
<style type="text/css">
</style>
<table class="table" width="99%" rel="jbsxBox" layoutH="30">
	<thead>
		<tr>
			<th width="100">餐别名称</th>
			<th width="100">起始时间</th>
			<th width="100">结束时间</th>
			<th width="100">次数限制</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="m">
			<tr target="meal" mealId="${m.id }">
				<td>${m.mealName }</td>
				<td>${m.beginTime }</td>
				<td>${m.endTime }</td>
				<td>${m.timeLimit }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>