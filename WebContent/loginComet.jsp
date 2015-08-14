<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="/js/jquery-1.7.2.js"></script>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">
	
	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'start' : function(cId){
				isInit=true;
				valCashierCard();
			},
			'c${param.sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				if(e2.f1==0x71){
					var cardNO= $('#login-box input[name=cardNO]').val();
					var cardSN= $('#login-box input[name=cardSN]').val();
					
					if(cardNO==e2.cardNO && cardSN==e2.cardSN){
					}else{
						$('#login-box #errInfo').show();								
					}	
				}
			}
		});
	}
	init();
</script>