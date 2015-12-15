<!-- 读卡 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="/js/comet4j.js" type="text/javascript"></script>
<script type="text/javascript">
	var isOnline=false;
	var isHeart=false;
	var title=null;
	var heartTime=new Date();
	var userStatus=null;
	var isSame=0;
	
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
		
		$('#userInfo .readCard').click(function() {
			if(isOnline){
				$.post('${base }/command.do?editType=${editType}',function(e){
				});
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能读卡！');
			}
		});
		
		$('#userInfo .unloss').click(function() {
			if(isOnline){
				if(userStatus!='挂失'){
					alertMsg.warn('该人员尚未挂失不能解挂！');
					return;
				}				
				validateCallback($('#userInfo'), function(e) {
				}, null);
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能读卡！');
			}
		});
		
		$('#userInfo .cardOff').click(function() {
			if(isOnline){
				if(userStatus!='正常'){
					alertMsg.warn('该人员为非正常卡不能注销！');
					return;
				}				
				validateCallback($('#userInfo'), function(e) {
				}, null);
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能注销！');
			}
		});
		
		$('#userInfo .update').click(function() {
			if(isOnline){
				var updateType=$('#userInfo input[name=updateType]:checked').val();
				if(updateType==0 && userStatus=='注销'){
					alertMsg.warn('该人员已经注销不允许按卡修正！');
					return;
				}
				if(isSame==0){
					if(oddFare>dbOddFare || subsidyOddFare>dbSubsidyOddFare){
						alertMsg.warn('该人员卡库基本信息不一致不允许按卡修正！');
						return;						
					}					
				}
				if(updateType==0){
					var oddFare= parseInt($('#userInfo input[name=oddFare]').val());
					var subsidyOddFare=parseInt($('#userInfo input[name=subsidyOddFare]').val());
					var dbOddFare= parseInt($('#userInfo input[name=dbOddFare]').val());
					var dbSubsidyOddFare=parseInt($('#userInfo input[name=dbSubsidyOddFare]').val());
					if(oddFare>dbOddFare || subsidyOddFare>dbSubsidyOddFare){
						alertMsg.warn('卡上金额比库中多不允许按卡修正！');
						return;						
					}					
				}
				if(updateType==1){
					var dbOddFare= parseInt($('#userInfo input[name=dbOddFare]').val());
					var dbSubsidyOddFare=parseInt($('#userInfo input[name=dbSubsidyOddFare]').val());
					if(dbOddFare<0 || dbSubsidyOddFare<0){
						alertMsg.warn('库中金额小于0不允许按库修正！');
						return;						
					}					
				}
				validateCallback($('#userInfo'), function(e) {
					if(updateType==0){
						if(e==1){
// 							$('#updateLi').hide();
							refreshUserList();
							alertMsg.correct('按卡修正完成！');
							$('#userInfo .close').click();
						}else{
							alertMsg.warn('按卡修正失败！');						
						}
					}
				}, null);
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能读卡！');
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
				if(e2.f1==0x7f){
					alertMsg.warn('该卡片已经发行，请放置新卡！');
				}
				//读卡器状态心跳
				else if (e2.f1 == 0x02 && e2.r == 1) {
					$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
					isOnline=true;
					if(!isHeart){
						heart();
						isHeart=true;
					}
				//命令：解挂、注销、读卡
				} else if (e2.f1==0x07 || e2.f1==0x1c || e2.f1 == 0x0e) {
					if(e2.r==1){
						$.post('${base }/selectUserInfoByUserIdCardSN.do?userId='+e2.userId+'&cardSN='+e2.cardSN,function(e3){
							var e4 = eval('(' + e3 + ')');
							if(e4.r==1){
								$('.userInfoList #userName').html(e4.userName);
								$('.userInfoList #userNO').html(e4.userNO);
								$('.userInfoList #deptName').html(e4.deptName);
								
								var tds=$('.userInfoList .gridTbody td[id]');
								tds.each(function(e){
									var td=$(this);
									td.parent('tr').removeAttr('style');
									var attr=td.attr('id');
									var e2value=e2[attr];//卡
									var e4value=e4[attr];//库
									if(attr=='statusDesc'){
										userStatus=e4value;
									}
									td.next().find('div').html(e2value);
									td.next().next().find('div').html(e4value);
									if(attr.indexOf('Fare')!=-1){
										$('#userInfo input[name='+attr+']').val(e2value*100);										
									}else{
										$('#userInfo input[name='+attr+']').val(e2value);																				
									}
									if(e2value!=e4value){
										td.parent('tr').css('color','red');
									}
								});
								
								//是否允许按卡修正 账号、卡号、卡序号、卡类型
								if(e2['userId']==e4['userId'] && e2['cardNO']==e4['cardNO'] && e2['cardSeq']==e4['cardSeq'] && e2['cardTypeId']==e4['cardTypeId']){
									isSame=1;
								}
								
// 								按卡修正用
								$('#userInfo input[name=userId]').val(e2['userId']);
								$('#userInfo input[name=cardSN]').val(e2['cardSN']);
								$('#userInfo input[name=status]').val(e2['status']);								
								
// 								库信息解挂注销卡操作记录用								
								$('#userInfo input[name=dbOddFare]').val(e4['oddFare']*100);
								$('#userInfo input[name=dbSubsidyOddFare]').val(e4['subsidyOddFare']*100);
								$('#userInfo input[name=dbOpCount]').val(e4['opCount']);
								$('#userInfo input[name=dbSubsidyOpCount]').val(e4['subsidyOpCount']);
								
								var editType='${editType}';
								if(editType==2){
									$('#userInfo input[name=cardInfoStr]').val(e2['cardInfoStr']);
									$('#unlossLi').show();																		
								}else if(editType==3){
									$('#cardOffLi').show();																		
								}else if(editType==4){
									$('#updateLi').show();									
								}
								$('#updateLi').show();
							}else{
								alertMsg.warn('库中不存在此卡！');
							}
						});
					}else{
						opCardResult(e2.r);
					}
				//解挂完成
				}else if(e2.f1==0x08){
					if(e2.r==1){
						refreshUserList();
						alertMsg.correct('解挂完成！');
						$('#userInfo .close').click();
					}else{
						opCardResult(e2.r);
					}	
				//卡注销完成
				}else if(e2.f1==0x1d){
					if(e2.r==1){
						$('#userInfo input[name=editType]').val(5);
						validateCallback($('#userInfo'), function(e3) {
							if(e3==1){
								refreshUserList();
								$('#userInfo .close').click();								
								alertMsg.correct('卡注销完成！');															
							}else{
								alertMsg.warn('卡注销失败！');
							}
						}, null);
					}else{
						opCardResult(e2.r);
					}	
				//按库修正完成
				}else if(e2.f1==0x0f){
					if(e2.r==1){
						refreshUserList();
						alertMsg.correct('按库修正完成！');
						$('#userInfo .close').click();
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
			}else{
				$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
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
<div class="pageFormContent userInfoList" layoutH="60">
	<fieldset>
		<legend>用户信息</legend>
		<dl>
			<dt>用户姓名：</dt>
			<dd id="userName"></dd>
		</dl>
		<dl>
			<dt>用户编号：</dt>
			<dd id="userNO"></dd>
		</dl>
		<dl>
			<dt>所在部门：</dt>
			<dd id="deptName"></dd>
		</dl>
	</fieldset>
	<table class="table" width="99%">
		<thead>
			<tr>
				<th width="150">参数名</th>
				<th >卡中参数值</th>
				<th >库中参数值</th>
			</tr>
		</thead>
		<tbody class="userList">
			<tr>
				<td id="userId">帐号</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="cardNO">卡号</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="endDate">结束日期</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="statusDesc">卡状态</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="cardSeq">卡序号</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="cardTypeId">卡类型</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="totalFare">卡总额</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="oddFare">卡余额</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="opCount">大钱包计数器</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="subsidyOddFare">卡补助余额</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="subsidyOpCount">补助钱包计数器</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="subsidyVersion">补助版本号</td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>
<form id="userInfo" method="post" action="${base }/doChangeCard.do" class="pageForm">
	<input name="editType" type="hidden" value="${editType }" />
<!-- 	按卡修正用 -->
	<input name="userId" type="hidden" /> 
	<input name="cardSN" type="hidden" />
	<input name="endDate" type="hidden" />
	<input name="status" type="hidden" />
	<input name="cardSeq" type="hidden" />
	<input name="cardTypeId" type="hidden" />
	<input name="totalFare" type="hidden" />
	<input name="opCount" type="hidden" />
	<input name="oddFare" type="hidden" />
	<input name="subsidyOddFare" type="hidden" />
	<input name="subsidyOpCount" type="hidden" />
	<input name="subsidyVersion" type="hidden" />
	<input name="cardInfoStr" type="hidden" />
	 
<!-- 	解挂注销卡按卡按库修正卡操作记录用  -->
	<input name="dbOddFare" type="hidden" />
	<input name="dbSubsidyOddFare" type="hidden" />
	<input name="dbOpCount" type="hidden" />
	<input name="dbSubsidyOpCount" type="hidden" />
	 
	<div class="formBar">
		<ul>
<!-- 			2解挂、3注销、4读卡修正 -->
			<c:if test="${editType==2}">
				<li id="unlossLi" style="display: none;">
					<div class="button" style="margin-right: 10px;">
						<div class="buttonContent">
							<button type="button" class="unloss">解挂</button>
						</div>
					</div>
				</li>
			</c:if>
			<c:if test="${editType==3}">
				<li id="cardOffLi" style="display: none;">
					<div class="button" style="margin-right: 10px;">
						<div class="buttonContent">
							<button type="button" class="cardOff">注销</button>
						</div>
					</div>
				</li>
			</c:if>
			<c:if test="${editType==4}">
				<li id="updateLi" style="display: none;">
					<div class="button" style="margin-right: 10px;">
						<div class="buttonContent">
							<button type="button" class="update">修正</button>
						</div>
					</div>
					<div style="float: left;">
						<input type="radio" name="updateType" value="0" checked="checked"/>按卡修正
						<input type="radio" name="updateType" value="1"/>按库修正
					</div>
				</li>
			</c:if>
			<li><div class="button">
					<div class="buttonContent">
						<button type="button" class="readCard">读卡</button>
					</div>
				</div>
			</li>
			<li><div class="button">
					<div class="buttonContent">
						<button type="button" class="close">关闭</button>
					</div>
				</div>
			</li>
		</ul>
	</div>
</form>
