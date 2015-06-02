<!-- 人员部门 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var selectedDeptId = 0;
	$(function() {
		$("#userDeptForm .add").click(function() {
			$("#userDeptForm input").eq(0).val("");
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					refreshUserDeptList();
				} else {
					
				}
			}, null);
		});
		$("#userDeptForm .edit").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					refreshUserDeptList();
				} else {
					
				}
			}, null);
		});
	});
	function refreshUserDeptList(){
		$("#userDeptList").loadUrl("${base}/userDeptList.do?parentId="+selectedDeptId);
	}
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
</style>

<div style="margin: 5px;">
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<jsp:include page="${base }/userDeptTreeList.do" />
		<div class="form">
			<form id="userDeptForm" method="post" action="${base }/addEditUserDept.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl>
						<dt>部门名称：</dt>
						<dd>
							<input type="hidden" name="id" /> 
							<input type="text" name="deptName" maxlength="20" class="required" />
						</dd>
					</dl>
					<dl>
						<dt>批次：</dt>
						<dd>
							<select class="combox" name="batchId">
								<c:forEach items="${batchList }" var="b">
									<option value="${b.id }">${b.batchName }</option>
								</c:forEach>
							</select>
						</dd>
					</dl>
				</div>
				<div class="formBar">
					<div class="panelBar" style="border-style: none;">
						<ul class="toolBar">
							<li><a class="add" href="javascript:;"><span>添加</span></a></li>
							<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
							<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
						</ul>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="userDeptList" class="unitBox" style="margin-left: 246px;">
<%-- 		<jsp:include page="${base }/userDeptList.do" /> --%>
	</div>
</div>
