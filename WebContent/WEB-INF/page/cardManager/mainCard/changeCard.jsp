<!-- 挂失补卡换卡注销 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- <script src="/js/comet4j.js" type="text/javascript"></script> -->
<script type="text/javascript">

	var isOnline=false;
	var isHeart=false;
	var title=null;
	var heartTime=new Date();

	$(function() {
		if("${editType}"!=0){
			title = $(".dialogHeader_c h1").html().split("——")[0];
			if ("${cardStatus}" == 1) {
				$(".dialogHeader_c h1").html(title + "——读卡机状态：在线");
				isOnline=true;
				if(!isHeart){
					heart();
					isHeart=true;
				}
			} else {
				$(".dialogHeader_c h1").html(title + "——读卡机状态：离线");
				isOnline=false;
				isHeart=false;
				$('#userinfo').stopTime();
			}
			init();
		}
		$("#userinfo .add").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					refreshUserList();
					$("#userinfo input[name=username]").val("");
					$("#userinfo input[name=shortName]").val("");
					$("#userinfo input[name=userNO]").val("");
					
					alertMsg.correct('录入成功！');
				} else if(e==2) {
					alertMsg.warn('用户编号已存在请更改！');					
				}
			}, null);
		});
		$("#userinfo .edit").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					refreshUserList();
					alertMsg.correct('修改成功！');
				} else if(e==2) {
					alertMsg.warn('该用户编号已存在请更改！');					
				}
			}, null);
		});
		$("#userinfo .singleCard").click(function() {
			if(isOnline){
				if($("#userinfo").valid()){
					$.post("${base }/singleCardInit.do?userNO="+$('#userinfo input[name=userNO]').val(),function(e){
						if(e==2){
							alertMsg.warn('该用户编号已存在请更改！');					
						}
					});
				}
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能发卡！');
			}
		});
		$("#userinfo .infoCard").click(function() {
			if(isOnline){
				$.post("${base }/command.do?comm=infoCardInit");
			}else{
				alertMsg.warn('读卡机当前处于离线状态不能发卡！');
			}
		});
		$("#userinfo .delete").click(function() {
			$('#userinfo').stopTime();
		});
	});

	function init() {
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
						$(".dialogHeader_c h1").html(title + "——读卡机状态：在线");
						isOnline=true;
						if(!isHeart){
							heart();
							isHeart=true;
						}
					} else {
						$(".dialogHeader_c h1").html(title + "——读卡机状态：离线");
						isOnline=false;
						isHeart=false;
						$('#userinfo').stopTime();
					}
				//心跳
				} else if (e2.f1 == 2) {
					heartTime=new Date();
				//单个发卡命令
				} else if (e2.f1 == 3) {
					if(e2.r==1){
						$("#userinfo input[name=cardSN]").val(e2.cardSN);
						validateCallback($("#userinfo"), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				}else if(e2.f1==4){
					if(e2.r==1){
						refreshUserList();
 						$("#userinfo").clearForm();
						//$("#userinfo .close").click();
						alertMsg.correct('单个发卡完成！');
					}else{
						opCardResult(e2.r);
					}					
				//信息发卡命令
				} else if (e2.f1 == 5) {
					if(e2.r==1){
						$("#userinfo input[name=cardSN]").val(e2.cardSN);
						validateCallback($("#userinfo"), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//信息发卡完成
				} else if (e2.f1 == 6) {
					if(e2.r==1){
						refreshUserList();
// 						$("#userinfo").clearForm();
						$("#userinfo .close").click();
						alertMsg.correct('信息发卡完成！');
					}else{
						opCardResult(e2.r);
					}
				}
			}
		});
	}
	
	function heart(){
// 		$('#userinfo').everyTime('10s','getCardReaderStatus', function() {
// 			$.post("${base }/command.do?comm=getCardReaderStatus");
// 			var d=new Date();
// 			var t=(d.getTime()-heartTime.getTime())/1000;
// 			$("#cardno2").html(t);
// 			if(t>=15){
// 				$.post("${base }/command.do?comm=closeSocketChannel");
// 				$(".dialogHeader_c h1").html(title + "——读卡机状态：离线");
// 				isOnline=false;
// 				isHeart=false;
// 				$('#userinfo').stopTime();
// 			}
// 		},0,true);
	}
	
	function opCardResult(r){
		//1读卡器读写成功、2读卡器寻卡失败、3读卡器卡校验失败、4读卡器物理卡号不匹配、5读卡器读写卡失败。
		var msg="读卡机寻卡失败，请检查是否放卡！";
		if(r==3){
			msg="读卡机卡校验失败！";
		}else if(r==5){
			msg="读卡机读写卡失败！";			
		}
		alertMsg.warn(msg);		
	}
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
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
		<fieldset>
			<legend>挂失原因</legend>
			<dl>
				<dt>
					<label><input type="radio" name="lossReason" checked="checked" value="0" />卡遗失  <input type="radio" name="lossReason" value="1" />卡损坏</label> 
				</dt>
			</dl>
		</fieldset>
	</div>
	<div class="formBar">
		<ul>
			<c:if test="${editType==1 }">
				<li><div class="buttonActive">
						<div class="buttonContent loss">
							<button type="button">挂失</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==2 }">
				<li><div class="button">
						<div class="buttonContent unloss">
							<button type="button">解挂</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==3 }">
				<li><div class="button">
						<div class="buttonContent remakeCard">
							<button type="button">补卡</button>
						</div>
					</div></li>
			</c:if>
			<c:if test="${editType==4 }">
				<li><div class="button">
						<div class="buttonContent changeCard">
							<button type="button">换卡</button>
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
