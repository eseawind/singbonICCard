<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>兴邦IC卡管理系统</title>
<link href="/themes/default/style.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="/themes/css/core.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="/themes/css/print.css" rel="stylesheet" type="text/css"
	media="print" />
<!-- <link href="/themes/css/contextMenu.css" rel="stylesheet" type="text/css" /> -->
<!-- <link href="uploadify/css/uploadify.css" rel="stylesheet" -->
<!-- 	type="text/css" media="screen" /> -->
<!--[if IE]>
<link href="/themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
<![endif]-->

<!--[if lte IE 9]>
<script src="/js/speedup.js" type="text/javascript"></script>
<![endif]-->

<script src="/js/jquery-1.7.2.js" type="text/javascript"></script>
<script src="/js/jquery.cookie.js" type="text/javascript"></script>
<script src="/js/jquery.validate.js" type="text/javascript"></script>
<script src="/js/jquery.bgiframe.js" type="text/javascript"></script>
<!-- <script src="xheditor/xheditor-1.2.1.min.js" type="text/javascript"></script> -->
<!-- <script src="xheditor/xheditor_lang/zh-cn.js" type="text/javascript"></script> -->
<!-- <script src="uploadify/scripts/jquery.uploadify.js" -->
<!-- 	type="text/javascript"></script> -->

<!-- svg图表  supports Firefox 3.0+, Safari 3.0+, Chrome 5.0+, Opera 9.5+ and Internet Explorer 6.0+ -->
<!-- <script type="text/javascript" src="chart/raphael.js"></script> -->
<!-- <script type="text/javascript" src="chart/g.raphael.js"></script> -->
<!-- <script type="text/javascript" src="chart/g.bar.js"></script> -->
<!-- <script type="text/javascript" src="chart/g.line.js"></script> -->
<!-- <script type="text/javascript" src="chart/g.pie.js"></script> -->
<!-- <script type="text/javascript" src="chart/g.dot.js"></script> -->

