<!-- 优惠方案列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
	function discountClick(tr){
		var i=0;
		$("#discountForm input").eq(i++).val(tr.attr("discountId"));
		tr.find("td").each(function(){
			$("#discountForm input").eq(i++).val($("div",this).html());
		});
	}
</script>
<style type="text/css">
</style>
<table class="table" width="99%" rel="jbsxBox">
	<thead>
		<tr>
			<th width="100">卡类型</th>
			<th width="100">扣费比例</th>
			<th width="100">补助金额</th>
			<th width="100">充值送费</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list }" var="d">
			<tr target="discount" discountId="${d.id }">
				<td>${d.discountType }</td>
				<td>${d.rate }</td>
				<td>${d.subsidy }</td>
				<td> <c:out value="${d.giveCashType==0?'充多少送多少':d.giveCash }"/></td>
			</tr>
		</c:forEach>
	</tbody>
</table>