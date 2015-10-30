<!-- 系统 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	
</script>
<div class="tabs" currentIndex="0" loadIndex="0" eventType="click" style="margin: 1px;" >
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_SYSTEMPARAM">
				<li><a href="${base }/systemParam/index.do" class="j-ajax"><span>系统参数</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_BATCH">
				<li><a href="${base }/batch/index.do" class="j-ajax"><span>批次</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USERDEPT">
				<li><a href="${base }/userDept/index.do" class="j-ajax refresh"><span>人员部门</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DEPT">
				<li><a href="${base }/dept/index.do" class="j-ajax"><span>营业部门</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_MEAL">
				<li><a href="${base }/meal/index.do" class="j-ajax"><span>餐别</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_COOKBOOK">
				<li><a href="${base }/cookbook/index.do" class="j-ajax"><span>菜谱</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_ORDERTIME">
				<li><a href="${base }/orderTime/index.do" class="j-ajax"><span>订餐时间段</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DISCOUNT">
				<li><a href="${base }/discount/index.do" class="j-ajax"><span>优惠方案</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_CONSUMEPARAM">
				<li><a href="${base }/consumeParam/index.do" class="j-ajax"><span>消费参数</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_POSPARAMGROUP">
				<li><a href="${base }/posParamGroup/index.do" class="j-ajax"><span>消费机参数组</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_WATERRATEGROUP">
				<li><a href="${base }/waterRateGroup/index.do" class="j-ajax"><span>一控一水控参数组</span></a></li>
				</security:authorize>
<%-- 				<li><a href="${base }/multiWaterRateGroup/index.do" class="j-ajax"><span>一控多水控参数组</span></a></li> --%>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_CARDPARAM">
				<li><a href="${base }/cardParam/index.do" class="j-ajax"><span>制卡参数</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_ENTRANCEGUARD">
				<li><a href="${base }/entranceGuard/index.do" class="j-ajax"><span>门禁参数</span></a></li>
				</security:authorize>
			</ul>
		</div>
	</div>
	<div class="tabsContent" style="padding:0;" layoutH="0">
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
		<div></div>
		<div></div>
		<div></div>
	</div>
</div>
