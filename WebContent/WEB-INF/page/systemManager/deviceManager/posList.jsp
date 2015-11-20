<!-- 消费机列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	$(function(){
		$('#posList .search').click(function() {
			if($('.posForm input[name=includeSub]').attr('checked')){
				$('#posList #pagerForm input[name=includeSub]').val(1);				
			}else{
				$('#posList #pagerForm input[name=includeSub]').val('');				
			}
			divSearch($('#posList #pagerForm'), 'posList');
		});
	});
</script>
<style type="text/css">
</style>

<div class="pageHeader" style="border: 1px #B8D0D6 solid">
	<form action="${base}/posList.do" id="pagerForm">
		<input type="hidden" name="pageNum" value="${pageNum}" /> 
		<input type="hidden" name="numPerPage" value="${numPerPage}" /> 
		<input type="hidden" name="totalCount" value="${totalCount}" />
		<input type="hidden" name="deptId" value="${deptId}" />
		<input type="hidden" name="includeSub" value="${includeSub}" />
		<div class="searchBar">
			<table border="0">
				<tr align="right">
					<td>设备信息：</td>
					<td>
						<input type="text" name="nameStr" size="10" value="${nameStr }" />
					</td>
					<td style="padding-left: 10px;">所属中转：</td>
					<td>
						<select class="combox" outerw="50" innerw="70" name="transferId">
							<option value="-1">全部</option>
							<c:forEach items="${transferList }" var="t">
								<option value="${t.id }" <c:if test="${transferId==t.id}">selected="selected"</c:if>>${t.deviceName }</option>
							</c:forEach>
						</select>
					</td>
					<td style="padding-left: 10px;">
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="button" class="search">&nbsp;&nbsp;查询&nbsp;&nbsp;</button>
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
				<th width="80">机器号</th>
				<th width="120">设备名称</th>
				<th width="100">设备类型</th>
				<th width="100">所属中转</th>
				<th width="120">消费参数分组</th>
				<th width="300">序列号</th>
				<th width="80">状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${deviceList }" var="d" varStatus="status">
				<tr target="posList" id="${d.id }" deviceNum="${d.deviceNum}" deviceName="${d.deviceName}" deviceType="${d.deviceType}" transferId="${d.transferId}" paramGroupId="${d.paramGroupId}" sn="${d.sn}" enable="${d.enable}">
					<td>${status.index+1}</td>
					<td>${d.deviceNum}</td>
					<td>${d.deviceName}</td>
					<td>${d.deviceTypeDes}</td>
					<td>${d.transferName}</td>
					<td>${d.groupName}</td>
					<td>${d.sn }</td>
					<td>${d.enable==1?"启用":"禁用" }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value}, 'posList')">
				<c:forEach begin="1" end="20" var="i" step="1">
					<option value='${i*10 }'
						<c:if test="${i*10==numPerPage }">selected</c:if>>${i*10 }</option>
				</c:forEach>
			</select> <span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" rel="posList" totalCount="${totalCount }"
			numPerPage="${numPerPage }" pageNumShown="10"
			currentPage="${pageNum }"></div>
	</div>
</div>