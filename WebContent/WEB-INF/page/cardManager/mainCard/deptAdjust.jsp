<!-- 部门调整分组 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
$(function(){
	var adjustDeptTree = $("#adjustDeptTree li");
	adjustDeptTree.each(function() {
		var $this = $(this);
		var parentId = $this.attr("parentId");
		if (parentId == "0") {
			$("#deptAdjustForm .expand").append($this);
		} else {
			var $li = $("#deptAdjustForm li[deptId='" + parentId + "']");
			if ($(">ul", $li).size() == 0) {
				$("<ul></ul>").appendTo($li);
			}
			$(">ul", $li).append($(this));
		}
	});
	$("#deptAdjustForm .ok").click(function() {
		var adjustType=$("#deptAdjustForm input[name=adjustType]:checked").val();
		var fromDeptId=$("#deptAdjustForm .fromDeptTree :radio:checked").val();
		var toDeptId=$("#deptAdjustForm .toDeptTree :radio:checked").val();
		if(adjustType==0){
			if($("#deptAdjustForm input[name=selectedUserId]").val()==""){
				alertMsg.warn("没有选中人员！");
				return;								
			}
			if(toDeptId==null){
				alertMsg.warn("请选择新部门！");
				return;				
			}
		}else if(adjustType==1){
			if(fromDeptId==null){
				alertMsg.warn("请选择原部门！");
				return;				
			}
			if(toDeptId==null){
				alertMsg.warn("请选择新部门！");
				return;				
			}
		}else if(adjustType==2){
			if($("#adjustUserList input[name=userIds]").length==0){
				alertMsg.warn("没有查询到人员！");
				return;								
			}
			if(toDeptId==null){
				alertMsg.warn("请选择新部门！");
				return;
			}
		}
		validateCallback($(this).parents("form"), function(e) {
			if(e==1){
				refreshUserList();
				alertMsg.correct('部门调整完成！');
			}else{
				alertMsg.warn('部门调整失败！');				
			}
		}, null);
	});
// 	$("#deptAdjust input:radio[name=adjustType]").click(function(){
// 		if($(this).val()==2){
// 			$.pdialog.resizeDialog({style: {width: 900}}, $.pdialog.getCurrent(), "");
// 		}else{
// 			$.pdialog.resizeDialog({style: {width: 520}}, $.pdialog.getCurrent(), "");			
// 		}
// 	});
	//$.pdialog.resizeDialog({style: {width: 520}}, $.pdialog.getCurrent(), "");			
});
	
</script>

<style type="text/css">
	.dialog .pageFormContent {
		border-width: 0;
	}
	.dialog .pageFormContent fieldset{
		width: 490px;
	}
	
	.dialog .pageFormContent dl {
		width: 200px;
	}
	
	.dialog .pageFormContent dt {
		width: 70px;
	}
	
	.dialog .pageFormContent dd {
		width: 80px;
	}
	
	.dialog .pageFormContent dd span.error {
		width: 85px;
		left: 85px;
	}
</style>

<div id="adjustDeptTree">
	<c:forEach items="${list }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;" value="${d.id}" 
			deptId="${d.id }" batchId="${d.batchId }">${d.deptName }</a></li>
	</c:forEach>
</div>
<form id="deptAdjustForm" method="post" action="${base }/doDeptAdjust.do">
<div class="pageFormContent" style="float: left;">
	<div layoutH="170"
		style="float: left; overflow: auto; width: 242px; border: solid 1px #CCC; line-height: 21px; background: #fff">
			<ul class="tree radio expand fromDeptTree" radioName="fromDeptId">
				<li deptId="0"><a href="javascript:;" deptId="0">原部门列表</a>
					<ul>
			
					</ul></li>
			</ul>
	</div>
	<div layoutH="170"
		style="float: left; margin-left:10px; overflow: auto; width: 242px; border: solid 1px #CCC; line-height: 21px; background: #fff">
			<ul class="tree radio expand toDeptTree" radioName="toDeptId">
				<li deptId="0"><a href="javascript:;" deptId="0">新部门列表</a>
					<ul>
			
					</ul></li>
			</ul>
	</div>
	<div>
		<fieldset>
			<legend>用户信息</legend>
			<dl>
				<dt>用户姓名：</dt>
				<dd>
					${user.username }
					<input name="selectedUserId" type="hidden" value="${user.userId }" /> 
				</dd>
			</dl>
			<dl>
				<dt>用户编号：</dt>
				<dd>
					${user.userNO }
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>调整方式</legend>
			<dl style="width: 490px;">
				<dt style="width: 490px;">
					<input type="radio" name="adjustType" checked="checked" value="0" />调整选中人员 <input type="radio" name="adjustType" value="1" />调整选中部门人员<input type="radio" name="adjustType" value="2" />调整查询人员 
				</dt>
			</dl>
		</fieldset>
	</div>
	<div class="formBar" style="width: 490px;float: left;">
		<ul>
			<li><div class="button">
					<div class="buttonContent ok">
						<button type="button">确定</button>
					</div>
				</div></li>
			<li><div class="button">
					<div class="buttonContent">
						<button type="button" class="close">关闭</button>
					</div>
				</div>
				</li>
		</ul>
	</div>
</div>
<div id="adjustUserList" class="unitBox" style="margin-left: 510px;">
	<jsp:include page="${base }/adjustUserList.do?load=false"/>
</div>
</form>
