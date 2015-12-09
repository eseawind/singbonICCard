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
		if('${editType}'!=0 && '${editType}'!=1 && '${editType}'!=5){
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
		$('#userinfo .add').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshUserList();
					$('#userinfo input[name=username]').val('');
					$('#userinfo input[name=shortName]').val('');
					$('#userinfo input[name=userNO]').val('');
					
					alertMsg.correct('录入成功！');
				} else if(e==2) {
					alertMsg.warn('用户编号已存在请更改！');					
				}
			}, null);
		});
		$('#userinfo .edit').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshUserList();
					alertMsg.correct('修改成功！');
				} else if(e==2) {
					alertMsg.warn('该用户编号已存在请更改！');					
				}
			}, null);
		});
		$('#userinfo .singleCard').click(function() {
			if(isOnline){
				if($('#userinfo').valid()){
					if(!getAllFare())
						return;
					$.post('${base }/singleCardInit.do?userNO='+$('#userinfo input[name=userNO]').val(),function(e){
						if(e==2){
							alertMsg.warn('该用户编号已存在请更改！');					
						}
					});
				}
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能发卡！');
			}
		});
		$('#userinfo .infoCard').click(function() {
			infoCard();
		});
		$('#userinfo .makeCard').click(function() {
			infoCard();
		});
		$('#userinfo .next').click(function() {
			next();
		});
		$('#userinfo .remakeCard').click(function() {
			if(isOnline){
				if($('#userinfo').valid()){
					if(!getAllFare())
						return;
					$.post('${base }/command.do?editType=1');
				}
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能补卡！');
			}
		});
		$('#userinfo .loss').click(function() {
			validateCallback($(this).parents('form'), function(e) {
				if (e == 1) {
					refreshUserList();
					alertMsg.correct('挂失完成！');
					$('#userinfo .close').click();
				} else {
					alertMsg.warn('挂失失败！');					
				}
			}, null);
		});
		$('#userinfo .delete').click(function() {
			$('body').stopTime();
		});
		//不是挂失或补卡时加载页面自动计算金额
		if('${editType}'!=5 && '${editType!=6}'){
			getAllFare();
		}
	});

	function infoCard(){
		if(isOnline){
			if($('#userinfo').valid()){
				if(!getAllFare())
					return;
				$.post('${base }/command.do?editType=0');
			}
		}else{
			alertMsg.warn('读卡机当前处于离线状态不能发卡！');
		}
	}
	
	function next(){
		var userId=$('#userinfo input[name=userId]').val();
		var list= $('#batchCardUserList tr[userId='+userId+']').nextAll('[status=0]');
		if(list.length>0){
			list.eq(0).click();
		}else{
			$('#userinfo input[name=userId]').val('');
			$('#userinfo input[name=cardSN]').val('');
			$('#userinfo input[name=username]').val('');
			$('#userinfo input[name=shortName]').val('');
			$('#userinfo input[name=userNO]').val('');
		}
	}
	
	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'c${device.sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				heartTime=new Date();
				//存在物理卡号
				if(e2.f1==0x70){
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
				//单个发卡命令
				} else if (e2.f1 == 3) {
					if(e2.r==1){
						$('#userinfo input[name=cardSN]').val(e2.cardSN);
						validateCallback($('#userinfo'), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//单个发卡完成
				}else if(e2.f1==4){
					if(e2.r==1){
						refreshUserList();
						$('#userinfo input[name=cardSN]').val('');
						$('#userinfo input[name=username]').val('');
						$('#userinfo input[name=shortName]').val('');
						$('#userinfo input[name=userNO]').val('');
						
						alertMsg.correct('单个发卡完成！');
					}else{
						opCardResult(e2.r);
					}					
				//信息发卡命令
				} else if (e2.f1 == 5) {
					if(e2.r==1){
						$('#userinfo input[name=cardSN]').val(e2.cardSN);
						validateCallback($('#userinfo'), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//信息发卡完成
				} else if (e2.f1 == 6) {
					if(e2.r==1){
						if('${editType}'==3){
							refreshUserList();
							alertMsg.correct('信息发卡完成！');
							$('#userinfo .close').click();
						}else{
							var userId=$('#userinfo input[name=userId]').val();
							var tr= $('#batchCardUserList tr[userId='+userId+']');
							tr.attr('status',1);
							tr.find('div').eq(3).html('已发卡');
							alertMsg.correct('发卡完成！');
							next();
						}
					}else{
						opCardResult(e2.r);
					}
				//补卡命令
				} else if (e2.f1 == 11) {
					if(e2.r==1){
						$('#userinfo input[name=cardSN]').val(e2.cardSN);
						validateCallback($('#userinfo'), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//补卡完成
				} else if (e2.f1 == 12) {
					if(e2.r==1){
						refreshUserList();
						alertMsg.correct('补卡完成！');
						$('#userinfo .close').click();
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
	function batchCardClick(tr){
		var status=tr.attr('status');
		if(status==0){
			$('#userinfo input[name=userId]').val(tr.attr('userId'));
			$('#userinfo input[name=cardSN]').val('');
			$('#userinfo input[name=username]').val(tr.attr('username'));
			$('#userinfo input[name=shortName]').val(tr.attr('shortName'));
			$('#userinfo input[name=userNO]').val(tr.attr('userNO'));
			$('#userinfo input[name=sex][value='+tr.attr('sex')+']').attr('checked',true);
			$('#userinfo input[name=giveFare]').val(tr.attr('giveFare'));
			$('#userinfo input[name=preOpFare]').val(tr.attr('preOpFare'));
			$('#userinfo input[name=consumePwd]').val(tr.attr('consumePwd'));
			
			var select = $('#userinfo select');
			var cardTypeId=tr.attr('cardTypeId');
			select.prev().attr('value',cardTypeId).html($('option[value=' + cardTypeId + ']', select).html());
			
			getAllFare();
		}else{
			alertMsg.warn('该用户已发卡！');		
		}
	}
	
	function getAllFare(){
		var preOpFareInput=$('#userinfo input[name=preOpFare]');
		var giveFareInput=$('#userinfo input[name=giveFare]');
		var allFareInput=$('#userinfo #allFare');
		
		var preOpFare=0;
		var giveFare=0;
		var cardDeposit=$('#userinfo input[name=cardDeposit]').val();
		var allFare=0;
		
		if(preOpFareInput.val()==''){
// 			preOpFareInput.val(0);
		}else{
			preOpFare=preOpFareInput.val();
		}
		if(giveFareInput.val()==''){
// 			giveFareInput.val(0);
		}else{
			giveFare=giveFareInput.val();
		}
		allFare=parseFloat(preOpFare)+parseFloat(giveFare)-parseFloat(cardDeposit);
		allFareInput.val(allFare);
		if(allFare>167772.15){
			alertMsg.warn('实际金额不能大于167772.15！');
			return false;
		}
		return true;
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

.pageFormContent label {
	width: 50px;
}

.dialog .pageFormContent dd span.error {
	width: 95px;
	left: 175px;
}
</style>
<c:if test="${editType==4 }">
	<div id="batchCardUserList" style="float: left; display: block; overflow: auto; width: 250px; line-height: 21px;padding:10px 0;">
		<table class="table" width="108%">
		<thead>
			<tr>
				<th width="50">序号</th>
				<th width="100">姓名</th>
				<th width="100">编号</th>
				<th width="100">状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="user" items="${list}" varStatus="status">
				<tr target="batchCard" <c:if test="${status.index==0}">class="selected"</c:if> 
					userId="${user.userId}" status="0" username="${user.username}" shortName="${user.shortName}" userNO="${user.userNO}" cardTypeId="${user.cardTypeId}"
					cardID="${user.cardID}" sex="${user.sex}" consumePwd="${user.consumePwd}" giveFare="${user.giveFare}" preOpFare="${user.preOpFare}">
					<td>${status.index+1}</td>
					<td>${user.username}</td>
					<td>${user.userNO}</td>
					<td>${user.statusDesc}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</c:if>
<form id="userinfo" method="post" action="${base }/saveUser.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="60">
		<fieldset>
			<legend>基本信息</legend>
			<dl>
				<dt>用户姓名：</dt>
				<dd>
					<input name="userId" type="hidden" value="${user.userId}" /> 
					<input name="deptId" type="hidden" value="${deptId}" />
					<input name="editType" type="hidden" value="${editType}" />
					<input name="cardSN" type="hidden" value="${user.cardSN}" /> 
					<input name="batchId" type="hidden" value="${batchId}" /> 
					<input name="username" type="text" class="required"
						value="${user.username }" onblur="shortName.value=($('input[name=username]').toPinyin());"
						onchange="shortName.value=($('input[name=username]').toPinyin())"
						onkeydown="shortName.value=($('input[name=username]').toPinyin())" />
				</dd>
			</dl>
			<dl>
				<dt>姓名简拼：</dt>
				<dd>
					<input name="shortName" type="text" class="required" value="${user.shortName }" />
				</dd>
			</dl>
			<dl>
				<dt>编号：</dt>
				<dd>
					<input class="required" name="userNO" type="text" value="${user.userNO }" />
				</dd>
			</dl>
			<dl>
				<dt>性别：</dt>
				<dd>
					<label><input type="radio" name="sex" <c:if test="${user.sex==null || user.sex==0}">checked="checked"</c:if> value="0" />男</label>
					<label><input type="radio" name="sex" value="1" <c:if test="${user.sex==1}">checked="checked"</c:if> />女</label>
				</dd>
			</dl>
			<dl>
				<dt>身份证号：</dt>
				<dd>
					<input name="cardID" type="text" value="${cardID}" />
				</dd>
			</dl>
			<dl>
				<dt>卡号：</dt>
				<dd>
					<input name="cardNO" type="text" value="${cardNO}" readonly="readonly"/>
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>校园卡信息</legend>
			<dl>
				<dt>补助类型：</dt>
				<dd>
					<select class="combox" name="cardTypeId" class="required" outerw="105" innerw="122">
						<c:forEach items="${discountList }" var="d">
							<option value="${d.discountType }" <c:if test="${d.discountType==cardTypeId}">selected="selected"</c:if>>${d.discountType}类卡</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
<!-- 			挂失、补卡 -->
			<c:if test="${editType==5 || editType==6}">
				<dl>
					<dt>大钱包余额：</dt>
					<dd>
						<input type="hidden" name="oddFare" value="${user.oddFare}" />
						<input type="text" value="${user.oddFare/100 }" readonly="readonly"/>
					</dd>
				</dl>
				<dl>
					<dt>补助余额：</dt>
					<dd>
						<input type="hidden" name="subsidyOddFare" value="${user.subsidyOddFare}" />
						<input type="text" value="${user.subsidyOddFare/100 }" readonly="readonly"/>
					</dd>
				</dl>			
			</c:if>
			<c:if test="${editType!=5 && editType!=6}">
				<dl>
					<dt>实际金额：</dt>
					<dd>
						<input class="required number" id="allFare" type="text" value="0" readonly="readonly"/>
					</dd>
				</dl>
				<dl>
					<dt>赠送金额：</dt>
					<dd>
						<input class="required number" name="giveFare" type="text" value="${giveFare}" onkeyup="getAllFare();"/>
					</dd>
				</dl>
				<dl>
					<dt>预发金额：</dt>
					<dd>
						<input class="required number" name="preOpFare" type="text" value="${preOpFare}" onkeyup="getAllFare();"/>
					</dd>
				</dl>
			</c:if>
		</fieldset>
		<fieldset>
			<legend>发卡参数</legend>
			<dl>
				<dt>消费密码：</dt>
				<dd>
					<input name="consumePwd" type="text" class="required digits" minlength="4" maxlength="4" value="${consumePwd}" />
				</dd>
			</dl>
			<dl>
				<dt>卡押金：</dt>
				<dd>
					<input name="cardDeposit" type="text" class="number required" value="${cardDeposit}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>开始日期：</dt>
				<dd>
					<input type="text" name="beginDate" maxlength="20" class="required" value="${beginDate}" readonly="readonly"/>
				</dd>
			</dl>
			<dl>
				<dt>结束日期：</dt>
				<dd>
					<input type="text" name="endDate" maxlength="20" class="required" value="${endDate}" readonly="readonly"/>
				</dd>
			</dl>
		</fieldset>
		<c:if test="${editType==5 }">
			<fieldset>
				<legend>挂失原因</legend>
				<dl>
					<dt>
						<label style="width: 150px;">
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
						<div class="buttonContent add">
							<button type="button">录入</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==1 }">
				<li><div class="button">
						<div class="buttonContent edit">
							<button type="button">修改</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==2 }">
				<li><div class="button">
						<div class="buttonContent singleCard">
							<button type="button">单个发卡</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==3 }">
				<li><div class="button">
						<div class="buttonContent infoCard">
							<button type="button">信息发卡</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==4 }">
				<li><div class="button">
						<div class="buttonContent next">
							<button type="button">下一个</button>
						</div>
					</div></li>
				<li><div class="button">
						<div class="buttonContent makeCard">
							<button type="button">发卡</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==5 }">
				<li><div class="button">
						<div class="buttonContent loss">
							<button type="button">挂失</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==6 }">
				<li><div class="button">
						<div class="buttonContent remakeCard">
							<button type="button">补卡</button>
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
