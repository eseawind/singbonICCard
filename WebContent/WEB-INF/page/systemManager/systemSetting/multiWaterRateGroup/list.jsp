<!-- 一控多水控参数分组列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>
<style type="text/css">

</style>
<table class="table" width="108%" rel="jbsxBox">
<!-- 	<thead> -->
<!-- 		<tr> -->
<!-- 			<th width="100">分组名称</th> -->
<!-- 		</tr> -->
<!-- 	</thead> -->
	<tbody>
		<c:forEach items="${list }" var="w">
			<tr target="multiWaterRateGroup" id="${w.id }">
				<td style="color: #15428B;">${w.groupName }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>