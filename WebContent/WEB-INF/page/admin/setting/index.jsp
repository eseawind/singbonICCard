<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>兴邦IC卡管理系统——后台</title>
<link href="/themes/default/style.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="/themes/css/core.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="/themes/css/print.css" rel="stylesheet" type="text/css"
	media="print" />
<!-- <link href="themes/css/contextMenu.css" rel="stylesheet" type="text/css" /> -->
<!-- <link href="uploadify/css/uploadify.css" rel="stylesheet" -->
<!-- 	type="text/css" media="screen" /> -->
<!--[if IE]>
<link href="themes/css/ieHack.css" rel="stylesheet" type="text/css" media="screen"/>
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
<!-- <script src="/js/comet4j.js" type="text/javascript"></script> -->
<script src="/js/jquery.contextmenu.r2.js" type="text/javascript"></script>
<script src="/js/jQuery.Hz2Py-min.js" type="text/javascript"></script>
<script src="/js/common.js" type="text/javascript"></script>
<script src="/js/jquery.timers.js" type="text/javascript"></script>
<!--
<script src="bin/dwz.min.js" type="text/javascript"></script>
-->
<script src="/js/dwz.regional.zh.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		DWZ.init('/dwz.frag.xml', {
			loginUrl : '/login_dialog.html',
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
	});
	
	function editPwd(){
		var specialOptions = {
				width : 300,
				height : 200,
				max : false,
				mask : true,
				mixable : false,
				minable : false,
				resizable : true,
				drawable : true,
				fresh : false
		};
		$.pdialog.open('../editPwd.do', 'dialog', '修改密码', specialOptions);
	}
</script>
</head>
<body scroll="no">
	<div id="layout">
		<div id="header">
			<div class="headerNav">
				<a class="logo" href="#">标志</a>
			</div>
		</div>

		<div id="leftside">
			<div id="sidebar_s">
				<div class="collapse">
					<div class="toggleCollapse">
						<div></div>
					</div>
				</div>
			</div>
			<div id="sidebar">
				<div class="toggleCollapse">
					<h2>主菜单</h2>
					<a style="padding: 7px 0 0 20px;float: left;color: #15428B;font-size: 11px;font-weight: bold;" href="javascript:;" onclick="editPwd();" title="修改密码"><span>修改密码</span></a>
					<a style="padding: 7px 0 0 20px;float: left;color: #15428B;font-size: 11px;font-weight: bold;" href="/singbon/backgroud/system/admin/loginout.do">登出</a>
					<div>收缩</div>
				</div>

				<div class="accordion" fillSpace="sidebar">
					<div class="accordionHeader">
						<h2>
							<span>Folder</span>系统设置
						</h2>
					</div>
					<div class="accordionContent">
						<ul class="tree">
							<li><a href="${base}/company/index.do" target="navTab">单位管理</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div id="container">
			<div id="navTab" class="tabsPage">
				<div class="tabsPageHeader">
					<div class="tabsPageHeaderContent">
						<!-- 显示左右控制时添加 class="tabsPageHeaderMargin" -->
						<ul class="navTab-tab">
							<li tabid="main" class="main"><a href="javascript:;"><span><span
										class="home_icon">欢迎首页</span></span></a></li>
						</ul>
					</div>
				</div>
				<div class="navTab-panel tabsPageContent layoutBox">
					<div class="page unitBox">
						<div class="pageFormContent" layoutH="80"
							style="margin-right: 230px"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>