<!-- 优惠方案列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function discountClick(tr) {
		$("#discountForm input").eq(0).val(tr.attr("discountId"));
		var tds = tr.find("td");
		$("#discountForm input").eq(1).val(tds.eq(2).find("div").html());
		var select = $("#discountForm select");
		var rate = tds.eq(1).find("div").html();
		select.prev().val(rate).html(
				$("option[value=" + rate + "]", select).html());
		var giveCash=tds.eq(3).find("div").html();
		if(giveCash=="充多少送多少"){
			$("#discountForm input:radio").eq(0).attr("checked","checked");
			$("#discountForm input[name=giveCash]").val(0).hide();
		}else{
			$("#discountForm input:radio").eq(1).attr("checked","checked");
			$("#discountForm input[name=giveCash]").val(giveCash).show();
		}
	}
</script>
<style type="text/css">
</style>
<table class="table" width="99%" rel="jbsxBox" layoutH="30">
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
				<td><c:out value="${d.giveCashType==0?'充多少送多少':d.giveCash }" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>