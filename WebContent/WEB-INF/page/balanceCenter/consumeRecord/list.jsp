<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">
	$(function(){
		$('.exportExcel').click(function(){
			$('#consumeRecordList #pagerForm input[name=export]').val(1);
			$('#consumeRecordList #pagerForm input[name=exportType]').val($(this).attr('exportType'));
			$('#consumeRecordList #pagerForm').submit();
			$('#consumeRecordList #pagerForm input[name=export]').val('');
			$('#consumeRecordList #pagerForm input[name=exportType]').val('');
		});
	});
	$(function(){
		$('#consumeRecordList .search').click(function(){
			divSearch($('#consumeRecordList #pagerForm'),'consumeRecordList');
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
					<td width="50">终端：</td>
					<td>
						<input type="hidden" name="deviceId" value="${deviceId}"/>
						<input type="text" name="deviceName" value="${deviceName}" size="10" readonly="readonly"/>
					</td>
					<td>
						<a class="btnLook" width="800" height="500" maxable="false" resizable="false" title="选择终端" href="/selectPosIndex.do" lookupgroup="district"></a>					
					</td>
					<td width="60">卡种类：</td>
					<td align="left">
						<select class="combox" outerw="45" innerw="65" name="cardTypeId">
							<option value="-1" width="65">全部</option>
							<c:forEach var="i" begin="0" end="15" step="1">
								<option value="${i}" width="70" <c:if test="${i==cardTypeId}">selected</c:if> >${i}类卡</option>
							</c:forEach>
						</select>
					</td>
					<td width="70">消费日期：</td>
					<td width="80" align="left">
						<select class="combox" outerw="50" innerw="70" name="dateType">
							<option value="-1" width="70">全部</option>
							<option value="0" width="70" <c:if test="${dateType==0}">selected</c:if>>消费日期</option>
							<option value="1" width="70" <c:if test="${dateType==1}">selected</c:if>>采集日期</option>
						</select>
					</td>
					<td align="left">
						<input type="text" name="beginDate" value="${beginDate}" readonly="readonly" datefmt="yyyy-MM-dd HH:mm:ss" class="date" size="18"/><a class="inputDateButton" href="javascript:;">选择</a>
					</td>
					<td align="left">
						&nbsp;- 
						<input type="text" name="endDate" value="${endDate}" readonly="readonly" class="date" datefmt="yyyy-MM-dd HH:mm:ss"  size="18"/><a class="inputDateButton" href="javascript:;">选择</a>
					</td>
					<td align="left">
						<input type="checkbox" name="includeOff" <c:if test="${includeOff=='on'}">checked</c:if> />
						包含注销用户
					</td>
				</tr>
				<tr>
					<td width="60">消费类型：</td>
					<td align="left" colspan="2">
						<select class="combox" outerw="80" innerw="100" name="consumeType">
							<option value="-1" width="100">全部</option>
							<option value="1" width="100" <c:if test="${consumeType==1}">selected</c:if>>消费机普通消费</option>
							<option value="2" width="100" <c:if test="${consumeType==2}">selected</c:if>>消费机补助消费</option>
							<option value="3" width="100" <c:if test="${consumeType==3}">selected</c:if>>消费机混合消费</option>
							<option value="9" width="100" <c:if test="${consumeType==9}">selected</c:if>>消费机补助领取</option>
							<option value="39" width="100" <c:if test="${consumeType==39}">selected</c:if>>消费机补助清零</option>
							
							<option value="101" width="100" <c:if test="${consumeType==101}">selected</c:if>>水控普通消费</option>
							<option value="102" width="100" <c:if test="${consumeType==102}">selected</c:if>>水控补助消费</option>
							<option value="103" width="100" <c:if test="${consumeType==103}">selected</c:if>>水控混合消费</option>
							<option value="105" width="100" <c:if test="${consumeType==105}">selected</c:if>>水控大钱包找零</option>
							<option value="106" width="100" <c:if test="${consumeType==106}">selected</c:if>>水控补助找零</option>
							<option value="107" width="100" <c:if test="${consumeType==107}">selected</c:if>>水控混合找零</option>
							<option value="109" width="100" <c:if test="${consumeType==109}">selected</c:if>>水控补助领取</option>
							<option value="139" width="100" <c:if test="${consumeType==139}">selected</c:if>>水控补助清零</option>
						</select>
					</td>		
					<td colspan="12">
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
				<th width="40">序号</th>
				<th width="100">终端名称</th>
				<th width="100">用户编号</th>
				<th width="100">卡号</th>
				<th width="100">姓名</th>
				<th width="100">钱包余额</th>
				<th width="100">补助余额</th>
				<th width="100">管理费</th>
				<th width="100">操作额</th>
				<th width="100">餐别名称</th>
				<th width="200">操作时间</th>
				<th width="100">卡计数</th>
				<th width="100">补助卡计数</th>
				<th width="100">记录序号</th>
				<th width="170">记录类型</th>
				<th width="100">菜肴名称</th>
				<th width="100">菜肴份数</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="d" items="${list}" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${d.deviceName}</td>
					<td>${d.userNO}</td>
					<td>${d.cardNO}</td>
					<td>${d.username}</td>
					<td>${d.oddFare}</td>
					<td>${d.subsidyOddFare}</td>
					<td>${d.discountFare}</td>
					<td>${d.opFare}</td>
					<td>${d.mealName}</td>
					<td><fmt:formatDate value="${d.opTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>${d.opCount}</td>
					<td>${d.subsidyOpCount}</td>
					<td>${d.recordNO}</td>
					<td>${d.consumeType}</td>
					<td>${d.cookbookName}</td>
					<td>${d.cookbookCode}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'consumeRecordList')">
				<c:forEach begin="1" end="20" var="i" step="1">
					<option value='${i*10 }' <c:if test="${i*10==numPerPage }">selected</c:if> >${i*10 }</option>
				</c:forEach>
			</select>
			<span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" rel="consumeRecordList" totalCount="${totalCount }" numPerPage="${numPerPage }"
			pageNumShown="10" currentPage="${pageNum }"></div>
	</div>
</div>
