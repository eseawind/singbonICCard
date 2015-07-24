<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>采集监控</title>
<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/js/comet4j.js"></script>
<link rel="stylesheet" type="text/css" href="/css/layout.css">
<script type="text/javascript">
	function getDeviceStatus(){
		$.post("/monitor/command.do?comm=getDeviceStatus");
		setTimeout("getDeviceStatus()",10000);
	}
	
	$(function() {
		init();
		getDeviceStatus();		
		//校验时间
		$('#time").click(function() {
			$.post("/monitor/command.do?comm=time");
		});

		//打开采集
		$('#collect").click(function() {
			$.post("/monitor/command.do?comm=start");
		});

		//清空
		$('#clear").click(function() {
			$('#record").html("<tr><td>消息</td></tr>");
		});
	});

	function init() {
		JS.Engine.start('/conn');
		JS.Engine.on({
			c1 : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				//心跳状态回复
				if(e2.f1==3 && e2.f2==8){
					var list=e2.msg;
					$.each(list, function (sn, v) {
						//alert(sn);
						if(v==1){
							$('#"+sn).css("color","blue");
						}else{
							$('#"+sn).css("color","black");							
						}
					});
				}
			}
		});
	}
</script>
</head>
<body>
	<table width="100%" height="500" border="1" cellpadding="0"
		cellspacing="0">
		<tr valign="top">
			<td rowspan="2" width="200" id="left"></td>
			<td id="devicelist" height="100">
				<c:forEach items="${deviceList}" var="d">
					<div class="item" id="${d.sn}">${d.name}</div>
				</c:forEach>
			</td>
		</tr>
		<tr valign="top">
			<td id="record">3</td>
		</tr>
	</table>
	<input type="button" value="校验时间" id="time" />
	<input type="button" value="采集" id="collect" />
	<input type="button" value="停止采集" id="closeCollect" />
	<input type="button" value="清空" id="clear" />
	<br />
	<div>
		<table id="record">
			<tr>
				<td>消息</td>
			</tr>
		</table>
	</div>
</body>
</html>