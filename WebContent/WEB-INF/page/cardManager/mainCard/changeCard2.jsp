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
		$('#userInfo .unloss').click(function() {
			if(isOnline){
// 				if($('#userInfo').valid()){
					$.post('${base }/command.do?comm=unlossInit',function(e){
					});
// 				}
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能解挂！');
			}
		});
		$('#userInfo .offWithCard').click(function() {
			if(isOnline){
// 				alertMsg.confirm('确定要注销该人员吗？', {
// 					okCall : function() {
						$.post('${base }/command.do?comm=offCardWithInfo',function(e){
						});
// 					}
// 				});
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能注销卡！');
			}
		});
	});

	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'c${sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				heartTime=new Date();
				//存在物理卡号
				if(e2.f1==0x70){
					alertMsg.warn('该卡片已经发行，请放置新卡！');
				}
				//读卡器状态
				else if (e2.f1 == 0x02 && e2.r == 1) {
					$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
					isOnline=true;
					if(!isHeart){
						heart();
						isHeart=true;
					}
				//解挂命令
				} else if (e2.f1 == 0x07) {
					if(e2.r==1){
						var userId= $('#userInfo input[name=userId]').val();
						var cardSN= $('#userInfo input[name=cardSN]').val();
						
						if(userId==e2.userId && cardSN==e2.cardSN){
							$('#userInfo input[name=cardInfoStr]').val(e2.cardInfoStr);
							validateCallback($('#userInfo'), function(e) {
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
						$('#userInfo .close').click();								
						alertMsg.correct('解挂成功！');
					}else{
						opCardResult(e2.r);
					}	
				//卡注销命令
				} else if (e2.f1 == 0x1c) {
					if(e2.r==1){
						var userId= $('#userInfo input[name=userId]').val();
						var cardSN= $('#userInfo input[name=cardSN]').val();
						
						if(userId==e2.userId && cardSN==e2.cardSN){
							validateCallback($('#userInfo'), function(e) {
							}, null);
						}else{
							alertMsg.warn('该卡片与用户信息不匹配请更换！');					
						}
					}else{
						opCardResult(e2.r);
					}
				//卡注销完成
				}else if(e2.f1==0x1d){
					if(e2.r==1){
						var userId= $('#userInfo input[name=userId]').val();
						$.post('${base }/offUserInfoWithInfo.do?userId='+userId,function(e3){
							if(e3==1){
								refreshUserList();
								$('#userInfo .close').click();								
								alertMsg.correct('有卡注销完成！');															
							}else{
								alertMsg.warn('有卡注销失败！');
							}
						});
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
			if(t>12){
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
<form id="userInfo" method="post" action="${base }/doChangeCard.do" class="pageForm required-validate">
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
					<label>
						<input type="hidden" name="cardNO" value="${user.cardNO }" />
						<input type="radio" name="lossReason" checked="checked" value="0" />卡遗失 
						<input type="radio" name="lossReason" value="1" />卡损坏
					</label> 
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
<%-- 			<c:if test="${editType==3 }"> --%>
<!-- 				<li><div class="button"> -->
<!-- 						<div class="buttonContent readOldCard"> -->
<!-- 							<button type="button">读原卡</button> -->
<!-- 						</div> -->
<!-- 						<div class="buttonContent changeNewCard" style="display: none;"> -->
<!-- 							<button type="button">换新卡</button> -->
<!-- 						</div> -->
<!-- 					</div></li> -->
<%-- 			</c:if> --%>
			<c:if test="${editType==5 }">
				<li><div class="button">
						<div class="buttonContent offWithCard">
							<button type="button">注销</button>
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
