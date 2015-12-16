<!-- 添加用户列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	var selectedId=null;
	var selectedStatus=null;
	$(function(){
		$('#subsidyUserList .search').click(function(){
			searchSubsidyUserList();
		});
		$('#subsidyUserList .addFare').click(function(){
			if($('#subsidyUserList #pagerForm').valid()){
				var subsidyFare=$('#subsidyFare').val();
				$.post('${base}/addFare.do?subsidyFare='+subsidyFare, function(e) {
					if(e==1){
						alertMsg.correct('添加金额完成！');			
						searchSubsidyUserList();
					}else{
						alertMsg.warn('添加金额失败！');
					}
				});					
			}
		});
		$('#subsidyUserList .autoFare').click(function(){
			$.post('${base}/autoFare.do', function(e) {
				if(e==1){
					alertMsg.correct('自动生成金额完成！');			
					searchSubsidyUserList();
				}else{
					alertMsg.warn('自动生成金额失败！');
				}
			});		
		});
		$('#subsidyUserList .updateFare').click(function(){
			if(selectedId==null){
				alertMsg.warn('还未选择修改人员！');
				return;
			}
			if($('#subsidyUserList #pagerForm').valid()){
				if(selectedStatus==2){
					alertMsg.warn('已领取不能修改！');					
					return;
				}
				var fare=$('#subsidyUserList #subsidyFare').val();
				$.post('${base}/editFare.do?id='+ selectedId+'&subsidyFare='+fare, function(e) {
					if(e==1){
						selectedId=null;
						alertMsg.correct('修改完成！');			
						searchSubsidyUserList();
					}else{
						alertMsg.warn('修改失败！');
					}
				});
			}
		});
		$('#subsidyUserList .delete').click(function(){
			var ids = '';
			$('#subsidyUserList input:checkbox[name][checked]').each(
					function() {
						ids += $(this).val() + ',';
					});
			if (ids != '') {
				ids = ids.substring(0, ids.length - 1);
				alertMsg.confirm('确定要删除选定人员吗？', {
					okCall : function() {
						$.post('${base}/delete.do?checkedIds='+ ids, function(e) {
							searchSubsidyUserList();
						});
					}
				});
			} else {
				alertMsg.warn('请选择待删除人员！');
			}
		});
		$('#subsidyUserList .transfer').click(function(){
			alertMsg.confirm('确定要转移补助吗？', {
				okCall : function() {
					$.post('${base}/transferSubsidy.do', function(e) {
						if(e==1){
							alertMsg.correct('转移完成！');			
							searchSubsidyUserList();
						}else{
							alertMsg.warn('转移失败！');
						}
					});
				}
			});
		});
	});
	
	function searchSubsidyUserList(){
		var deptIds = '';
		$('#generateUserDeptTree .checked').each(function(i, e2) {
				deptIds += $(this).next().next().attr('deptId') + ',';
			});
		$('#subsidyUserList #pagerForm input[name=deptIds]').val(deptIds);					
		divSearch($('#subsidyUserList #pagerForm'),'subsidyUserList');
	}
	
	function subsidyUserListClick(tr){
		var subsidyFare=tr.attr('subsidyFare');
		$('#subsidyUserList #subsidyFare').val(subsidyFare);
		selectedId=tr.attr('id');
		selectedStatus=tr.attr('subsidyStatus');
	}
</script>

<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<form action="${base}/subsidyUserList.do" id="pagerForm">		
		<input type="hidden" name="deptIds"/>
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
		<input type="hidden" name="totalCount" value="${totalCount}" />
		<div class="searchBar">
			<table border="0">
				<tr align="left">
					<td width="60">用户信息：</td>
					<td width="100"><input type="text" name="nameStr" size="10" value="${nameStr }" />
					</td>
					<td width="50">卡种类：</td>
					<td width="90">
						<select class="combox" outerw="50" innerw="70" name="cardTypeId">
							<option value="-1" width="70">全部</option>
							<c:forEach var="i" begin="0" end="15" step="1">
								<option value="${i}" width="70" <c:if test="${i==cardTypeId}">selected</c:if> >${i}类卡</option>
							</c:forEach>
						</select>
					</td>
					<td width="40">状态：</td>
					<td width="90">
						<select class="combox" outerw="50" innerw="70" name="status">
							<option value="-1" width="70">全部</option>
							<option value="241" width="70" <c:if test="${status==241}">selected</c:if>>正常</option>
						</select>
					</td>
					<td width="40">性别：</td>
					<td>
						<select class="combox" outerw="50" innerw="70" name="sex">
							<option value="-1" width="70">全部</option>
							<option value="0" width="70" <c:if test="${sex==0}">selected</c:if>>男</option>
							<option value="1" width="70" <c:if test="${sex==1}">selected</c:if>>女</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="10">
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" class="search">&nbsp;&nbsp;查询&nbsp;&nbsp;</button>
							</div>
						</div>
						<span style="float: left;margin: 7px 0 0 10px;">补助金额：</span>
						<input type="text" id="subsidyFare" size="10" value="${subsidyFare}" class="number" style="float: left;margin: 2px 5px 0px;"/>
						<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SUBSIDY_GENERATE_ADDFARE">
							<div class="buttonActive">
								<div class="buttonContent">
									<button type="button" class="addFare">添加金额</button>
								</div>
							</div>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SUBSIDY_GENERATE_EDIT">
							<div class="buttonActive" style="margin: 0 10px 0 5px">
								<div class="buttonContent">
									<button type="button" class="updateFare">修改金额</button>
								</div>
							</div>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SUBSIDY_GENERATE_AUTO">
							<div class="buttonActive">
								<div class="buttonContent">
									<button type="button" class="autoFare">自动生成金额</button>
								</div>
							</div>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SUBSIDY_GENERATE_DEL">
							<div class="buttonActive" style="margin: 0 10px;">
								<div class="buttonContent">
									<button type="button" class="delete">删除选中人员</button>
								</div>
							</div>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SUBSIDY_GENERATE_TRANSFER">
							<div class="buttonActive" style="margin: 0 10px;">
								<div class="buttonContent">
									<button type="button" class="transfer">转移补助</button>
								</div>
							</div>
						</security:authorize>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>
<div class="pageContent"
	style="border-left: 1px #B8D0D6 solid; border-right: 1px #B8D0D6 solid">
	<table class="table" width="99%" layoutH="172">
		<thead>
			<tr>
				<th width="40"><input type="checkbox" group="ids" class="checkboxCtrl"></th>
				<th width="80">序号</th>
				<th width="100">编号</th>
				<th width="100">姓名</th>
				<th width="120">性别</th>
				<th width="200">身份证号</th>
				<th width="80">卡类别</th>
				<th width="80">状态</th>
				<th width="80">补助状态</th>
				<th width="80">补助金额</th>
			</tr>
		</thead>
		<tbody class="subsidyUserList">
			<c:forEach var="user" items="${list}" varStatus="status">
				<tr id="${user.id }" subsidyFare="${user.subsidyFare }" subsidyStatus="${user.subsidyStatus}" target="subsidyUserList">
					<td><input name="ids" value="${user.id }" type="checkbox"></td>
					<td>${status.index+1}</td>
					<td>${user.userNO}</td>
					<td>${user.username}</td>
					<td>${user.sexDesc}</td>
					<td>${user.cardID}</td>
					<td>${user.cardTypeId}类卡</td>
					<td>${user.statusDesc}</td>
					<td>${user.subsidyStatusDesc}</td>
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
