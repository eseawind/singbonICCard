<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	$(function(){
		$('.exportExcel').click(function(){
			$('#cardRecordList #pagerForm input[name=export]').val(1);
			$('#cardRecordList #pagerForm input[name=exportType]').val($(this).attr('exportType'));
			$('#cardRecordList #pagerForm').submit();
			$('#cardRecordList #pagerForm input[name=export]').val('');
			$('#cardRecordList #pagerForm input[name=exportType]').val('');
		});
	});
	$(function(){
		$('#cardRecordList .search').click(function(){
			divSearch($('#cardRecordList #pagerForm'),'cardRecordList');
		});
	});
</script>
<style type="text/css">
	.inputDateButton{
		float: right;
	}
	.recordType{
/* 		display: none; */
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
					<td width="60">查询类型：</td>
					<td align="left">
						<select class="combox" outerw="80" innerw="120" name="queryType">
							<option value="0" width="120" <c:if test="${queryType==0}">selected="selected"</c:if>>统计查询</option>
							<option value="1" width="120" <c:if test="${queryType==1}">selected="selected"</c:if>>明细查询</option>
						</select>
					</td>
					<td width="60">出纳员：</td>
					<td align="left">
						<select class="combox" outerw="80" innerw="100" name="operId">
							<option value="0" width="100">全部</option>
							<c:forEach var="u" items="${sysUserList}" varStatus="status">
								<option value="${u.operId}" width="70" <c:if test="${u.operId==operId}">selected</c:if> >${u.loginName}</option>
							</c:forEach>
						</select>
					</td>
					<td width="70" class="recordType">记录类型：</td>
					<td align="left" class="recordType">
						<select class="combox" outerw="80" innerw="120" name="recordType">
							<option value="-1" width="120" <c:if test="${status.index==-1}">selected</c:if>>全部</option>
							<c:forEach var="r" items="${recordTypes}" varStatus="status">
								<option value="${status.index}" width="120" <c:if test="${status.index==recordType}">selected</c:if>>${r}</option>
							</c:forEach>
						</select>
					</td>	
					<td width="70">操作日期：</td>
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
	<c:if test="${queryType==0}">
		<table class="table" width="99%" layoutH="120">
			<thead>
				<tr>
					<th width="40">序号</th>
					<th width="80">出纳员</th>
					<th width="80">发卡金额</th>
					<th width="80">发卡数量</th>
					<th width="80">收取卡押金</th>
					<th width="100">发卡赠送金额</th>
					<th width="60">补卡</th>
					<th width="60">挂失</th>
					<th width="60">解挂</th>
					<th width="60">PC存款</th>
					<th width="100">存款赠送金额</th>
					<th width="60">PC取款</th>
					<th width="100">退还卡押金</th>
					<th width="120">消费机补助存款</th>
					<th width="120">消费机补助清零</th>
					<th width="100">水控补助存款</th>
					<th width="100">水控补助清零</th>
					<th width="60">卡注销</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="c" items="${list}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>${c.loginName}</td>
						<td>${c.makeCardFare}</td>
						<td>${c.makeCardCount}</td>
						<td>${c.getCardDeposit}</td>
						<td>${c.makeCardGiveFare}</td>
						<td>${c.remakeCard}</td>
						<td>${c.loss}</td>
						<td>${c.unloss}</td>
						<td>${c.PCSaving}</td>
						<td>${c.PCSavingGiveFare}</td>
						<td>${c.PCTake}</td>
						<td>${c.backCardDepostFare}</td>
						<td>${c.posSubsidySaving}</td>
						<td>${c.posSubsidyClear}</td>
						<td>${c.waterSubsidySaving}</td>
						<td>${c.waterSubsidyClear}</td>
						<td>${c.cardOff}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${queryType==1}">
		<table class="table" width="99%" layoutH="148">
			<thead>
				<tr>
					<th width="40">序号</th>
					<th width="100">出纳员姓名</th>
					<th width="100">姓名</th>
					<th width="100">编号</th>
					<th width="100">卡号</th>
					<th width="100">物理卡号</th>
					<th width="120">操作类型</th>
					<th width="100">操作额</th>
					<th width="120">操作前库大钱包</th>
					<th width="150">操作前库补助钱包</th>
					<th width="120">操作前卡大钱包</th>
					<th width="150">操作前卡补助钱包</th>
					<th width="150">操作时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="c" items="${list}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>${c.loginName}</td> 
						<td>${c.username}</td>
						<td>${c.userNO}</td>
						<td>${c.cardNO}</td>
						<td>${c.cardSN}</td>
						<td>${c.recordTypeDes}</td> 
						<td>${c.opFare}</td>
						<td>${c.oddFare}</td>
						<td>${c.subsidyOddFare}</td>
						<td>${c.cardOddFare}</td>
						<td>${c.cardSubsidyOddFare}</td>
						<td>${c.opTime}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="panelBar">
			<div class="pages">
				<span>每页显示</span> <select class="combox" name="numPerPage"
					onchange="navTabPageBreak({numPerPage:this.value}, 'cardRecordList')">
					<c:forEach begin="1" end="20" var="i" step="1">
						<option value='${i*10 }' <c:if test="${i*10==numPerPage }">selected</c:if> >${i*10 }</option>
					</c:forEach>
				</select>
				<span>条，共${totalCount}条</span>
			</div>
	
			<div class="pagination" rel="cardRecordList" totalCount="${totalCount }" numPerPage="${numPerPage }"
				pageNumShown="10" currentPage="${pageNum }"></div>
		</div>
	</c:if>
</div>
