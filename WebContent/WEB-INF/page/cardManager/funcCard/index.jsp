<!-- 功能卡制作 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		
	});
	
	$('#makeCashierForm .makeCashierCard').click(function() {
		if(isOnline){
			var operId=$('#makeCashierForm input[name=operId]').val();
			if(operId!=''){
				if($(this).parents('form').valid()){
					$.post('${base }/command.do?comm=makeCashierCardInit');
				}
			}else{
				alertMsg.warn('请选择出纳员！');
			}
		}else{
			alertMsg.warn('读卡机当前处于离线状态不能制卡！');
		}
	});
	$('#lossForm .loss').click(function() {
		var operId=$('#lossForm input[name=operId]').val();
		if(operId==''){
			alertMsg.warn('请选择出纳员！');
			return;
		}
		var lossType=$('#lossForm input[name=lossType]:checked').val();
		if(lossType==0){
			validateCallback($('#lossForm'), function(e) {
				if(e==1){
					refreshCashierList();
					alertMsg.correct('出纳卡挂失完成！');
				}else{
					alertMsg.warn('出纳卡挂失失败！');					
				}
			}, null);
		}else{
			if(isOnline){
				$.post('${base }/command.do?comm=lossCashierCardInit');
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能挂失！');
			}
		}
	});
	$('#unLossForm .unLoss').click(function() {
		var operId=$('#unLossForm input[name=operId]').val();
		if(operId==''){
			alertMsg.warn('请选择出纳员！');
			return;
		}
		
		if(isOnline){
			$.post('${base }/command.do?comm=unLossCashierCardInit');
		}else{
			alertMsg.warn('读卡机当前处于离线状态不能解挂！');
		}
	});
	$('#remakeCashierCardForm .remakeCashierCard').click(function() {
		var operId=$('#remakeCashierCardForm input[name=operId]').val();
		if(operId==''){
			alertMsg.warn('请选择出纳员！');
			return;
		}
		
		if(isOnline){
			$.post('${base }/command.do?comm=remakeCashierCardInit');
		}else{
			alertMsg.warn('读卡机当前处于离线状态不能补卡！');
		}
	});
	$('#invalidDateForm .readCashierCard').click(function() {
		if(isOnline){
			$('#invalidDateForm').clearForm();
			$.post('${base }/command.do?comm=readCashierCardInit');
		}else{
			alertMsg.warn('读卡机当前处于离线状态不能读卡！');
		}
	}); 
	$('#invalidDateForm .invalidDate').click(function() {
		var operId=$('#invalidDateForm input[name=operId]').val();
		if(operId==''){
			alertMsg.warn('请先读取出纳卡！');
			return;
		}
		
		if(isOnline){
			validateCallback($('#invalidDateForm'), function(e) {
			}, null);
		}else{
			alertMsg.warn('读卡机当前处于离线状态不能修改有效期！');
		}
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
				else if (e2.f1 == 1) {
					if (e2.r == 1) {
						heartTime=new Date();
						$('#funcStatus').html('读卡机状态：在线');
						isOnline=true;
						if(!isHeart){
							heart();
							isHeart=true;
						}
					} else {
						$('#funcStatus').html('读卡机状态：离线');
						isOnline=false;
						isHeart=false;
						$('body').stopTime();
					}
				//心跳
				} else if (e2.f1 == 2) {
					heartTime=new Date();
				//制出纳卡命令
				} else if (e2.f1 == 0x10) {
					if(e2.r==1){
						$('#makeCashierForm input[name=cardSN]').val(e2.cardSN);
						validateCallback($('#makeCashierForm'), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//制出纳卡完成
				}else if(e2.f1==0x11){
					if(e2.r==1){
						$('#makeCashierForm').clearForm();
						refreshCashierList();
						alertMsg.correct('制出纳卡完成！');
					}else{
						opCardResult(e2.r);
					}					
				//挂失出纳卡命令
				} else if (e2.f1 == 0x12) {
					if(e2.r==1){
						var cardSN= $('#lossForm input[name=cardSN]').val();
						var operId= $('#lossForm input[name=operId]').val();
						if(e2.cardSN==cardSN && e2.operId==operId){
							$('#lossForm input[name=cardInfoStr]').val(e2.cardInfoStr);
							validateCallback($('#lossForm'), function(e) {
							}, null);
						}else{
							alertMsg.warn('该出纳卡和人员信息不匹配请换卡！');		
						}
					}else{
						opCardResult(e2.r);
					}
				//挂失出纳卡完成
				}else if(e2.f1==0x13){
					if(e2.r==1){
						$('#lossForm').clearForm();
						refreshCashierList();
						alertMsg.correct('挂失出纳卡完成！');
					}else{
						opCardResult(e2.r);
					}					
				//解挂出纳卡命令
				} else if (e2.f1 == 0x14) {
					if(e2.r==1){
						var cardSN= $('#unLossForm input[name=cardSN]').val();
						var operId= $('#unLossForm input[name=operId]').val();
						if(e2.cardSN==cardSN && e2.operId==operId){
							$('#unLossForm input[name=cardInfoStr]').val(e2.cardInfoStr);
							validateCallback($('#unLossForm'), function(e) {
							}, null);
						}else{
							alertMsg.warn('该出纳卡和人员信息不匹配请换卡！');		
						}
					}else{
						opCardResult(e2.r);
					}
				//解挂出纳卡完成
				}else if(e2.f1==0x15){
					if(e2.r==1){
						$('#unLossForm').clearForm();
						refreshCashierList();
						alertMsg.correct('解挂出纳卡完成！');
					}else{
						opCardResult(e2.r);
					}					
				//补办出纳卡命令
				} else if (e2.f1 == 0x16) {
					if(e2.r==1){
						$('#remakeCashierCardForm input[name=cardSN]').val(e2.cardSN);
						$('#remakeCashierCardForm input[name=cardInfoStr]').val(e2.cardInfoStr);
						validateCallback($('#remakeCashierCardForm'), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//补办出纳卡完成
				}else if(e2.f1==0x17){
					if(e2.r==1){
						$('#remakeCashierCardForm').clearForm();
						refreshCashierList();
						alertMsg.correct('补办出纳卡完成！');
					}else{
						opCardResult(e2.r);
					}					
				//读取出纳卡命令
				}else if(e2.f1==0x18){
					if(e2.r==1){
						$('#invalidDateForm input[name=invalidDate]').val(e2.date);
						$('#invalidDateForm input[name=operId]').val(e2.operId);
						$('#invalidDateForm input[name=cardSN]').val(e2.cardSN);
						$('#invalidDateForm input[name=cardInfoStr]').val(e2.cardInfoStr);
					}else{
						opCardResult(e2.r);
					}					
				//修改出纳卡有效期完成
				}else if(e2.f1==0x19){
					if(e2.r==1){
						$('#invlidDateForm').clearForm();
						refreshCashierList();
						alertMsg.correct('修改出纳卡有效期完成！');
					}else{
						opCardResult(e2.r);
					}					
				}
			}
		});
	}
	
	function refreshCashierList() {
		$('#cashierList')
				.loadUrl('${base }/cashierList.do', {}, function(){
					$('#cashierList').find('[layoutH]').layoutH();
				});
	}
	
	function heart(){
		$('body').everyTime('10s','getCardReaderStatus', function() {
			var d=new Date();
			var t=(d.getTime()-heartTime.getTime())/1000;
			if(t>=15){
				$.post('${base }/command.do?comm=closeSocketChannel');
				$('.dialogHeader_c h1').html('读卡机状态：离线');
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
	.dialog .dialogContent{
		padding: 1px;
	}
	.dialog .pageFormContent{
		border-style: none;
	}
</style>
<div class="tabs" currentIndex="0" eventType="click"
	style="margin: 1px;" layoutH="0">
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<li><a><span>水控参数卡</span></a></li>
				<li><a><span>一控多水控参数卡</span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsContent" style="padding: 0;" layoutH="30">
		<div>1</div>
		<div>2</div>
	</div>
</div>
