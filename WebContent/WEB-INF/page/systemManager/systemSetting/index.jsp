<!-- 系统 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>
<div class="tabs" currentIndex="0" eventType="click" style="margin: 1px;" >
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<li><a href="${base }/systemPwd/index.do" class="j-ajax"><span>系统密码</span></a></li>
				<li><a href="${base }/batch/index.do" class="j-ajax"><span>批次</span></a></li>
				<li><a href="${base }/userDept/index.do" class="j-ajax"><span>人员部门</span></a></li>
				<li><a href="${base }/dept/index.do" class="j-ajax"><span>营业部门</span></a></li>
				<li><a href="${base }/meal/index.do" class="j-ajax"><span>餐别</span></a></li>
				<li><a href="${base }/cookbook/index.do" class="j-ajax"><span>菜谱</span></a></li>
				<li><a href="${base }/orderTime/index.do" class="j-ajax"><span>订餐时间段</span></a></li>
				<li><a href="${base }/discount/index.do" class="j-ajax"><span>优惠方案</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>一控一水控</span></a></li>
				<li><a href="${base }/multiWaterRate/index.do" class="j-ajax"><span>一控多水控</span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<li><a href="${base }/consumeParam/index.do" class="j-ajax"><span>消费参数</span></a></li>
				<li><a href="${base }/cardParam/index.do" class="j-ajax"><span>制卡参数</span></a></li>
				<li><a href="${base }/entranceGuard/index.do" class="j-ajax"><span>门禁参数</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率2</span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsContent" style="padding:0;" layoutH="0">
		<div>
			<jsp:include page="${base }/systemPwd/index.do"/>
		</div>
		<div></div>
		<div class="refresh"></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
		<div></div>
	</div>
</div>
