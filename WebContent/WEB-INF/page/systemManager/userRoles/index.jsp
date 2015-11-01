<!-- 授权管理 -->
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
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USERROLES_GROUP">
				<li><a href="${base }/groupIndex.do" class="j-ajax"><span>授权分组</span></a></li>
				</security:authorize>
				<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_USERROLES_USER">
				<li><a href="${base }/userIndex.do" class="j-ajax"><span>用户授权</span></a></li>
				</security:authorize>
			</ul>
		</div>
	</div>
	<div class="tabsContent" style="padding:0;" layoutH="0">
		<div></div>
		<div></div>
	</div>
</div>
