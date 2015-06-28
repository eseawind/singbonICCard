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
		$("#userinfo .add").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					refreshUserList();
					alertMsg.correct('录入成功');
				} else {

				}
			}, null);
		});
		$("#userinfo .edit").click(function() {
			validateCallback($(this).parents("form"), function(e) {
				if (e == 1) {
					refreshUserList();
					alertMsg.correct('修改成功');
				} else {

				}
			}, null);
		});
		$("#userinfo .infoCard").click(function() {
			if(isOnline){
				validateCallback($(this).parents("form"), function(e) {
				}, null);
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
				alertMsg.correct('在线');
				//读卡器状态
				if (e2.f1 == 1) {
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
				//发卡
				} else if (e2.f1 == 3) {
					heartTime=new Date();
					alertMsg.correct('信息发卡成功');
				}
			}
		});
	}
	
	function heart(){
		$('#userinfo').everyTime('10s','getCardReaderStatus', function() {
			$.post("${base }/command.do?comm=getCardReaderStatus");
			var d=new Date();
			var t=(d.getTime()-heartTime.getTime())/1000;
			$("#cardno2").html(t);
			if(t>=15){
				$.post("${base }/command.do?comm=closeSocketChannel");
				$(".dialogHeader_c h1").html(title + "——读卡机状态：离线");
				isOnline=false;
				isHeart=false;
				$('#userinfo').stopTime();
			}
		},0,true);
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
<form id="userinfo" method="post" action="${base }/addEdit.do" class="pageForm required-validate">
	<div class="pageFormContent" layoutH="60">
		<fieldset>
			<legend>基本信息</legend>
			<dl>
				<dt>用户姓名：</dt>
				<dd>
				<div id="cardno2">0</div>
					<input name="id" type="hidden" value="${user.userId }" /> <input name="deptId" type="hidden"
						value="${deptId }" /><input name="editType" type="hidden"
						value="${editType }" /> <input name="username" type="text" class="required"
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
					<label><input type="radio" name="sex"
						<c:if test="${user.sex==null || user.sex==0}">checked="checked"</c:if> value="0" />男</label> <label><input
						type="radio" name="sex" value="1" <c:if test="${user.sex==1}">checked="checked"</c:if> />女</label>
				</dd>
			</dl>
			<dl>
				<dt>身份证号：</dt>
				<dd>
					<input name="cardID" type="text" value="${user.cardID==null?'123456789012345678':user.cardID }" />
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>校园卡信息</legend>
			<dl>
				<dt>补助类型：</dt>
				<dd>
					<select class="combox" name="cardType" class="required" outerw="105" innerw="122">
						<c:forEach items="${discountList }" var="d">
							<option value="${d.discountType }"
								<c:if test="${d.discountType==user.cardType}">selected="selected"</c:if>>${d.discountType}类卡</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>卡功能：</dt>
				<dd>
					<select class="combox" name="cardFunc" class="required" outerw="105" innerw="122">
						<c:forEach items="${cardFuncList }" var="f">
							<option value="${f.id }" <c:if test="${f.id==user.cardFunc}">selected="selected"</c:if>>${f.funcName
								}</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>客户身份：</dt>
				<dd>
					<select class="combox" name="cardIdentity" class="required" outerw="105" innerw="122">
						<c:forEach items="${cardIdentityList }" var="i">
							<option value="${i.id }" <c:if test="${i.id==user.cardIdentity}">selected="selected"</c:if>>${i.identityName
								}</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>预发金额：</dt>
				<dd>
					<input class="number" name="opCash" type="text" value="0" />
				</dd>
			</dl>
			<dl>
				<dt>赠送金额：</dt>
				<dd>
					<input class="number" name="giveCash" type="text" value="0" />
				</dd>
			</dl>
		</fieldset>
		<fieldset>
			<legend>发卡参数</legend>
			<dl>
				<dt>消费密码：</dt>
				<dd>
					<input name="consumePwd" type="text" class="digits"
						value="${user.consumePwd==null?888888:user.consumePwd }" />
				</dd>
			</dl>
			<dl>
				<dt>身份密码：</dt>
				<dd>
					<input name="identityPwd" type="text" class="digits"
						value="${user.identityPwd==null?8888:user.identityPwd }" />
				</dd>
			</dl>
			<dl>
				<dt>开户卡成本：</dt>
				<dd>
					<input name="cardCost" type="text" class="number" value="0" />
				</dd>
			</dl>
			<dl>
				<dt>卡押金：</dt>
				<dd>
					<input name="cardDeposit" type="text" class="number" value="0" />
				</dd>
			</dl>
			<dl>
				<dt>开始日期：</dt>
				<dd>
					<input readonly="true" type="text" name="beginDate" maxlength="20"
						value="<fmt:formatDate value="${user.beginDate==null ? batch.beginDate :user.beginDate}" pattern="yyyy-MM-dd"/>" />
				</dd>
			</dl>
			<dl>
				<dt>当前有效期：</dt>
				<dd>
					<input type="text" name="endDate" maxlength="20" class="date required" readonly="readonly"
						value="<fmt:formatDate value="${user.endDate==null ? batch.endDate :user.endDate }" pattern="yyyy-MM-dd"/>" />
				</dd>
			</dl>
		</fieldset>
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
			<c:if test="${editType==3 }">
				<li><div class="button">
						<div class="buttonContent infoCard">
							<button type="button">发卡</button>
						</div>
					</div></li>
			</c:if>
			<li><div class="button">
					<div class="buttonContent delete">
						<button type="button">断开</button>
					</div>
				</div></li>
			<li><div class="button">
					<div class="buttonContent">
						<button type="button" class="close">关闭</button>
					</div>
				</div></li>
		</ul>
	</div>
</form>
