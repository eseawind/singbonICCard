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

	$(function() {
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
		
		$("#userinfo .readCard").click(function() {
			if(isOnline){
				$.post("${base }/command.do?comm=readCardInit",function(e){
				});
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
				//存在物理卡号
				if(e2.f1==0x7f){
					alertMsg.warn('该卡片已经发行，请放置新卡！');
				}
				//读卡器状态
				else if (e2.f1 == 0x01) {
					if (e2.r == 1) {
						heartTime=new Date();
						$(".dialogHeader_c h1").html(title + "——读卡机状态：在线");
						alert();
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
				} else if (e2.f1 == 0x02) {
					heartTime=new Date();
				//读卡命令
				} else if (e2.f1 == 0x0e) {
					if(e2.r==1){
						$.post("${base }/selectUserInfoByUserIdCardSN.do?userId="+e2.userId+"&cardSN="+e2.cardSN,function(e3){
							var e4 = eval('(' + e3 + ')');
							if(e4.r==1){
								var tds=$(".userInfoList .gridTbody td[id]");
								tds.each(function(e){
									var td=$(this);
									td.parent("tr").removeAttr("style");
									var e2value=e2[td.attr("id")];
									var e4value=e4[td.attr("id")];
									td.next().find("div").html(e2value);
									td.next().next().find("div").html(e4value);
									if(e2value!=e4value){
										td.parent("tr").css("color","red");
									}
								});
// 								for(var item in e4){
// 									trs.eq(i++).find("td").eq(1).find("div").html(item);
// 								}
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
						$("#userinfo .close").click();								
						alertMsg.correct('解挂成功！');
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
<div class="pageFormContent userInfoList" layoutH="60">
	<fieldset>
		<legend>用户信息</legend>
		<dl>
			<dt>用户姓名：</dt>
			<dd>
				${user.username }
			</dd>
		</dl>
		<dl>
			<dt>用户编号：</dt>
			<dd>
				${user.userNO }
			</dd>
		</dl>
		<dl>
			<dt>所在部门：</dt>
			<dd>
				${user.userNO }
			</dd>
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
				<td id="invalidDate">当前有效期</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="status">卡状态</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="cardSeq">卡序号</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td id="cardType">卡类型</td>
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
<form id="userinfo" method="post" action="${base }/doChangeCard.do" class="pageForm required-validate">
	<input name="userId" type="hidden" /> 
	<input name="cardSN" type="hidden" /> 
	<input name="cardInfoStr" type="hidden"/> 
	<div class="formBar">
		<ul>
			<li><div class="button">
					<div class="buttonContent">
						<button type="button" class="readCard">读卡</button>
					</div>
				</div>
			</li>
			<li id="updateLi" style="display: none;">
				<div style="float: left;">
					<input type="radio" name="updateType" value="1" checked="checked"/>按卡修正
					<input type="radio" name="updateType" value="1"/>按库修正
				</div>
				<div class="button">
					<div class="buttonContent">
						<button type="button" class="update">修正</button>
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
