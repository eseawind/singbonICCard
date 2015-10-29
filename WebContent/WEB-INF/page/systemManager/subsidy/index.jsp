<!-- 补助管理 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>
<div class="tabs" currentIndex="0" eventType="click" style="margin: 1px;" >
	<div class="tabsHeader">
		<div class="tabsHeaderContent">
			<ul>
				<li><a href="${base }/addIndex.do" class="j-ajax"><span>添加补助</span></a></li>
				<li><a href="${base }/generateIndex.do" class="j-ajax"><span>生成补助</span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsContent" style="padding:0;" layoutH="0">
		<div>
			<jsp:include page="${base }/addIndex.do"/>
		</div>
		<div></div>
	</div>
</div>
