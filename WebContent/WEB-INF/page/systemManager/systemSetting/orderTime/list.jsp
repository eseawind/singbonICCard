<!-- 订餐时间段列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function orderTimeClick(tr) {
		$('#orderTimeForm input').eq(0).val(tr.attr('orderTimeId'));
		var tds = tr.find('td');
		$('#orderTimeForm input').eq(1).val(tds.eq(1).find('div').html());
		$('#orderTimeForm input').eq(2).val(tds.eq(2).find('div').html());
		$('#orderTimeForm input').eq(3).val(tds.eq(3).find('div').html());
		var enable = tr.attr('enable');
		if(enable=='false'){
			$('#orderTimeForm input[name=status]').attr('checked',false);
		}else{
			$('#orderTimeForm input[name=status]').attr('checked',true);			
		}
	}
	
	$(function(){
		$('#orderTimeList .item[enable=false]').addClass('red');
	});
</script>
<style type="text/css">
	.red{
		color: red;
	}
	.hide{
		display: none;
	}
</style>
<div id="orderTimeList">
	<table class="table" width="99%" rel="jbsxBox" layoutH="90">
		<thead>
			<tr>
				<th width="10">序号</th>
				<th width="100">餐别</th>
				<th width="100">开始时间</th>
				<th width="100">结束时间</th>
				<th width="100">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="o" varStatus="status">
				<tr class="item" target="orderTime" orderTimeId="${o.id }" enable="${o.enable }">
					<td>${status.index+1}</td>
					<td>${o.orderTimeName }</td>
					<td>${o.beginTime }</td>
					<td>${o.endTime }</td>
					<td>${o.remark }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>