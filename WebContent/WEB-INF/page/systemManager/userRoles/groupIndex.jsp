<!-- 授权分组 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="authTree" layoutH="30">
			<ul class="tree treeCheck treeFolder expand">
				<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">系统设置</a>
					<ul>
						<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAMETER">系统参数</a></li>
						<li><a href="javascript:;" tvalue="ROLE_BATCH">批次设置</a>
							<ul>
								<li><a href="javascript:;" tvalue="ROLE_BATCH_ADD">添加</a></li>
								<li><a href="javascript:;" tvalue="ROLE_BATCH_EDIT">修改</a></li>
							</ul></li>
						<li><a href="javascript:;" tvalue="ROLE_USERDEPT">人员部门设置</a>
							<ul>
								<li><a href="javascript:;" tvalue="ROLE_USERDEPT_ADD">添加</a></li>
								<li><a href="javascript:;" tvalue="ROLE_USERDEPT_EDIT">修改</a></li>
								<li><a href="javascript:;" tvalue="ROLE_USERDEPT_DEL">删除</a></li>
							</ul></li>
						<li><a href="javascript:;" tvalue="ROLE_DISCOUNT">优惠方案设置</a>
							<ul>
								<li><a href="javascript:;" tvalue="ROLE_DISCOUNT_ADD">添加</a></li>
								<li><a href="javascript:;" tvalue="ROLE_DISCOUNT_EDIT">修改</a></li>
								<li><a href="javascript:;" tvalue="ROLE_DISCOUNT_DEL">删除</a></li>
							</ul></li>
					</ul></li>
			<li><a href="javascript:;" tvalue="ROLE_CARDCENTER">制卡中心</a>
				<ul>
					<li><a href="javascript:;" tvalue="ROLE_FUNCCARD">功能卡制作</a></li>
					<li><a href="javascript:;" tvalue="ROLE_CARDMANAGER">卡管理</a></li>
				</ul></li>
			<li><a href="javascript:;" tvalue="ROLE_ACCOUNTINGCENTER">结算中心</a>
				<ul>
					<!-- 						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">功能卡制作</a></li> -->
					<!-- 						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">卡管理</a></li> -->
				</ul></li>
			</ul>
		</div>
	</div>

	<div id="groupList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/groupList.do" />
	</div>
</div>
