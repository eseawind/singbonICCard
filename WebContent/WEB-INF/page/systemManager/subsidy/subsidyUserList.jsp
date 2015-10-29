<!-- 添加用户列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	$(function(){
		$('#search').click(function(){
			search();
		});
		$('#changeSubsidyFare').click(function(){
			var subsidyFare=$('#subsidyFare').val();
			$('#pagerForm2 input[name=subsidyFare]').val(subsidyFare);
			$('#pagerForm2 input[name=autoSubsidyFare]').val('');			
			search();
		});
		$('#delete').click(function(){
			var userIds = '';
			$('.subsidyUserList input:checkbox').each(
					function() {
						if ($(this).attr('checked')
								&& $(this).attr('status') == 0) {
							userIds += $(this).val() + ',';
						}
					});
			if (userIds != '') {
				userIds = userIds.substring(0, userIds.length - 1);
				alertMsg.confirm('确定要删除选定人员吗？', {
					okCall : function() {
						$.post('${base}/delete.do?checkedUserIds='+ userIds, function(e) {
							search();
						});
					}
				});
			} else {
				alertMsg.warn('请选择待删除人员！');
			}
		});
	});
	
	function search(){
		var deptIds = '';
		$('#addUserUserDeptTree .checked').each(function(i, e2) {
				deptIds += $(this).next().next().attr('deptId') + ',';
			});
		$('#pagerForm2 input[name=deptIds]').val(deptIds);					
		divSearch($('#pagerForm2'),'subsidyUserList');
	}
</script>

<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<form action="${base}/subsidyUserList.do" id="pagerForm2">		
		<input type="hidden" name="deptIds"/>
		<input type="hidden" name="autoSubsidyFare" value="${autoSubsidyFare}"/>
		<input type="hidden" name="subsidyFare" value="${subsidyFare}"/>
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
		<input type="hidden" name="totalCount" value="${totalCount}" />
		<div class="searchBar">
			<table border="0">
				<tr align="right">
					<td>用户信息：</td>
					<td><input type="text" name="nameStr" size="10" value="${nameStr }" />
					</td>
					<td width="50">部门：</td>
					<td>
						<input type="hidden" name="deptId" value="${deptId}"/>
						<input type="text" name="deptName" value="${deptName}" size="10" readonly="readonly"/>
					</td>
					<td>
						<a class="btnLook" width="300" maxable="false" resizable="false" title="选择部门" href="${base}/treeList.do" lookupgroup="district"></a>					
					</td>
					<td width="60">卡种类：</td>
					<td align="left">
						<select class="combox" outerw="50" innerw="70" name="cardTypeId">
							<option value="-1" width="70">全部</option>
							<c:forEach var="i" begin="0" end="15" step="1">
								<option value="${i}" width="70" <c:if test="${i==cardTypeId}">selected</c:if> >${i}类卡</option>
							</c:forEach>
						</select>
					</td>
					<td width="60">身份：</td>
					<td align="left">
						<select class="combox" outerw="50" innerw="70" name="cardIdentity">
							<option value="-1" width="70">全部</option>
							<option value="1" width="70" <c:if test="${cardIdentity==1}">selected</c:if>>教师</option>
							<option value="2" width="70" <c:if test="${status==2}">selected</c:if>>学生</option>
							<option value="3" width="70" <c:if test="${status==3}">selected</c:if>>职工</option>
							<option value="4" width="70" <c:if test="${status==4}">selected</c:if>>临时人员</option>
							<option value="5" width="70" <c:if test="${status==5}">selected</c:if>>其他</option>
						</select>
					</td>
					<td width="40">性别：</td>
					<td align="left">
						<select class="combox" outerw="50" innerw="70" name="sex">
							<option value="-1" width="70">全部</option>
							<option value="0" width="70" <c:if test="${sex==0}">selected</c:if>>男</option>
							<option value="1" width="70" <c:if test="${sex==1}">selected</c:if>>女</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="12">
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" id="search">&nbsp;&nbsp;查询&nbsp;&nbsp;</button>
							</div>
						</div>
						<span style="float: left;margin: 7px 0 0 80px;">补助金额：</span>
						<input type="text" id="subsidyFare" size="10" value="${subsidyFare}" style="float: left;margin: 2px 5px 0px;"/>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" id="changeSubsidyFare">修改补助金额</button>
							</div>
						</div>
						<div class="buttonActive" style="margin: 0 10px;">
							<div class="buttonContent">
								<button type="button" id="delete">删除选中人员</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>
<div class="pageContent"
	style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="170">
		<thead>
			<tr>
				<th width="10"><input type="checkbox" group="userIds" class="checkboxCtrl"></th>
				<th width="80">序号</th>
				<th width="100">编号</th>
				<th width="100">姓名</th>
				<th width="120">性别</th>
				<th width="200">身份证号</th>
				<th width="80">卡类别</th>
				<th width="80">状态</th>
				<th width="80">补助金额</th>
			</tr>
		</thead>
		<tbody class="subsidyUserList">
			<c:forEach var="user" items="${list}" varStatus="status">
				<tr userId="${user.userId }" subsidyFare="${user.subsidyFare }">
					<td><input name="userIds" value="${user.userId }" type="checkbox"></td>
					<td>${status.index+1}</td>
					<td>${user.userNO}</td>
					<td>${user.username}</td>
					<td>${user.sexDesc}</td>
					<td>${user.cardID}</td>
					<td>${user.cardTypeId}类卡</td>
					<td>${user.statusDesc}</td>
					<td>${user.subsidyFare}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'subsidyUserList')">
				<c:forEach begin="1" end="20" var="i" step="1">
					<option value='${i*10 }'
						<c:if test="${i*10==numPerPage }">selected</c:if>>${i*10 }</option>
				</c:forEach>
			</select> <span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" rel="subsidyUserList" totalCount="${totalCount }"
			numPerPage="${numPerPage }" pageNumShown="10"
			currentPage="${pageNum }"></div>
	</div>
</div>
