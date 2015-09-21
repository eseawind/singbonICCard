<!-- 存取款 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">
	var isOnline=false;
	var isHeart=false;
	var title=null;
	var heartTime=new Date();

	$(function() {
		title = $('.dialogHeader_c h1').html().split('——')[0];
		if ('${cardStatus}' == 1) {
			$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
			isOnline=true;
			if(!isHeart){
				heart();
				isHeart=true;
			}
		} else {
			$('.dialogHeader_c h1').html(title + '——读卡机状态：离线');
			isOnline=false;
			isHeart=false;
			$('body').stopTime();
		}
		init();
		
		$('#userinfo .ok').click(function() {
			getAllOddCash();
			validateCallback($(this).parents('form'), function(e) {
			}, null);
		});
		
		$('#userinfo .readCard').click(function() {
			if(isOnline){
				$.post('${base }/command.do?comm=readCardOddFareInit',function(e){
				});
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能读卡！');
			}
		});
		$('#userinfo input[name=chargeType]').click(function(){
			var oddFare=$('#userinfo input[name=oddFare2]').val();
			if(oddFare==''){
				oddFare=0;
			}
			if($('#userinfo input[name=chargeType]:checked').val()==0){
				$('#userinfo input[name=opCash2]').val(0);
				$('#userinfo input[name=allOddCash]').val(oddFare);
			}else{
				$('#userinfo input[name=opCash2]').val(oddFare);
				$('#userinfo input[name=allOddCash]').val(0);				
			}
		});
	});

	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'c${sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				//存在物理卡号
				if(e2.f1==0x7f){
					alertMsg.warn('该卡片已经发行，请放置新卡！');
				}
				//读卡器状态
				else if (e2.f1 == 0x01) {
					if (e2.r == 1) {
						heartTime=new Date();
						$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
						isOnline=true;
						if(!isHeart){
							heart();
							isHeart=true;
						}
					} else {
						$('.dialogHeader_c h1').html(title + '——读卡机状态：离线');
						isOnline=false;
						isHeart=false;
						$('body').stopTime();
					}
				//心跳
				} else if (e2.f1 == 0x02) {
					heartTime=new Date();
				//读取卡余额命令
				} else if (e2.f1 == 0x1a) {
					if(e2.r==1){
						$.post('${base }/selectOddFareByUserIdCardSN.do?userId='+e2.userId+'&cardSN='+e2.cardSN,function(e3){
							var e4 = eval('(' + e3 + ')');
							if(e4.r==0){
								alertMsg.warn('库中不存在此卡！');
								return;																
							}
							if(e2.userId!=e4.userId || e2.cardNO!=e4.cardNO || e2.cardSN!=e4.cardSN){
								alertMsg.warn('卡库信息不一致！');
								return;
							}
							if(e2.status!=241){
								alertMsg.warn('该卡状态异常！');
								return;					
							}
							if(e4.status!=1){
								alertMsg.warn('该卡库中人员信息状态异常！');
								return;					
							}
							$('#userinfo #username').html(e4.username);
							$('#userinfo #userNO').html(e4.userNO);
							$('#userinfo #status').html(e4.statusDesc);
							$('#userinfo #oddFare').html(e2.oddFare);
							
							$('#userinfo input[name=userId]').val(e4.userId);
							$('#userinfo input[name=cardSN]').val(e4.cardSN);
							$('#userinfo input[name=oddFare2]').val(e2.oddFare);
							$('#userinfo input[name=cardInfoStr]').val(e2.cardInfoStr);
							
							$('#chargeLi').show();
						});
					}else{
						opCardResult(e2.r);
					}
				//存取款完成
				}else if(e2.f1==0x1b){
					if(e2.r==1){
						$('#chargeLi').hide();
						$('#userinfo').clearForm();
						alertMsg.correct('存取款成功！');
					}else{
						opCardResult(e2.r);
					}	
				}
				
			}
		});
	}
	
	function heart(){
		$('body').everyTime('10s','getCardReaderStatus', function() {
			var d=new Date();
			var t=(d.getTime()-heartTime.getTime())/1000;
			if(t>=15){
				$.post('${base }/command.do?comm=closeSocketChannel');
				$('.dialogHeader_c h1').html(title + '——读卡机状态：离线');
				isOnline=false;
				isHeart=false;
				$('body').stopTime();
			}
		},0,true);
	}
	
	function opCardResult(r){
		//1读卡器读写成功、2读卡器寻卡失败、3读卡器卡校验失败、4读卡器物理卡号不匹配、5读卡器读写卡失败。
		var msg='读卡机寻卡失败，请检查是否放卡！';
		if(r==3){
			msg='读卡机卡校验失败！';
		}else if(r==5){
			msg='读卡机读写卡失败！';			
		}
		alertMsg.warn(msg);		
	}
	
	function getAllOddCash(){
		var oddFare=$('#userinfo input[name=oddFare2]').val();
		var opCash=$('#userinfo input[name=opCash2]').val();
		if(opCash==''){
			opCash=0;
		}
		var chargeType=$('#userinfo input[name=chargeType]:checked').val();
		if(chargeType==0){
			var allOddCash=parseFloat(oddFare)+parseFloat(opCash);
			if(allOddCash>167772.15){
				alertMsg.warn('总操作余额不能大于167772.15！');		
			}else{
				$('#userinfo input[name=allOddCash]').val(allOddCash);
			}
		}else{
			var allOddCash=oddFare-opCash;
			if(allOddCash<0){
				alertMsg.warn('操作额不能大于余额！');		
			}else{
				$('#userinfo input[name=allOddCash]').val(allOddCash);
			}
		}
	}
