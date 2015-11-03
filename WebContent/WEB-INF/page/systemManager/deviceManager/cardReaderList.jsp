<!-- 读卡机列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	
</script>
<style type="text/css">
</style>
<div id="posList">
	<table class="table" width="99%" rel="jbsxBox">
		<thead>
			<tr>
				<th width="40">序号</th>
				<th width="80">机器号</th>
				<th width="120">设备名称</th>
				<th width="300">序列号</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="c" varStatus="status">
				<tr target="cardReader" id="${c.id }" deviceNum="${c.deviceNum}" deviceName="${c.deviceName}" sn="${c.sn}">
					<td>${status.index+1}</td>
					<td>${c.deviceNum }</td>
					<td>${c.deviceName }</td>
					<td>${c.sn }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>