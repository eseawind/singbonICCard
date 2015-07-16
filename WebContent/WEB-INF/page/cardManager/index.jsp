<!-- 卡操作 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>

<div class="tabs">
	<div class="tabsContent" style="border: none;">
		<div>
			<div
				style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
				111<jsp:include page="/cardManager/userDept.do" />
			</div>

			<div id="jbsxBox" class="unitBox" style="margin-left: 246px;">
				<jsp:include page="/cardManager/userList.do" />
			</div>

		</div>
	</div>
</div>
