<!-- 用户授权 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
</style>

<div style="float: left; display: block; overflow: auto; width: 600px; line-height: 21px;">
	<table class="table" width="99%" layoutH="90" rel="jbsxBox">
		<thead>
			<tr>
				<th width="100">分组名称</th>
				<th width="100">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="g">
				<tr groupId="${g.id }">
					<td>${g.groupName }</td>
					<td>${g.remark }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div id="" class="unitBox" style="margin-left: 605px;">
	<table class="table" width="99%" layoutH="90" rel="jbsxBox">
		<thead>
			<tr>
				<th width="100">授权用户</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="g">
				<tr groupId="${g.id }">
					<td>${g.groupName }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="form">
	<form id="authUserForm" method="post" action="${base }/saveUser.do"
		class="pageForm required-validate">
		<div class="formBar">
			<div class="panelBar" style="border-style: none;">
				<ul class="toolBar">
					<li><a class="save" href="javascript:;"><span>保存</span></a></li>
				</ul>
			</div>
		</div>
	</form>
</div>