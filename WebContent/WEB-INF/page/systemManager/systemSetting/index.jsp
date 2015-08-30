<!-- 系统设置 -->
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
				<li><a href="${base }/batch/index.do" class="j-ajax"><span>批次设置</span></a></li>
				<li><a href="${base }/userDept/index.do" class="j-ajax"><span>人员部门设置</span></a></li>
				<li><a href="${base }/dept/index.do" class="j-ajax"><span>营业部门设置</span></a></li>
				<li><a href="${base }/meal/index.do" class="j-ajax"><span>餐别设置</span></a></li>
				<li><a href="${base }/cookbook/index.do" class="j-ajax"><span>菜谱设置</span></a></li>
				<li><a href="${base }/discount/index.do" class="j-ajax"><span>优惠方案设置</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>一控一水控设置</span></a></li>
				<li><a href="${base }/multiWaterRate/index.do" class="j-ajax"><span>一控多水控设置</span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<li><a href="${base }/consumeParam/index.do" class="j-ajax"><span>消费参数设置</span></a></li>
				<li><a href="${base }/cardParam/index.do" class="j-ajax"><span>制卡参数设置</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率设置</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率设置</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率设置</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率设置</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率设置</span></a></li>
				<li><a href="${base }/waterRate/index.do" class="j-ajax"><span>水控费率设置2</span></a></li>
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
