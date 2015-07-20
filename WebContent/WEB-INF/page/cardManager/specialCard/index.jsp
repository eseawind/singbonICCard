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
		if ("${cardStatus}" == 1) {
			$("#specialStatus").html("读卡机状态：在线");
			isOnline=true;
			if(!isHeart){
				heart();
				isHeart=true;
			}
		} else {
			$("#specialStatus").html("读卡机状态：离线");
			isOnline=false;
			isHeart=false;
			$('#userinfo').stopTime();
		}
		init();
		
	});
	
	$("#cashierForm .makeCashierCard").click(function() {
		if(isOnline){
			var id=$("#cashierForm input[name=id]").val();
			if(id!=""){
				var status=$("#cashierForm input[name=status]").val();
				if(status!=0){
					alertMsg.warn("该用户已发卡！");
					return;
				}
				if($(this).parents("form").valid()){
					$.post("${base }/command.do?comm=makeCashierCardInit");
				}
			}else{
				alertMsg.warn("请选择出纳员！");
			}
		}else{
			alertMsg.warn("读卡机当前处于离线状态不能制卡！");
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
// 						$("#specialStatus").html("读卡机状态：在线");
						isOnline=true;
						if(!isHeart){
							heart();
							isHeart=true;
						}
					} else {
// 						$("#specialStatus").html("读卡机状态：离线");
						isOnline=false;
						isHeart=false;
						$('#userinfo').stopTime();
					}
				//心跳
				} else if (e2.f1 == 2) {
					heartTime=new Date();
				//制出纳卡命令
				} else if (e2.f1 == 0x10) {
					if(e2.r==1){
						$("#cashierForm input[name=cardSN]").val(e2.cardSN);
						validateCallback($("#cashierForm"), function(e) {
						}, null);
					}else{
						opCardResult(e2.r);
					}
				//制出纳卡完成
				}else if(e2.f1==0x11){
					if(e2.r==1){
						refreshUserList();
						$("#cashierForm").clearForm();
						alertMsg.correct("制出纳卡完成！");
					}else{
						opCardResult(e2.r);
					}					
				}
			}
		});
	}
	
	function heart(){
	//		$('#userinfo').everyTime('10s','getCardReaderStatus', function() {
	//			$.post("${base }/command.do?comm=getCardReaderStatus");
	//			var d=new Date();
	//			var t=(d.getTime()-heartTime.getTime())/1000;
	//			$("#cardno2").html(t);
	//			if(t>=15){
	//				$.post("${base }/command.do?comm=closeSocketChannel");
	//				$("#specialStatus").html("读卡机状态：离线");
	//				isOnline=false;
	//				isHeart=false;
	//				$('#userinfo').stopTime();
	//			}
	//		},0,true);
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
<div class="tabs" currentIndex="0" eventType="click"
	style="margin: 1px;" layoutH="20">
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<li><a><span>出纳卡</span></a></li>
				<li><a><span>水控参数卡</span></a></li>
				<li><a><span>一控多水控参数卡</span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsContent" style="padding: 0;" layoutH="0">
		<!-- 出纳卡 -->
		<div>
			<jsp:include page="${base }/cashierList.do"/>
			<div class="tabs" currentIndex="0" eventType="click"
				style="margin: 3px;">
				<div class="tabsHeader">
					<div class="tabsHeaderContent">
						<ul>
							<li><a><span>制卡</span></a></li>
							<li><a><span>挂失</span></a></li>
							<li><a><span>解挂</span></a></li>
							<li><a><span>补卡</span></a></li>
							<li><a><span>修改有效期</span></a></li>
						</ul>
					</div>
				</div>
				<div class="tabsContent" style="padding: 0;">
					<!-- 出纳卡 -->
					<div>
						<form id="cashierForm" method="post" action="${base }/makeCashierCard.do" class="pageForm required-validate">
							<div class="pageFormContent" layoutH="60">
								<dl>
									<dt>失效期：</dt>
									<dd>
										<input name="id" type="hidden" /> 
										<input name="cardSN" type="hidden" /> 
										<input type="text" name="invalidDate" maxlength="20" class="required" readonly="readonly" pattern="yyyy-MM-dd"/>
									</dd>
								</dl>
								<dl>
									<ul>
										<li><div class="buttonActive">
												<div class="buttonContent makeCashierCard">
													<button type="button">制卡</button>
												</div>
											</div></li>
									</ul>
								</dl>
							</div>
						</form>
					</div>
					<div>2</div>
					<div>3</div>
					<div>4</div>
					<div>5</div>
				</div>
			</div>
		</div>
		<div>2</div>
		<div>3</div>
	</div>
</div>
<div id="specialStatus" style="color: #15428B;padding:2px 0 0 5px;">
</div>