</script>

<style type="text/css">
.dialog .pageFormContent {
	border-width: 0;
}

.dialog .pageFormContent dl {
	width: 270px;
}

.dialog .pageFormContent dt {
	width: 75px;
}

.dialog .pageFormContent dd {
	width: 120px;
}

.dialog .pageFormContent dd span.error {
	width: 85px;
	left: 220px;
}
</style>
<form id="userinfo" method="post" action="${base }/doCharge.do" class="pageForm required-validate">
	<input name="userId" type="hidden" /> 
	<input name="cardSN" type="hidden" /> 
	<input name="cardInfoStr" type="hidden"/> 
	<input name="oddFare2" type="hidden"/> 
	<div class="pageFormContent" layoutH="60">
		<fieldset>
			<legend>用户信息</legend>
			<dl>
				<dt>用户姓名：</dt>
				<dd id="username"></dd>
			</dl>
			<dl>
				<dt>用户编号：</dt>
				<dd id="userNO"></dd>
			</dl>
			<dl>
				<dt>状态：</dt>
				<dd id="status"></dd>
			</dl>
			<dl>
				<dt>卡余额：</dt>
				<dd id="oddFare"></dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>操作类型</legend>
			<dl style="width: 500px;">
				<dt>存取类型：</dt>
				<dd>
					<label><input type="radio" name="chargeType" checked="checked" value="0" />存款  <input type="radio" name="chargeType" value="1" />取款</label> 
				</dd>
			</dl>
			<dl style="width: 500px;">
				<dt>操作金额：</dt>
				<dd>
					<input class="number required" name="opCash2" type="text" value="0" onkeyup="getAllOddCash();"/>
				</dd>
			</dl>
			<dl style="width: 500px;">
				<dt>总操作余额：</dt>
				<dd>
					<input name="allOddCash" type="text" value="0" readonly="readonly"/>
				</dd>
			</dl>
		</fieldset>
	</div>
	<div class="formBar">
		<ul>
			<li><div class="button">
					<div class="buttonContent readCard">
						<button type="button">读卡</button>
					</div>
				</div></li>
			<li id="chargeLi" style="display: none;"><div class="button">
					<div class="buttonContent ok">
						<button type="button">确定</button>
					</div>
				</div></li>
			<li><div class="button">
					<div class="buttonContent">
						<button type="button" class="close">关闭</button>
					</div>
				</div>
				</li>
		</ul>
	</div>
</form>
