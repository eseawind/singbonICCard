<!-- 水控功能卡制作 -->
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
	
	$('#funcCard .ok').click(function() {
		if(isOnline){
			validateCallback($('#funcForm'), function(e) {
			}, null);
		}else{
			alertMsg.warn('读卡机当前处于离线状态不能制作功能卡！');
		}
	});
	
	function init() {
		JS.Engine.stop();
		JS.Engine.start('/conn');
		JS.Engine.on({
			'c${sn}' : function(e) {//侦听一个channel
				var e2 = eval('(' + e + ')');
				heartTime=new Date();
				//读卡器状态
				if (e2.f1 == 2 && e2.r == 1) {
					$('.dialogHeader_c h1').html(title + '——读卡机状态：在线');
					isOnline=true;
					if(!isHeart){
						heart();
						isHeart=true;
					}
				//确定
				}else if(e2.f1==16){
					alertMsg.correct('功能卡制作完成！');
				}
			}
		});
	}
	
	function heart(){
		$('body').everyTime('10s','getfuncCardStatus', function() {
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
	
</script>
<style type="text/css">
	.dialog .dialogContent{
		padding: 1px;
	}
	.dialog .pageFormContent{
		border-style: none;
		height: 60px;
	}
	#funcCard #note{
		color: #15428b;
		font-size: 13px;
		font-weight: bold;
		margin: 30px 0 0 60px;
	}
	#funcForm{
		margin: 0 0 0 50px;
	}
	#funcForm .error{
		top:27px;
		left: 0;
		width: 180px;
	}
</style>
<div id="funcCard">
	<div class="form" layoutH="30" style="float: left; display: block; overflow: auto; line-height: 21px;">
		<div id="note">选择水控费率参数组</div>
		<form id="funcForm" method="post" action="${base}/make.do" class="pageForm required-validate">
			<div class="pageFormContent">
				<dl>
					<dd>
						<select class="combox required" name="waterRateGroupId" outerw="158" innerw=175">
							<c:forEach items="${waterRateGroupList }" var="w">
								<option value="${w.id }">${w.groupName }</option>
							</c:forEach>
						</select>
					</dd>
				</dl>
			</div>
		</form>
	</div>
	
	<div class="formBar">
		<ul>
			<li><div class="buttonActive">
					<div class="buttonContent ok">
						<button type="button">确定</button>
					</div>
				</div></li>
		</ul>
	</div>
</div>
