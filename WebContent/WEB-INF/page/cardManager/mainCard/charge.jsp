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
	var oddFare=0;
	var cardOddFare=0;
	var opOddFare=0;

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
		
		$('#userInfo .ok').click(function() {
			validateCallback($(this).parents('form'), function(e) {
			}, null);
		});
		
		$('#userInfo .readCard').click(function() {
			if(isOnline){
				$.post('${base }/command.do?editType=5',function(e){
				});
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能读卡！');
			}
		});
		
		
		$('#userInfo input[name=chargeType]').click(function(){
			if($('#userInfo input[name=chargeType]:checked').val()==0){
				$('#userInfo input[name=opFare]').val(0);
				$('#userInfo input[name=giveFare]').attr("disabled",false);
				$('#userInfo input[name=backCardDeposit]').attr("disabled",true);
			}else{
				$('#userInfo input[name=opFare]').val(opOddFare);
				$('#userInfo input[name=giveFare]').attr("disabled",true);
				$('#userInfo input[name=backCardDeposit]').attr("disabled",false);
			}
		});
	});

	function getAllOddFare(){
		var opFareInput=$('#userInfo input[name=opFare]');
		var giveFareInput=$('#userInfo input[name=giveFare]');
		
		var opFare=0;
		var giveFare=0;

		if(opFareInput.val()!=''){
			opFare=opFareInput.val();
		}
		if(giveFareInput.val()!=''){
			giveFare=giveFareInput.val();
		}
		var chargeType=$('#userInfo input[name=chargeType]:checked').val();
		if(chargeType==0){
			var allOddFare=parseFloat(opOddFare)+parseFloat(opFare)+parseFloat(giveFare);
			if(allOddFare>167772.15){
				alertMsg.warn('总操作余额不能大于167772.15！');
			}
		}else{
			var allOddFare=opOddFare-opFare;
			if(allOddFare<0){
				alertMsg.warn('操作额不能大于余额！');		
			}
		}
	}
	
	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'c${sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				heartTime=new Date();
				//存在物理卡号
				if(e2.f1==0x7f){
					alertMsg.warn('该卡片已经发行，请放置新卡！');
				}
				//读卡器状态心跳
				else if (e2.f1 == 2 && e2.r == 1) {
					$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
					isOnline=true;
					if(!isHeart){
						heart();
						isHeart=true;
					}
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
							
							opOddFare=e2.oddFare<e4.oddFare?e2.oddFare:e4.oddFare;
							
							$('#userInfo #username').html(e4.username);
							$('#userInfo #userNO').html(e4.userNO);
							$('#userInfo #status').html(e4.statusDesc);
							
							$('#userInfo #oddFare').html(e4.oddFare);
							$('#userInfo #cardOddFare').html(e2.oddFare);
							$('#userInfo #subsidyOddFare').html(e4.subsidyOddFare);
							$('#userInfo #cardSubsidyOddFare').html(e2.subsidyOddFare);
							$('#userInfo #cardDeposit').html(e4.cardDeposit);
							
							$('#userInfo input[name=userId]').val(e4.userId);
							$('#userInfo input[name=cardNO]').val(e4.cardNO);
							$('#userInfo input[name=cardSN]').val(e4.cardSN);
							$('#userInfo input[name=cardDeposit]').val(e4.cardDeposit);
							
							oddFare=e4.oddFare;
							$('#userInfo input[name=oddFare]').val(e4.oddFare*100);
							$('#userInfo input[name=subsidyOddFare]').val(e4.subsidyOddFare*100);
							cardOddFare=e2.oddFare;
							$('#userInfo input[name=cardOddFare]').val(e2.oddFare*100);
							$('#userInfo input[name=cardSubsidyOddFare]').val(e2.subsidyOddFare*100);
							
							$('#userInfo input[name=cardInfoStr]').val(e2.cardInfoStr);
							
							$('#chargeLi').show();
						});
					}else{
						opCardResult(e2.r);
					}
				//存取款完成
				}else if(e2.f1==0x1b){
					if(e2.r==1){
						var opFare=$('#userInfo input[name=opFare]').val();
						var msg='存款完成！';
						var chargeType=$('#userInfo input[name=chargeType]:checked').val();
						if(chargeType==0){
							var giveFare=$('#userInfo input[name=giveFare]').val();
							opFare=parseFloat(opFare)+parseFloat(giveFare);
						}else{
							opFare=0-parseFloat(opFare);
							var msg='取款完成！';							
						}
						
						$('#chargeLi').hide();
						$('#userInfo').clearForm();
						$('#userInfo #oddFare').html(parseFloat(oddFare)+parseFloat(opFare));
						$('#userInfo #cardOddFare').html(parseFloat(cardOddFare)+parseFloat(opFare));
						$('#userInfo input[name=opFare]').val(0);
						$('#userInfo input[name=giveFare]').val(0);
						
						alertMsg.correct(msg);						
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
			if(t>=12){
				$.post('/closeSocketChannel.do');
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
</script>

<style type="text/css">
.dialog .pageFormContent {
	border-width: 0;
}

.dialog .pageFormContent dl {
	width: 270px;
}

.dialog .pageFormContent dt {
	width: 90px;
}

.dialog .pageFormContent dd {
	width: 120px;
}

.dialog .pageFormContent dd span.error {
	width: 85px;
	left: 220px;
}
</style>
<form id="userInfo" method="post" action="${base }/doCharge.do" class="pageForm required-validate">
<!-- 卡操作记录用 -->
	<input name="userId" type="hidden" /> 
	<input name="cardNO" type="hidden" /> 
	<input name="cardSN" type="hidden" /> 
	<input name="cardDeposit" type="hidden"/>
	<input name="oddFare" type="hidden"/>
	<input name="subsidyOddFare" type="hidden"/>
	<input name="cardOddFare" type="hidden"/>
	<input name="cardSubsidyOddFare" type="hidden"/>
	<input name="cardInfoStr" type="hidden"/> 
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
				<dt>卡押金：</dt>
				<dd id="cardDeposit"></dd>
			</dl>
			<dl>
				<dt>库大钱包余额：</dt>
				<dd id="oddFare"></dd>
			</dl>
			<dl>
				<dt>卡大钱包余额：</dt>
				<dd id="cardOddFare"></dd>
			</dl>
			<dl>
				<dt>库补助余额：</dt>
				<dd id="subsidyOddFare"></dd>
			</dl>
			<dl>
				<dt>卡补助余额：</dt>
				<dd id="cardSubsidyOddFare"></dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>操作类型</legend>
			<dl style="width: 500px;">
				<dt>存取类型：</dt>
				<dd style="width: 300px;">
					<label><input type="radio" name="chargeType" checked="checked" value="0" />存款  <input type="radio" name="chargeType" value="1" />取款</label>
					<input type="checkbox" name="backCardDeposit" checked="checked" disabled="disabled"/>退还卡押金
				</dd>
			</dl>
			<dl style="width: 500px;">
				<dt>操作金额：</dt>
				<dd>
					<input class="number required" name="opFare" type="text" value="0" onkeyup="getAllOddFare();"/>
				</dd>
			</dl>
			<dl style="width: 500px;">
				<dt>赠送金额：</dt>
				<dd>
					<input class="number required" name="giveFare" type="text" value="0" onkeyup="getAllOddFare();"/>
				</dd>
			</dl>
		</fieldset>
	</div>
	<div class="formBar">
		<ul>
			<li id="chargeLi" style="display: none;"><div class="button">
					<div class="buttonContent ok">
						<button type="button">确定</button>
					</div>
				</div></li>
			<li><div class="button">
					<div class="buttonContent readCard">
						<button type="button">读卡</button>
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
