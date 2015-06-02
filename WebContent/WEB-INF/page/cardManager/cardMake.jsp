<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	function getCardReaderStatus() {
		$.post("/cardManager/command.do?comm=getCardReaderStatus");
	}

	$(function() {
		init();
		getCardReaderStatus();
		$("#test").click(function() {
			$.post("/cardManager/command.do?comm=test");
		});
		$("#search").click(function() {
			$.post("/cardManager/command.do?comm=search");
		});
		$("#cardno").click(function() {
			$.post("/cardManager/command.do?comm=cardno");
		});
	});

	function init() {
		JS.Engine.start('/conn');
		JS.Engine.on({
			'c${sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				//读卡器状态
				if (e2.f1 == 1) {
					if (e2.r == 1) {
						$("#status").html("在线");
					} else {
						$("#status").html("离线");
					}
				} else if (e2.f1 == 4) {
					$("#cardno2").html(e2.r);
				}
			}
		});
	}
</script>

<div>
<div id="cardno2"></div>
	<input type="button" id="test"/>
	<input type="button" id="search"/>
	<input type="button" id="cardno"/>
</div>
