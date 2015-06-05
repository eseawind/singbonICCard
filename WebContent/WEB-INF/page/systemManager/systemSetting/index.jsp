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
				<li><a href=":;" class="j-ajax"><span>系统参数</span></a></li>
				<li><a href="${base }/batch/index.do" class="j-ajax"><span>批次设置</span></a></li>
				<li><a href="${base }/userDept/index.do" class="j-ajax"><span>人员部门设置</span></a></li>
				<li><a href="${base }/discount/index.do" class="j-ajax"><span>优惠方案设置</span></a></li>
			</ul>
		</div>
	</div>
	<div class="tabsContent" style="padding:0;" layoutH="0">
		<div></div>
		<div></div>
		<div></div>
		<div></div>
	</div>
</div>
