<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(function(){
		$('.exportExcel').click(function(){
			$('#pagerForm input[name=export]').val(1);
			$('#pagerForm input[name=exportType]').val($(this).attr('exportType'));
			$('#pagerForm').submit();
			$('#pagerForm input[name=export]').val('');
			$('#pagerForm input[name=exportType]').val('');
		});
	});
	$(function(){
		$('.search').click(function(){
			divSearch($('#pagerForm'),'userList');
		});
	});
</script>
<style type="text/css">
	.inputDateButton{
		float: right;
	}
</style>
<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<form action="${base}/list.do" id="pagerForm">
		<input type="hidden" name="export"/>
		<input type="hidden" name="exportType"/>
		<input type="hidden" name="pageNum" value="${pageNum}" />
		<input type="hidden" name="numPerPage" value="${numPerPage}" />
		<input type="hidden" name="totalCount" value="${totalCount}" />
		<div class="searchBar">
			<table border="0">
				<tr align="right">
					<td>用户信息：</td>
					<td><input type="text" name="nameStr" size="10"
						value="${nameStr }" />
					</td>
					<td width="50">部门：</td>
					<td>
						<input type="hidden" name="deptId" value="${deptId}"/>
						<input type="text" name="deptName" value="${deptName}" size="10" readonly="readonly"/>
					</td>
					<td>
						<a class="btnLook" width="300" maxable="false" resizable="false" title="选择部门" href="/selectUserDeptTree.do" lookupgroup="district"></a>					
					</td>
					<td width="60">卡种类：</td>
					<td align="left">
						<select class="combox" outerw="50" innerw="70"
							name="cardTypeId">
							<option value="-1" width="70">全部</option>
							<c:forEach var="i" begin="0" end="15" step="1">
								<option value="${i}" width="70" <c:if test="${i==cardTypeId}">selected</c:if> >${i}类卡</option>
							</c:forEach>
						</select>
					</td>
					<td width="40">性别：</td>
					<td align="left">
						<select class="combox" outerw="50" innerw="70"
							name="sex">
							<option value="-1" width="70">全部</option>
							<option value="0" width="70" <c:if test="${sex==0}">selected</c:if>>男</option>
							<option value="1" width="70" <c:if test="${sex==1}">selected</c:if>>女</option>
						</select>
					</td>
					<td width="60">卡状态：</td>
					<td align="left">
						<select class="combox" outerw="50" innerw="70"
							name="status">
							<option value="-1" width="70">全部</option>
							<option value="241" width="70" <c:if test="${status==241}">selected</c:if>>正常</option>
							<option value="243" width="70" <c:if test="${status==243}">selected</c:if>>挂失</option>
							<option value="0" width="70" <c:if test="${status==0}">selected</c:if>>未发卡</option>
							<option value="244" width="70" <c:if test="${status==244}">selected</c:if>>注销</option>
							<option value="-2" width="70" <c:if test="${status==-2}">selected</c:if>>异常</option>
						</select>
					</td>					
					<td width="50">日期：</td>
					<td width="80" align="left">
						<select class="combox" outerw="50" innerw="70"
							name="dateType">
							<option value="-1" width="70">全部</option>
							<option value="0" width="70" <c:if test="${dateType==0}">selected</c:if>>开卡日期</option>
							<option value="1" width="70" <c:if test="${dateType==1}">selected</c:if>>失效日期</option>
						</select>
					</td>
					<td align="left">
						<input type="text" name="beginDate" value="${beginDate}" readonly="readonly"
						class="date" size="10"/><a class="inputDateButton" href="javascript:;">选择</a>
					</td>
					<td align="left">
						
						&nbsp;- 
						<input type="text" name="endDate" value="${endDate}" readonly="readonly"
						class="date" size="10"/><a class="inputDateButton" href="javascript:;">选择</a>
					</td>
					<td align="left">
						
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" class="search">&nbsp;&nbsp;查询&nbsp;&nbsp;</button>
							</div>
						</div>
						<div class="buttonActive" style="margin: 0 10px;">
							<div class="buttonContent">
								<button type="button" class="exportExcel" exportType="0">导出当前</button>
							</div>
						</div>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" class="exportExcel" exportType="1">导出全部</button>
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
	<table class="table" width="99%" layoutH="148">
		<thead>
			<tr>
				<th width="80">序号</th>
				<th width="100">编号</th>
				<th width="100">姓名</th>
				<th width="120">性别</th>
				<th width="200">身份证号</th>
				<th width="80">卡类别</th>
				<th width="80">状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${list}" varStatus="status">
				<tr userId="${user.userId }" status="${user.status }">
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
				onchange="navTabPageBreak({numPerPage:this.value}, 'userList')">
				<c:forEach begin="1" end="20" var="i" step="1">
					<option value='${i*10 }' <c:if test="${i*10==numPerPage }">selected</c:if> >${i*10 }</option>
				</c:forEach>
			</select>
			<span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" rel="userList" totalCount="${totalCount }" numPerPage="${numPerPage }"
			pageNumShown="10" currentPage="${pageNum }"></div>
	</div>
</div>
