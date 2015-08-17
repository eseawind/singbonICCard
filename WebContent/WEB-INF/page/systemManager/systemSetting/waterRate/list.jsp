<!-- 水控费率2、3、4 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function waterRateClick(tr) {
		$('#waterRateForm input').eq(0).val(tr.attr('waterRateId'));
		var tds = tr.find('td');
		$('#waterRateForm input').eq(1).val(tds.eq(0).find('div').html());
		$('#waterRateForm input').eq(2).val(tds.eq(1).find('div').html());
		$('#waterRateForm input').eq(3).val(tds.eq(2).find('div').html());
		$('#waterRateForm input').eq(4).val(tr.attr('rate1'));
		$('#waterRateForm input').eq(5).val(tr.attr('rate2'));
		var authCard=tr.attr('authCard');
		$('#waterRateForm #authCard input').each(function(e){
			$(this).attr("checked",false);
			var val=authCard.charAt(e);
			if(val==1){
				$(this).attr("checked",true);
			}
		});
	}
</script>
<style type="text/css">
</style>
<table class="table" width="99%" rel="jbsxBox" layoutH="30">
	<thead>
		<tr>
			<th width="100">费率名称</th>
			<th width="100">起始时间</th>
			<th width="100">结束时间</th>
			<th width="100">费率值</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="w">
			<tr target="waterRate" waterRateId="${w.id}" authCard="${w.authCard}" rate1="${w.rate1}" rate2="${w.rate2}">
				<td>${w.waterRateName}</td>
				<td>${w.beginTime}</td>
				<td>${w.endTime}</td>
				<td>${w.rate1}/${w.rate2}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>