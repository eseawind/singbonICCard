<!-- 用户授权 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	function authUserClick(tr) {
		$("#authUserForm input:first").val(tr.attr("userId"));
		$("#authUserGroup input").attr("checked",false);
		var groupIds=","+tr.attr("groupIds")+",";
		$("#authUserGroup input:checkbox").each(function(){
			var index=groupIds.indexOf(","+$(this).val()+",");
			if(index>-1){
				$(this).attr("checked",true);
			}
		});
	}
	$(function(){
		$("#authUserForm .save").click(function(){
			var userId=$("#authUserForm input:first").val();
			if(userId==""){
				alertMsg.warn("请选择授权用户");
				return;
			}
			var groupIds="";
			$("#authUserGroup input:checkbox").each(function(){
				if($(this).attr("checked")){
					groupIds+=$(this).val()+",";
				}
			});
			if(groupIds!=""){
				groupIds=groupIds.replace("on,","");
				groupIds=groupIds.substring(0,groupIds.length-1);
				$("#authUserForm input:last").val(groupIds);
			}
			$("#authUserForm input:last").val(groupIds);
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					$("#authUser tr[userId="+userId+"]").attr("groupIds",groupIds);
					$("#authUserForm input:first").val("");
					$("#authUserForm input:last").val("");
					alertMsg.correct("授权成功！");
				} else {
					alertMsg.error("授权失败！");
				}
			}, null);
		});
	});
</script>

<style type="text/css">
</style>

<div  id="authUserGroup"
	style="float: left; display: block; overflow: auto; width: 600px; line-height: 21px;">
	<table class="table" width="99%" layoutH="90" rel="jbsxBox">
		<thead>
			<tr>
				<th width="10"><input type="checkbox" group="ids"
					class="checkboxCtrl"></th>
				<th width="100">分组名称</th>
				<th width="100">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${groupList }" var="g">
				<tr groupId="${g.id }">
					<td><input name="ids" value="${g.id }" type="checkbox"></td>
					<td>${g.groupName }</td>
					<td>${g.remark }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div id="authUser" class="unitBox" style="margin-left: 605px;">
	<table class="table" width="99%" layoutH="90" rel="jbsxBox">
		<thead>
			<tr>
				<th width="100">授权用户</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${sysUserList }" var="u">
				<tr userId="${u.id }" target="authUser" groupIds="${u.groupIds}">
					<td>${u.loginName }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="form">
	<form id="authUserForm" method="post" action="${base }/saveUser.do"
		class="pageForm required-validate">
		<div class="formBar">
			<input type="hidden" name="userId" /><input type="hidden" name="groupIds" />
			<div class="panelBar" style="border-style: none;">
				<ul class="toolBar">
					<li><a class="save" href="javascript:;"><span>保存</span></a></li>
				</ul>
			</div>
		</div>
	</form>
</div>
