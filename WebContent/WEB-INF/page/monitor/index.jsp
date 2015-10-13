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
<!-- <link href="/themes/css/print.css" rel="stylesheet" type="text/css" -->
<!-- 	media="print" /> -->
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

<!-- <script src="/js/jquery.cookie.js" type="text/javascript"></script> -->
<!-- <script src="/js/jquery.validate.js" type="text/javascript"></script> -->
<!-- <script src="/js/jquery.bgiframe.js" type="text/javascript"></script> -->
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

<!-- <script src="/js/dwz.util.date.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.validate.method.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.regional.zh.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.drag.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.accordion.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.theme.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.switchEnv.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.alertMsg.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.contextmenu.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.resize.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.dialog.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.dialogDrag.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.sortDrag.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.taskBar.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.database.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.datepicker.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.effects.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.checkbox.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.history.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.combox.js" type="text/javascript"></script> -->
<!-- <script src="/js/dwz.print.js" type="text/javascript"></script> -->

<script src="/js/dwz.core.js" type="text/javascript"></script>
<script src="/js/dwz.barDrag.js" type="text/javascript"></script>
<script src="/js/dwz.tree.js" type="text/javascript"></script>
<script src="/js/dwz.ui.js" type="text/javascript"></script>
<script src="/js/dwz.navTab.js" type="text/javascript"></script>
<script src="/js/dwz.tab.js" type="text/javascript"></script>
<script src="/js/dwz.cssTable.js" type="text/javascript"></script>
<script src="/js/dwz.stable.js" type="text/javascript"></script>
<script src="/js/dwz.ajax.js" type="text/javascript"></script>
<script src="/js/dwz.pagination.js" type="text/javascript"></script>
<script src="/js/dwz.panel.js" type="text/javascript"></script>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script src="/js/jquery.contextmenu.r2.js" type="text/javascript"></script>
<script src="/js/jquery.timers.js" type="text/javascript"></script>
<script type="text/javascript">
	var maxRow=100;
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
	var consumeRecordIndex=1;
	var cookbookconsumeRecordIndex=1;
	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'Co${sessionScope.company.id}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
			    //状态
				if(e2.type=='status'){
					var sn=e2.sn;
					map.put(sn,new Date());
					$("#deviceList .device[id="+sn+"] img").attr('alt','在线').attr('src','/img/online.png');
					var statusTr=$("#deviceStatusList tr.deviceStatus[id="+sn+"]");
					$('td[recordNum] div',statusTr).html(e2.recordNum);
					$('td[batchNum] div',statusTr).html(e2.batchNum);
					$('td[blackNum] div',statusTr).html(e2.blackNum);
					$('td[subsidyVersion] div',statusTr).html(e2.subsidyVersion);
					$('td[subsidyAuth] div',statusTr).html(e2.subsidyAuth==1?'是':'否');
				//消费记录
				}else if(e2.type=='consumeRecord'){
					var sn=e2.sn;
					map.put(sn,new Date());
					$("#deviceList .device[id="+sn+"] img").attr('alt','在线').attr('src','/img/online.png');
					if(consumeRecordIndex>=maxRow){
						consumeRecordIndex=0;
						$('#consumeRecord tbody tr td div').empty();
					}
					var tr=$("#consumeRecord tbody tr[index="+consumeRecordIndex+"]");					
					$('td[index] div',tr).html(consumeRecordIndex);
					$('td[deviceNum] div',tr).html(e2.consumeRecord.deviceNum);
					$('td[userNO] div',tr).html(e2.consumeRecord.userNO);
					$('td[cardNO] div',tr).html(e2.consumeRecord.cardNO);
					$('td[username] div',tr).html(e2.consumeRecord.username);
					$('td[cardOddFare] div',tr).html(e2.consumeRecord.cardOddFare/100);
					$('td[subsidyOddFare] div',tr).html(e2.consumeRecord.subsidyOddFare/100);
					$('td[discountFare] div',tr).html(e2.consumeRecord.discountFare/100);
					$('td[oppFare] div',tr).html((e2.consumeRecord.cardOpFare+e2.consumeRecord.subsidyOpFare)/100);
					$('td[mealName] div',tr).html(e2.consumeRecord.mealName);
					$('td[opTimeDes] div',tr).html(e2.consumeRecord.opTimeDes);
					$('td[cardOpCount] div',tr).html(e2.consumeRecord.cardOpCount);
					$('td[subsidyOpCount] div',tr).html(e2.consumeRecord.subsidyOpCount);
					$('td[recordNO] div',tr).html(e2.consumeRecord.recordNO);
					$('td[consumeTypeDes] div',tr).html(e2.consumeRecord.consumeTypeDes);
					$('td[cookbookName] div',tr).html(e2.consumeRecord.cookbookName);
					$('td[cookbookCode] div',tr).html(e2.consumeRecord.cookbookCode);
					consumeRecordIndex++;
				//订餐取餐记录
				}else if(e2.type=='cookbookRecord'){
					var sn=e2.sn;
					map.put(sn,new Date());
					$("#deviceList .device[id="+sn+"] img").attr('alt','在线').attr('src','/img/online.png');
					if(cookbookRecordIndex>=maxRow){
						cookbookRecordIndex=0;
						$('#cookbookRecord tbody tr td div').empty();
					}
					var tr=$("#cookbookRecord tbody tr[index="+consumeRecordIndex+"]");					
					$('td[index] div',tr).html(logIndex);
					$('td[deviceNum] div',tr).html(e2.consumeRecord.deviceNum);
					$('td[userNO] div',tr).html(e2.consumeRecord.userNO);
					$('td[username] div',tr).html(e2.consumeRecord.username);
					$('td[cardOddFare] div',tr).html(e2.consumeRecord.cardOddFare);
					$('td[subsidyOddFare] div',tr).html(e2.consumeRecord.subsidyOddFare);
					$('td[discountFare] div',tr).html(e2.consumeRecord.discountFare);
					$('td[oppFare] div',tr).html(e2.consumeRecord.oppFare);
					$('td[mealName] div',tr).html(e2.consumeRecord.mealName);
					$('td[opTime] div',tr).html(e2.consumeRecord.opTime);
					$('td[cardOpCount] div',tr).html(e2.consumeRecord.cardOpCount);
					$('td[subsidyOpCount] div',tr).html(e2.consumeRecord.subsidyOpCount);
					$('td[recordNO] div',tr).html(e2.consumeRecord.recordNO);
					$('td[consumeTypeDes] div',tr).html(e2.consumeRecord.consumeTypeDes);
					$('td[cookbookName] div',tr).html(e2.consumeRecord.cookbookName);
					$('td[cookbookCode] div',tr).html(e2.consumeRecord.cookbookCode);
					cookbookRecordIndex++;
				//日志
				}else if(e2.type=='log'){
					if(logIndex>=maxRow){
						logIndex=0;
						$('#log tbody tr td div').empty();
					}
					var tr=$("#log tbody tr[index="+logIndex+"]");					
					$('td[index] div',tr).html(logIndex);
					$('td[time] div',tr).html(e2.time);
					$('td[from] div',tr).html(e2.from);
					$('td[des] div',tr).html(e2.des);
					logIndex++;
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
				if(t>30){
					$("#deviceList .device[id="+array[i]+"] img").attr('alt','离线').attr('src','/img/offline.png');
					$.post('${base }/removeInetSocketAddress.do?sn='+array[i]);
					map.remove(array[i]);
				}
			}
		},0,true);
	}
	
	function showDevice(groupId){
		if(groupId==0){
			$('#deviceList .device').show();
		}else{
			$('#deviceList .device').hide();
			$("#deviceList .device[groupId="+groupId+"]").show();
		}
	}
	
	var monitorOps = {
		menuStyle: {
			width: '120px'
		},
		bindings : {
			'sysTime' : function(t, target) {
				executeCmd(t,'sysTime');
			},
			'baseConsumeParam' : function(t, target) {
				executeCmd(t,'baseConsumeParam');
			},
			'deviceParam' : function(t, target) {
				executeCmd(t,'deviceParam');
			},
			'allCookbook' : function(t, target) {
				executeCmd(t,'allCookbook');
			},
			'appendCookbook' : function(t, target) {
				executeCmd(t,'appendCookbook');
			},
			'singelCookbook' : function(t, target) {
				targetSN=$(t).parent().attr('id');
				$('.singleCookbook').show();
			},
			'clear' : function(t, target) {
				executeCmd(t,'clear');
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
				}else if($(t).hasClass('consumeRecord')){
					consumeRecordIndex=0;
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
	function setCodeNull(){
		var code=$('#jqContextMenu .singleCookbook #code').val();
		if(code=="编号"){
			$('#jqContextMenu .singleCookbook #code').val("")
		}
	}
	
	var targetSN=null;
	function singleCookbook(){
		var online=$('#'+targetSN).find('img').attr('src').indexOf('online');
// 		if(online>0){
			var code=$('#jqContextMenu .singleCookbook #code').val();
			var ex=/^\d+$/;
			if(ex.test(code)){
				if(code>2000){
					alert('菜单编号不能大于2000！');
					return;					
				}
				$.post("${base }/command.do?cmd=singleCookbook&sn="+targetSN+"&cookbookCode="+code);
				$('.singleCookbook').hide();
			}else{
				alert('请输入正确的菜单编号！');
			}
// 		}
	}
</script>
<style type="text/css">
	#deviceGroupList{
		display: none;
	}
	.device{
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
			<li id="baseConsumeParam">消费类参数</li>
			<li id="deviceParam">设备参数</li>
<!-- 			<li id="discount">折扣费率及管理费</li> -->
			<li class="divide" />
			<li id="batchBlack">批次名单</li>
			<li id="allAppend">全量名单</li>
			<li id="incAppend">增量名单</li>
			<li class="divide" />
			<li id="allCookbook">全部菜肴清单</li>
			<li id="appendCookbook">追加菜肴清单</li>
			<li id="singelCookbook">更新指定菜肴</li>
			<li class="singleCookbook" style="display: none;">
				<input type="text" id="code" value="编号" style="width: 35px;" onmousedown ="setCodeNull();"/><input type="button" value="确定" onclick="singleCookbook();"/>
			</li>
			<li class="divide" />
			<li id="clear">清空命令</li>
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
											<div class="device" id="${d.sn}" groupId="${d.groupId }">
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
												<div id="deviceStatusList">
													<table class="table" width="99%" layoutH="300" rel="jbsxBox" target="deviceStatus">
														<thead>
															<tr>
																<th width="100">设备名称</th>
																<th width="100">机器号</th>
																<th width="100">未采记录</th>
																<th width="100">批次个数</th>
																<th width="100">黑名单个数</th>
																<th width="100">补助版本号</th>
																<th width="100">补助授权</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach items="${deviceList }" var="d">
																<tr class="deviceStatus" id="${d.sn}" groupId="${d.groupId }">
																	<td>${d.deviceName }</td>
																	<td>${d.deviceNum }</td>
																	<td recordNum></td>
																	<td batchNum></td>
																	<td blackNum></td>
																	<td subsidyVersion></td>
																	<td subsidyAuth></td>
																</tr>
															</c:forEach>
														</tbody>
													</table>
												</div>
												<!-- 消费设备状态 end-->
												<!-- 消费记录监控 -->
												<div id="consumeRecord">
													<table class="table" width="99%" layoutH="300" rel="jbsxBox" target="consumeRecord">
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
																<th width="1">操作时间</th>
																<th width="100">卡计数</th>
																<th width="100">补助卡计数</th>
																<th width="100">记录序号</th>
																<th width="100">记录类型</th>
																<th width="100">菜肴名称</th>
																<th width="100">菜肴份数</th>
															</tr>
														</thead>
														<tbody>
															<tbody class="clearLog consumeRecord">
															<c:forEach begin="1" end="100" step="1" var="i">
																<tr index="${i}">
																	<td index></td>
																	<td deviceNum></td>
																	<td userNO></td>
																	<td cardNO></td>
																	<td username></td>
																	<td cardOddFare></td>
																	<td subsidyOddFare></td>
																	<td discountFare></td>
																	<td oppFare></td>
																	<td mealName></td>
																	<td opTimeDes></td>
																	<td cardOpCount></td>
																	<td subsidyOpCount></td>
																	<td recordNO></td>
																	<td consumeTypeDes></td>
																	<td cookbookName></td>
																	<td cookbookCode></td>
																</tr>
															</c:forEach>
														</tbody>
														</tbody>
													</table>
												</div>
												<!-- 消费记录监控 end-->
												<!-- 订餐信息监控 -->
												<div id="cookbookRecord">
													<table class="table" width="99%" layoutH="300" rel="jbsxBox" target="cookbookRecord">
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
													<table class="table" width="99%" layoutH="300" rel="jbsxBox" target="attendanceStatus">
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
													<table class="table" width="99%" layoutH="300" rel="jbsxBox" target="attendanceRecord">
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
												<div id="log">
													<table class="table" width="99%" layoutH="300" rel="jbsxBox" target="log">
														<thead>
															<tr>
																<th width="20">序号</th>
																<th width="50">日志时间</th>
																<th width="50">日期来源</th>
																<th width="100">日志描述</th>
															</tr>
														</thead>
														<tbody class="clearLog log">
															<c:forEach begin="1" end="100" step="1" var="i">
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