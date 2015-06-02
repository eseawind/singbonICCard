<!-- 人员部门 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var selectedDeptId = -1;
	$(function() {
		$(".submitUserDept").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				//alert(e);
			}, null);
		});
	});
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
</style>

<div style="margin: 5px;">
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<jsp:include page="/common/userDeptTree.do">
			<jsp:param value="150" name="h" />
		</jsp:include>
		<div class="form">
			<form id="deptForm" method="post"
				action="/systemManager/systemSetting/addEditUserDept.do"
				class="pageForm required-validate">
				<div class="pageFormContent">
					<dl>
						<dt>部门名称：</dt>
						<dd>
							<input type="text" name="deptName" maxlength="20"
								class="required" />
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
					<ul>
						<li><div class="buttonActive">
								<div class="buttonContent">
									<button class="submitUserDept" type="button">提交</button>
								</div>
							</div></li>
					</ul>
				</div>
			</form>
		</div>
	</div>

	<div id="deptList" class="unitBox" style="margin-left: 246px;">
				<jsp:include page="/systemManager/systemSetting/userDeptList.do" />
	</div>
</div>
