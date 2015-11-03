<!-- 消费机列表 -->
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
				<th width="100">设备类型</th>
				<th width="120">消费参数分组</th>
				<th width="300">序列号</th>
				<th width="80">状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${deviceList }" var="d" varStatus="status">
				<tr target="posList" id="${d.device.id }" deviceNum="${d.device.deviceNum}" deviceName="${d.device.deviceName}" deviceType="${d.device.deviceType}" posParamGroupId="${d.posParamGroup.id}" sn="${d.device.sn}" enable="${d.device.enable}">
					<td>${status.index+1}</td>
					<td>${d.device.deviceNum }</td>
					<td>${d.device.deviceName }</td>
					<td>${d.deviceTypeDes}</td>
					<td>${d.posParamGroup.groupName }</td>
					<td>${d.device.sn }</td>
					<td>${d.device.enable==1?"启用":"禁用" }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>