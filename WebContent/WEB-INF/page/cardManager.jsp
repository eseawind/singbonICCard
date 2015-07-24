<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>读卡器</title>
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/comet4j.js"></script>
<link rel="stylesheet" type="text/css" href="/css/layout.css">
<script type="text/javascript">
	function getCardReaderStatus() {
		$.post("/cardManager/command.do?comm=getCardReaderStatus");
	}

	$(function() {
		init();
		getCardReaderStatus();
		$('#test").click(function(){
			$.post("/cardManager/command.do?comm=test");
		});
		$('#search").click(function(){
			$.post("/cardManager/command.do?comm=search");
		});
		$('#cardno").click(function(){
			$.post("/cardManager/command.do?comm=cardno");
		});
	});

	function init() {
		JS.Engine.start('/conn');
		JS.Engine.on({
			c1 : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				//读卡器状态
				if (e2.f1 == 1) {
					if (e2.r == 1) {
						$('#status").html("在线");
					}else{
						$('#status").html("离线");						
					}
				}else if(e2.f1==4){
						$('#cardno2").html(e2.r);											
				}
			}
		});
	}
</script>
</head>
<body>
	<div>
		读卡器状态：<div id="status"></div>
		卡号：<div id="cardno2"></div>
		<input type="button" id="test" value="测试"/><br/>
		<input type="button" id="search" value="寻卡"/><br/>
		<input type="button" id="cardno" value="卡号"/>
		
	</div>
</body>
</html>