<!-- 挂失补卡换卡注销 -->
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
		if('${editType}'!=0){
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
		}
		$('#userinfo .loss').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				var editType='${editType }';
				//挂失
				if(editType==0){
					if (e == 1) {
						refreshUserList();
						$('#userinfo .close').click();								
						alertMsg.correct('挂失成功！');
					} else if(e==2) {
						alertMsg.warn('挂失失败！');					
					}
				}
			}, null);
		});
		$('#userinfo .unloss').click(function() {
			if(isOnline){
// 				if($('#userinfo').valid()){
					$.post('${base }/command.do?comm=unlossInit',function(e){
					});
// 				}
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能解挂！');
			}
		});
		$('#userinfo .remakeCard').click(function() {
			if(isOnline){
// 				if($('#userinfo').valid()){
					$.post('${base }/command.do?comm=remakeCardInit',function(e){
					});
// 				}
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能补卡！');
			}
		});
		$('#userinfo .readOldCard').click(function() {
			if(isOnline){
				alertMsg.confirm('换卡后要回收原卡，确定换卡吗？', {
					okCall : function() {
						$.post('${base }/command.do?comm=readOldCardInit',function(e){
						});
					}
				});
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能读原卡！');
			}
		});
		$('#userinfo .changeNewCard').click(function() {
			if(isOnline){
// 				if($('#userinfo').valid()){
					$.post('${base }/command.do?comm=changeNewCardInit',function(e){
					});
// 				}
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能换新卡！');
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
				if(e2.f1==0x70){
					alertMsg.warn('该卡片已经发行，请放置新卡！');
				}
				//读卡器状态
				else if (e2.f1 == 0x01 && e2.r == 1) {
					heartTime=new Date();
					$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
					isOnline=true;
					if(!isHeart){
						heart();
						isHeart=true;
					}
				//心跳
// 				} else if (e2.f1 == 0x02) {
// 					heartTime=new Date();
				//解挂命令
				} else if (e2.f1 == 0x07) {
					if(e2.r==1){
						var userId= $('#userinfo input[name=userId]').val();
						var cardSN= $('#userinfo input[name=cardSN]').val();
						
						if(userId==e2.userId && cardSN==e2.cardSN){
							$('#userinfo input[name=cardInfoStr]').val(e2.cardInfoStr);
							validateCallback($('#userinfo'), function(e) {
							}, null);
						}else{
							alertMsg.warn('该卡片与用户信息不匹配请更换！');					
						}
					}else{
						opCardResult(e2.r);
					}
				//解挂完成
				}else if(e2.f1==0x08){
					if(e2.r==1){
						refreshUserList();
						$('#userinfo .close').click();								
						alertMsg.correct('解挂成功！');
					}else{
						opCardResult(e2.r);
					}	
				//补卡命令
				} else if (e2.f1 == 0x09) {
					if(e2.r==1){
						$('#userinfo input[name=cardSN]').val(e2.cardSN);
						validateCallback($('#userinfo'), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//补卡完成
				} else if (e2.f1 == 0x0a) {
					if(e2.r==1){
						refreshUserList();
						$('#userinfo .close').click();
						alertMsg.correct('补卡完成！');
					}else{
						opCardResult(e2.r);
					}
				//换卡读原卡命令
				} else if (e2.f1 == 0x0b) {
					if(e2.r==1){
						var userId= $('#userinfo input[name=userId]').val();
						var cardSN= $('#userinfo input[name=cardSN]').val();
						if(userId==e2.userId && cardSN==e2.cardSN){
							$('#userinfo input[name=cardInfoStr]').val(e2.cardInfoStr);
							$('#userinfo .readOldCard').hide();
							$('#userinfo .changeNewCard').show();
							alertMsg.correct('原卡读卡完毕，请放置新卡！');
						}else{
							alertMsg.warn('该原卡与人员信息不匹配请换卡！');
						}
					}else{
						opCardResult(e2.r);
					}
				//换卡换新卡命令
				} else if (e2.f1 == 0x0c) {
					if(e2.r==1){
						var cardSN= $('#userinfo input[name=cardSN]').val();
						if(cardSN==e2.newCardSN){
								alertMsg.warn('该卡片是原卡请放置新卡！');
						}else{
							$('#userinfo input[name=newCardSN]').val(e2.newCardSN);
							validateCallback($('#userinfo'), function(e) {
							}, null);
						}
					}else{
						opCardResult(e2.r);
					}
				//换卡换新卡完成
				} else if (e2.f1 == 0x0d) {
					if(e2.r==1){
						refreshUserList();
						$('#userinfo .close').click();
						alertMsg.correct('换卡完成！');
					}else{
						opCardResult(e2.r);
					}
				}
				
			}
		});
	}
	
	function heart(){
// 		$('body').everyTime('10s','getCardReaderStatus', function() {
// // 			$.post('${base }/command.do?comm=getCardReaderStatus');
// 			var d=new Date();
// 			var t=(d.getTime()-heartTime.getTime())/1000;
// 			if(t>12){
// 				$.post('${base }/command.do?comm=closeSocketChannel');
// 				$('.dialogHeader_c h1').html(title + '——读卡机状态：离线');
// 				isOnline=false;
// 				isHeart=false;
// 				$('body').stopTime();
// 			}
// 		},0,true);
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
	width: 75px;
}

.dialog .pageFormContent dd {
	width: 120px;
}

.dialog .pageFormContent dd span.error {
	width: 85px;
	left: 85px;
}
</style>
<form id="userinfo" method="post" action="${base }/doChangeCard.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="60">
		<fieldset>
			<legend>用户信息</legend>
			<dl>
				<dt>用户姓名：</dt>
				<dd>
					${user.username }
					<input name="userId" type="hidden" value="${user.userId }" /> 
					<input name="editType" type="hidden" value="${editType }" />
					<input name="cardSN" type="hidden" value="${user.cardSN }" /> 
					<input name="newCardSN" type="hidden" /> 
					<input name="cardInfoStr" type="hidden"/> 
					<input name="batchId" type="hidden" value="${batch.id }" /> 
				</dd>
			</dl>
			<dl>
				<dt>用户编号：</dt>
				<dd>
					${user.userNO }
				</dd>
			</dl>
		</fieldset>
		<c:if test="${editType==0 }">
		<fieldset>
			<legend>挂失原因</legend>
			<dl>
				<dt>
					<label><input type="radio" name="lossReason" checked="checked" value="0" />卡遗失  <input type="radio" name="lossReason" value="1" />卡损坏</label> 
				</dt>
			</dl>
		</fieldset>
		</c:if>
	</div>
	<div class="formBar">
		<ul>
			<c:if test="${editType==0 }">
				<li><div class="buttonActive">
						<div class="buttonContent loss">
							<button type="button">挂失</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==1 }">
				<li><div class="button">
						<div class="buttonContent unloss">
							<button type="button">解挂</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==2 }">
				<li><div class="button">
						<div class="buttonContent remakeCard">
							<button type="button">补卡</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==3 }">
				<li><div class="button">
						<div class="buttonContent readOldCard">
							<button type="button">读原卡</button>
						</div>
						<div class="buttonContent changeNewCard" style="display: none;">
							<button type="button">换新卡</button>
						</div>
					</div></li>
			</c:if>
			<li><div class="button">
					<div class="buttonContent">
						<button type="button" class="close">关闭</button>
					</div>
				</div>
				</li>
		</ul>
	</div>
</form>