<script src="/js/dwz.core.js" type="text/javascript"></script>
<script src="/js/dwz.util.date.js" type="text/javascript"></script>
<script src="/js/dwz.validate.method.js" type="text/javascript"></script>
<script src="/js/dwz.regional.zh.js" type="text/javascript"></script>
<script src="/js/dwz.barDrag.js" type="text/javascript"></script>
<script src="/js/dwz.drag.js" type="text/javascript"></script>
<script src="/js/dwz.tree.js" type="text/javascript"></script>
<script src="/js/dwz.accordion.js" type="text/javascript"></script>
<script src="/js/dwz.ui.js" type="text/javascript"></script>
<script src="/js/dwz.theme.js" type="text/javascript"></script>
<script src="/js/dwz.switchEnv.js" type="text/javascript"></script>
<script src="/js/dwz.alertMsg.js" type="text/javascript"></script>
<script src="/js/dwz.contextmenu.js" type="text/javascript"></script>
<script src="/js/dwz.navTab.js" type="text/javascript"></script>
<script src="/js/dwz.tab.js" type="text/javascript"></script>
<script src="/js/dwz.resize.js" type="text/javascript"></script>
<script src="/js/dwz.dialog.js" type="text/javascript"></script>
<script src="/js/dwz.dialogDrag.js" type="text/javascript"></script>
<script src="/js/dwz.sortDrag.js" type="text/javascript"></script>
<script src="/js/dwz.cssTable.js" type="text/javascript"></script>
<script src="/js/dwz.stable.js" type="text/javascript"></script>
<script src="/js/dwz.taskBar.js" type="text/javascript"></script>
<script src="/js/dwz.ajax.js" type="text/javascript"></script>
<script src="/js/dwz.pagination.js" type="text/javascript"></script>
<script src="/js/dwz.database.js" type="text/javascript"></script>
<script src="/js/dwz.datepicker.js" type="text/javascript"></script>
<script src="/js/dwz.effects.js" type="text/javascript"></script>
<script src="/js/dwz.panel.js" type="text/javascript"></script>
<script src="/js/dwz.checkbox.js" type="text/javascript"></script>
<script src="/js/dwz.history.js" type="text/javascript"></script>
<script src="/js/dwz.combox.js" type="text/javascript"></script>
<script src="/js/dwz.print.js" type="text/javascript"></script>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script src="/js/jquery.contextmenu.r2.js" type="text/javascript"></script>
<script src="/js/jQuery.Hz2Py-min.js" type="text/javascript"></script>
<script src="/js/common.js" type="text/javascript"></script>
<script src="/js/jquery.timers.js" type="text/javascript"></script>
<!--
<script src="bin/dwz.min.js" type="text/javascript"></script>
-->
<script src="/js/dwz.regional.zh.js" type="text/javascript"></script>
<script type="text/javascript">
	var maxRow=1000;
	$(function() {
// 		window.moveTo(0, 0);
// 		window.resizeTo(screen.availWidth, screen.availHeight);
		DWZ.init('/dwz.frag.xml', {
			loginUrl : 'login_dialog.html',
			loginTitle : '登录', // 弹出登录对话框
			//		loginUrl:'login.html',	// 跳到登录页面
			statusCode : {
				ok : 200,
				error : 300,
				timeout : 301
			}, //【可选】
			pageInfo : {
				pageNum : 'pageNum',
				numPerPage : 'numPerPage',
				orderField : 'orderField',
				orderDirection : 'orderDirection'
			}, //【可选】
			debug : false, // 调试模式 【true|false】
			callback : function() {
				initEnv();
				$('#themeList').theme({
					themeBase : 'themes'
				}); // themeBase 相对于index页面的主题base路径
			}
		});
		DWZ.ui.sbar=false;
		init();
		
		//初始添加在线设备
		<c:forEach items="${deviceList }" var="d">
			<c:if test="${d.isOnline==1}">
				map.put("${d.sn}",new Date());
			</c:if>
		</c:forEach>
		heart();
		
		$('#deviceList img').contextMenu('menu',monitorOps);
// 		$('#logRecord tbody tr').contextMenu('clearMenu',clearOps);
	});
	
	var map = new Map();
	function Map(){
		this.container = new Object();
	}

	Map.prototype.put = function(key, value){
		this.container[key] = value;
	};

	Map.prototype.get = function(key){
		return this.container[key];
	};

	Map.prototype.keySet = function() {
		var keyset = new Array();
		var count = 0;
		for (var key in this.container) {
			// 跳过object的extend函数
			if (key == 'extend') {
				continue;
			}
			keyset[count] = key;
			count++;
		}
		return keyset;
	};

	Map.prototype.size = function() {
		var count = 0;
		for (var key in this.container) {
			// 跳过object的extend函数
			if (key == 'extend'){
				continue;
			}
			count++;
		}
		return count;
	};

	Map.prototype.remove = function(key) {
		delete this.container[key];
	};

	Map.prototype.toString = function(){
		var str = "";
		for (var i = 0, keys = this.keySet(), len = keys.length; i < len; i++) {
			str = str + keys[i] + "=" + this.container[keys[i]] + ";\n";
		}
		return str;
	};
	
	var logIndex=1;
	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'Co${sessionScope.company.id}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
			    //状态
				if(e2.type=='status'){
					var sn=e2.sn;
					$("#deviceList .deviceList[id="+sn+"] img").attr('alt','在线').attr('src','/img/online.png');
					map.put(sn,new Date());
				//日志
				}else if(e2.type=='log'){
					if(logIndex>=maxRow){
						logIndex=0;
						$('#logRecord tbody tr td div').empty();
					}
					var tr=$("#logRecord tbody tr[index="+logIndex+"]");					
					tr.find('td[index] div').html(logIndex);
					tr.find('td[time] div').html(e2.time);
					tr.find('td[from] div').html(e2.from);
					tr.find('td[des] div').html(e2.des);
					logIndex++;
// 					$('#logRecord tbody').append(tempRow.wrap('<tr></tr>'));
// 					$("#logRecord .gridTbody").scrollTop($("#logRecord .gridTbody")[0].scrollHeight);
					
				}
			}
		});
	}
	
	function heart(){
		$('body').everyTime('1s','getCardReaderStatus', function() {
			var d=new Date();
			var array = map.keySet();
			for(var i in array) {
				var t=(d.getTime()-map.get(array[i]).getTime())/1000;
				if(t>12){
					$("#deviceList .deviceList[id="+array[i]+"] img").attr('alt','离线').attr('src','/img/offline.png');
// 					$.post('${base }/closeDatagramChannel.do?sn='+array[i]);
					$.post('${base }/removeInetSocketAddress.do?sn='+array[i]);
					map.remove(array[i]);
				}
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
	
	var monitorOps = {
		bindings : {
			'sysTime' : function(t, target) {
				executeCmd(t,'sysTime');
			},
			'sysPara' : function(t, target) {
				executeCmd(t,'sysPara');
			},
			'discount' : function(t, target) {
				executeCmd(t,'discount');
			},
			'cookbook' : function(t, target) {
				executeCmd(t,'cookbook');
			},
			'sysInit' : function(t, target) {
				executeCmd(t,'sysInit');
			}
		},
		onShowMenu : function(e, menu) {
//  			if (!$(e.target).parents('tbody').hasClass('userList')) {
//  				$('#edit', menu).remove();
//  			}
			return menu;
		}
	};
	
	var clearOps = {
		bindings : {
			'clear' : function(t, target) {
				if($(t).hasClass('log')){
					logIndex=0;
				}
				$('tr td div', t).empty();
			}
		},
		onShowMenu : function(e, menu) {
//  			if (!$(e.target).parents('tbody').hasClass('userList')) {
//  				$('#edit', menu).remove();
//  			}
			return menu;
		}
	};

	//执行命令
	function executeCmd(t,cmd){
		var online=$(t).attr('src').indexOf('online');
		if(online>0){
			var sn=$(t).parent().attr('id');
			$.post("${base }/command.do?cmd="+cmd+"&sn="+sn);
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

		margin-top: 2px;
	}
	#container {
		top: 0;
		left: 0;
	}
	#splitBar {
		display: none;
	}
	.tabsPage .tabsPageContent {
		border-style: none;;
		border-width: 0;
	}
	.tabs .tabsContent {
/* 		padding: 0; */
	}
</style>
</head>
<body scroll="no">
	<div class="contextMenu" id="menu" style="display: none;">
		<ul>
			<li id="sysTime">校验时间</li>
			<li id="sysPara">系统参数</li>
			<li id="sysPwd">系统密码</li>
			<li id="discount">折扣费率及管理费</li>
<!-- 								<li class="divide" /> -->
			<li id="batchBlack">批次名单</li>
			<li id="allAppend">全量名单</li>
			<li id="incAppend">增量名单</li>
<!-- 								<li class="divide" /> -->
			<li id="cookbook">菜肴清单</li>
<!-- 								<li class="divide" /> -->
			<li id="sysInit">初始化</li>
		</ul>
	</div>
	<div class="contextMenu" id="clearMenu" style="display: none;">
		<ul>
			<li id="clear">清空日志</li>
		</ul>
	</div>
	<div id="layout" layoutH="0">
		<div id="container" layoutH="0">
			<div id="navTab" class="tabsPage" layoutH="0">
				<div class="navTab-panel tabsPageContent layoutBox" layoutH="0">
					<div class="page unitBox">
						
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
									<div id="deviceList" class="unitBox" style="margin-left: 175px;height:240px;border: solid 1px #CCC; background: #fff;overflow: auto;padding: 5px 0 0 5px;">
										<c:forEach items="${deviceList }" var="d">
											<div class="deviceList" id="${d.sn}" groupId="${d.groupId }">
												<c:if test="${d.isOnline==1}">
													<img alt="在线" src="/img/online.png" />
												</c:if>
												<c:if test="${d.isOnline==0}">
													<img alt="离线" src="/img/offline.png" />
												</c:if>
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
													<table class="table" width="99%" layoutH="300" rel="jbsxBox" target="logRecord">
														<thead>
															<tr>
																<th width="20">序号</th>
																<th width="50">日志时间</th>
																<th width="50">日期来源</th>
																<th width="200">日志描述</th>
															</tr>
														</thead>
														<tbody class="clearLog log">
															<c:forEach begin="1" end="1000" step="1" var="i">
																<tr index="${i}"><td index></td><td time></td><td from></td><td des></td></tr>
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
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>