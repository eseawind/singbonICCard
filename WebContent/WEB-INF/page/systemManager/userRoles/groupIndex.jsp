<!-- 授权分组 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	
</script>

<style type="text/css">
</style>

<div>
	<div
		style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
		<div id="authTree" layoutH="60">
			<ul class="tree treeCheck treeFolder expand">
				<li><a href="javascript:;" tvalue="ROLE_SYSTEMMANAGER">系统管理</a>
					<ul>
						<li><a href="javascript:;" tvalue="ROLE_SYSTEMSETTING">系统设置</a>
							<ul>
								<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAM">系统参数</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAM_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_BATCH">批次</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_BATCH_ADD">添加</a></li>
										<li><a href="javascript:;" tvalue="ROLE_BATCH_EDIT">修改</a></li>
										<li><a href="javascript:;" tvalue="ROLE_BATCH_DEL">挂失</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_USERDEPT">人员部门</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_USERDEPT_ADD">添加</a></li>
										<li><a href="javascript:;" tvalue="ROLE_USERDEPT_EDIT">修改</a></li>
										<li><a href="javascript:;" tvalue="ROLE_USERDEPT_DEL">删除</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_DEPT">营业部门</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_DEPT_ADD">添加</a></li>
										<li><a href="javascript:;" tvalue="ROLE_DEPT_EDIT">修改</a></li>
										<li><a href="javascript:;" tvalue="ROLE_DEPT_DEL">删除</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_MEAL">餐别</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_MEAL_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_COOKBOOK">菜谱</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_COOKBOOK_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_ORDERTIME">订餐时间段</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_ORDERTIME_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_DISCOUNT">优惠方案</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_ORDERTIME_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_CONSUMEPARAM">消费参数</a>
									<ul>
										<li><a href="javascript:;"
											tvalue="ROLE_CONSUMEPARAM_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_POSPARAMGROUP">消费机参数组</a>
									<ul>
										<li><a href="javascript:;"
											tvalue="ROLE_POSPARAMGROUP_ADD">添加</a></li>
										<li><a href="javascript:;"
											tvalue="ROLE_POSPARAMGROUP_EDIT">修改</a></li>
										<li><a href="javascript:;"
											tvalue="ROLE_POSPARAMGROUP_DEL">删除</a></li>
										<li><a href="javascript:;"
											tvalue="ROLE_POSPARAMGROUP_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_WATERRATEGROUP">一控一水控参数组</a>
									<ul>
										<li><a href="javascript:;"
											tvalue="ROLE_WATERRATEGROUP_ADD">添加</a></li>
										<li><a href="javascript:;"
											tvalue="ROLE_WATERRATEGROUP_EDIT">修改</a></li>
										<li><a href="javascript:;"
											tvalue="ROLE_WATERRATEGROUP_DEL">删除</a></li>
										<li><a href="javascript:;"
											tvalue="ROLE_WATERRATEGROUP_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_CARDPARAM">制卡参数</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_CARDPARAM_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_CARDPARAM">制卡参数</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_CARDPARAM_SAVE">保存</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_ENTRANCEGUARD">门禁参数</a>
									<ul>
										<li><a href="javascript:;"
											tvalue="ROLE_ENTRANCEGUARD_SAVE">保存</a></li>
									</ul></li>
							</ul></li>
						<li><a href="javascript:;" tvalue="ROLE_DEVICEMANAGER">设备管理</a>
							<ul>
								<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAM">系统参数</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAM_SAVE">保存</a></li>
									</ul></li>
							</ul></li>
<!-- 						<li><a href="javascript:;" tvalue="ROLE_USERROLES">授权管理</a> -->
<!-- 							<ul> -->
<!-- 								<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAM">系统参数</a> -->
<!-- 									<ul> -->
<!-- 										<li><a href="javascript:;" tvalue="ROLE_SYSTEMPARAM_SAVE">保存</a></li> -->
<!-- 									</ul></li> -->
<!-- 							</ul></li> -->
						<li><a href="javascript:;" tvalue="ROLE_SUBSIDY">补助管理</a>
							<ul>
								<li><a href="javascript:;" tvalue="ROLE_ADDSUBSIDY">添加补助</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_ADDSUBSIDY_ADD_SUBSIDYFARE">添加补助金额</a></li>
										<li><a href="javascript:;" tvalue="ROLE_ADDSUBSIDY_AUTO_SUBSIDYFARE">自动生成补助金额</a></li>
										<li><a href="javascript:;" tvalue="ROLE_ADDSUBSIDY_ADD_SUBSIDY">添加补助准备</a></li>
									</ul></li>
								<li><a href="javascript:;" tvalue="ROLE_GENERATESUBSIDY">生成补助</a>
									<ul>
										<li><a href="javascript:;" tvalue="ROLE_GENERATESUBSIDY_EDIT_SUBSIDYFARE">修改补助金额</a></li>
										<li><a href="javascript:;" tvalue="ROLE_GENERATESUBSIDY_DEL">删除选中人员</a></li>
										<li><a href="javascript:;" tvalue="ROLE_GENERATESUBSIDY_GENERATE">生成补助</a></li>
									</ul></li>
							</ul></li>
					</ul></li>
				<li><a href="javascript:;" tvalue="ROLE_CARDMANAGER">制卡中心</a>
					<ul>
						<li><a href="javascript:;" tvalue="ROLE_MAINDCARD">用户卡管理</a></li>
						<li><a href="javascript:;" tvalue="ROLE_FUNCCARD">功能卡制作</a></li>
						<li><a href="javascript:;" tvalue="ROLE_CARDREADER">读卡机参数下载</a></li>
					</ul></li>
				<li><a href="javascript:;" tvalue="ROLE_ACCOUNTCENTER">结算中心</a>
				</li>
				<li><a href="javascript:;" tvalue="ROLE_MONITOR">监控平台</a></li>
			</ul>
		</div>
	</div>

	<div id="groupList" class="unitBox" style="margin-left: 246px;">
		<jsp:include page="${base }/groupList.do" />
	</div>
</div>
