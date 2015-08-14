<!-- 监控平台 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">
	var heartTime=new Date();
	
	$(function() {
// 		init();
		
	});
	
	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'c${sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
			}
		});
	}
	
	function heart(){
		$('body').everyTime('10s','getCardReaderStatus', function() {
			$.post('${base }/commang.do?comm=getCardReaderStatus');
			var d=new Date();
			var t=(g.getTime()-heartTime.getTime())/1000;
			if(t>=15){
				$.post('${base }/commang.do?comm=closeSocketChannel');
				$('body').stopTime();
			}
		},0,true);
	}
	
	function showDevice(groupId){
		if(groupId==0){
			$('#deviceList .deviceList').show();
		}else{
			$('#deviceList .deviceList').hide();
			$("#deviceList .deviceList[groupId="+groupId+"]").show();
		}
	}
	
</script>
<style type="text/css">
	#deviceGroupList{
		display: none;
	}
	.deviceList{
		float: left;
		height: 55px;
		width: 70px;
		text-align:center;
/* 		border: 1px solid red; */
		cursor: pointer;
	}
	.deviceList .name{
		margin-top: 2px;
	}
</style>

<div class="tabs">
	<div class="tabsContent" style="border: none;">
		<div>
			<!-- 设备分组 -->
			<div layoutH="10"
				style="float: left; display: block; overflow: auto; width: 170px; border: solid 1px #CCC; line-height: 21px; background: #fff;">
				<ul class="tree deviceGroupTree">
					<li groupId="0"><a onclick="showDevice(0);">终端分组列表</a>
						<ul>
						<c:forEach items="${deviceGroupList }" var="g">
							<li><a onclick="showDevice(${g.id });">${g.groupName }</a></li>
						</c:forEach>
						</ul></li>
				</ul>
			</div>
			<!-- 设备显示区域 -->
			<div id="deviceList" class="unitBox" style="margin-left: 175px;height:170px;border: solid 1px #CCC; background: #fff;overflow: auto;padding: 5px 0 0 5px;">
				<c:forEach items="${deviceList }" var="d">
					<div class="deviceList" id="${d.sn}" groupId="${d.groupId }">
						<img alt="在线" src="/img/online.png" />
						<div class="name">${d.deviceName}</div>
					</div>
					<div class="deviceList" id="${d.sn}" groupId="${d.groupId }">
						<img alt="离线" src="/img/offline.png" />
						<div class="name">${d.deviceName}</div>
					</div>
				</c:forEach>
			</div>
			<!-- 设备显示区域 end-->
			<!-- 监控信息显示区域 -->
			<div id="msgList" class="unitBox" style="margin-left: 175px;">
				<div class="tabs" currentIndex="0" eventType="click" style="margin-top:2px;" >
					<div class="tabsHeader">
						<div class="tabsHeaderContent">
							<ul>
								<li><a href="javascript:void();"><span>消费设备状态</span></a></li>
								<li><a href="javascript:void();"><span>消费记录监控</span></a></li>
								<li><a href="javascript:void();"><span>订餐信息监控</span></a></li>
								<li><a href="javascript:void();"><span>门禁考勤设备状态</span></a></li>
								<li><a href="javascript:void();"><span>考勤记录监控</span></a></li>
								<li><a href="javascript:void();"><span>日记监控</span></a></li>
							</ul>
						</div>
					</div>
					<div class="tabsContent" style="padding:0;" layoutH="210">
						<!-- 消费设备状态 -->
						<div id="deviceStatus">
							<table class="table" width="99%" layoutH="235" rel="jbsxBox" target="deviceStatus">
								<thead>
									<tr>
										<th width="40">序号</th>
										<th width="100">设备名称</th>
										<th width="100">地址</th>
										<th width="100">未采记录</th>
										<th width="100">全量版本</th>
										<th width="100">全量个数</th>
										<th width="100">状态</th>
										<th width="100">增量个数</th>
										<th width="100">最新卡号</th>
										<th width="100">批次个数</th>
										<th width="100">补助授权</th>
										<th width="100">获取时间</th>
										<th width="100">连机状态</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${deviceList }" var="d">
										<tr>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 消费设备状态 end-->
						<!-- 消费记录监控 -->
						<div id="consumeRecord">
							<table class="table" width="99%" layoutH="235" rel="jbsxBox" target="consumeRecord">
								<thead>
									<tr>
										<th width="40">序号</th>
										<th width="100">终端编号</th>
										<th width="100">用户编号</th>
										<th width="100">卡号</th>
										<th width="100">姓名</th>
										<th width="100">钱包余额</th>
										<th width="100">补助余额</th>
										<th width="100">管理费</th>
										<th width="100">操作额</th>
										<th width="100">餐别名称</th>
										<th width="100">交易时间</th>
										<th width="100">卡计数</th>
										<th width="100">记录序号</th>
										<th width="100">记录类型</th>
										<th width="100">菜肴名称</th>
										<th width="100">菜肴份数</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${consumeRecordList }" var="d">
										<tr>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 消费记录监控 end-->
						<!-- 订餐信息监控 -->
						<div id="cookbookRecord">
							<table class="table" width="99%" layoutH="235" rel="jbsxBox" target="cookbookRecord">
								<thead>
									<tr>
										<th width="40">序号</th>
										<th width="100">终端设备</th>
										<th width="100">用户编号</th>
										<th width="100">卡号</th>
										<th width="100">姓名</th>
										<th width="100">操作额</th>
										<th width="100">餐别名称</th>
										<th width="100">就餐时间</th>
										<th width="100">订餐时间</th>
										<th width="100">菜肴名称</th>
										<th width="100">菜肴份数</th>
										<th width="100">类别</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${cookbookRecordList }" var="d">
										<tr>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 订餐信息监控 end-->
						<!-- 门禁考勤设备状态 -->
						<div id="attendanceStatus">
							<table class="table" width="99%" layoutH="235" rel="jbsxBox" target="attendanceStatus">
								<thead>
									<tr>
										<th width="40">序号</th>
										<th width="100">终端名称</th>
										<th width="100">地址</th>
										<th width="100">未采记录</th>
										<th width="100">门状态</th>
										<th width="100">连机认证</th>
										<th width="100">获取时间</th>
										<th width="100">连机状态</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${attendanceStatusList }" var="d">
										<tr>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 门禁考勤设备状态 end-->
						<!-- 考勤记录监控 -->
						<div id="attendanceRecord">
							<table class="table" width="99%" layoutH="235" rel="jbsxBox" target="attendanceRecord">
								<thead>
									<tr>
										<th width="40">序号</th>
										<th width="100">终端编号</th>
										<th width="100">类型</th>
										<th width="100">用户编号</th>
										<th width="100">姓名</th>
										<th width="100">卡号</th>
										<th width="100">物理卡号</th>
										<th width="100">记录号</th>
										<th width="100">操作时间</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${attendanceRecordList }" var="d">
										<tr>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 考勤记录监控 end-->
						<!-- 日记监控 -->
						<div id="logRecord">
							<table class="table" width="99%" layoutH="235" rel="jbsxBox" target="logRecord">
								<thead>
									<tr>
										<th width="40">序号</th>
										<th width="100">日志时间</th>
										<th width="100">日期来源</th>
										<th width="100">日志描述</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${logRecordList }" var="d">
										<tr>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 日记监控 end-->
				</div>
			</div>
			<!-- 监控信息显示区域 end -->
		</div>
	</div>
</div>