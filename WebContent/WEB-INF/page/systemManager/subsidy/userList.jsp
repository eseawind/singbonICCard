<!-- 添加用户列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	$(function(){
		$('#userList2 .search').click(function(){
			search();
		});
		
		$('#userList2 .addUser').click(function(){
			var ids = '';
			$('#userList2 input:checkbox[name][checked]').each(
				function() {
					ids += $(this).val() + ',';
				});
				if (ids != '') {
					var go=0;
					var subsidyVersion=0;
					var invalidDate='';
					$.post('${base}/selectStatus.do', function(e) {
						var e2 = eval('(' + e + ')');
						subsidyVersion=e2.subsidyVersion;
						if (e2.subsidyVersion!=0) {
							alertMsg.confirm('当前已有补助生成，是否继续添加人员？', {
								okCall : function() {
									go=1;	
									invalidDate=e2.invalidDate;
								}
							});
						}else {
							go=1;
						}
						if(go==1){
							ids = ids.substring(0, ids.length - 1);
							$.post('${base}/addUser.do?checkedIds='+ ids+'&subsidyVersion='+subsidyVersion+'&invalidDate='+invalidDate, function(e) {
								if (e == 1) {
									alertMsg.correct('添加人员完成！');
								} else if(e==0) {
									alertMsg.warn('添加人员失败！');					
								}
							});
						}
					});
				} else {
					alertMsg.warn('请选择待添加人员！');
				}
		});
	});
	
	function search(){
		var deptIds = '';
		$('#userDeptTree .checked').each(function(i, e2) {
				deptIds += $(this).next().next().attr('deptId') + ',';
			});
		$('#userList2 #pagerForm input[name=deptIds]').val(deptIds);					
		divSearch($('#userList2 #pagerForm'),'userList2');
	}
</script>

<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<form action="${base}/userList.do" id="pagerForm">		
		<input type="hidden" name="deptIds"/>
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
		<input type="hidden" name="totalCount" value="${totalCount}" />
		<div class="searchBar">
			<table border="0">
				<tr align="right">
					<td>用户信息：</td>
					<td><input type="text" name="nameStr" size="10" value="${nameStr }" />
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
					<td width="40">状态：</td>
					<td align="left">
						<select class="combox" outerw="50" innerw="70" name="status">
							<option value="-1" width="70">全部</option>
							<option value="241" width="70" <c:if test="${status==241}">selected</c:if>>正常</option>
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
								<button type="button" class="search">&nbsp;&nbsp;查询&nbsp;&nbsp;</button>
							</div>
						</div>
						<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SUBSIDY_USER_ADDUSER">
							<div class="buttonActive" style="margin: 0 12px;">
								<div class="buttonContent">
									<button type="button" class="addUser">添加选中人员</button>
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
				<th width="10"><input type="checkbox" group="ids" class="checkboxCtrl"></th>
				<th width="80">序号</th>
				<th width="100">编号</th>
				<th width="100">姓名</th>
				<th width="120">性别</th>
				<th width="200">身份证号</th>
				<th width="80">卡类别</th>
				<th width="80">状态</th>
			</tr>
		</thead>
		<tbody class="userList2">
			<c:forEach var="user" items="${list}" varStatus="status">
				<tr>
					<td><input name="ids" value="${user.userId }" type="checkbox"></td>
					<td>${status.index+1}</td>
					<td>${user.userNO}</td>
					<td>${user.username}</td>
					<td>${user.sexDesc}</td>
					<td>${user.cardID}</td>
					<td>${user.cardTypeId}类卡</td>
					<td>${user.statusDesc}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'userList2')">
				<c:forEach begin="1" end="20" var="i" step="1">
					<option value='${i*10 }'
						<c:if test="${i*10==numPerPage }">selected</c:if>>${i*10 }</option>
				</c:forEach>
			</select> <span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" rel="userList2" totalCount="${totalCount }"
			numPerPage="${numPerPage }" pageNumShown="10"
			currentPage="${pageNum }"></div>
	</div>
</div>
