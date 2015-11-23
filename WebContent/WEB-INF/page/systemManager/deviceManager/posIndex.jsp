<!-- 消费机管理 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
	var selectDeptId=0;
	var selectDeviceId=0;
	$(function() {
		//设备
		$('#posForm .add').click(function() {
			$('#posForm input').eq(0).val('');
			$('#posForm input').eq(1).val(selectDeptId);			
			var form = $(this).parents('form');
			if(form.valid()){
				var sn=$('#posForm input[name=sn]').val().trim();
				var reg=/^[0-9a-fA-F]{32}$/;
				if(!reg.test(sn)){
					alertMsg.warn('序列号不合法！');
					return;
				}
				
				validateCallback(form, function(e) {
					if (e==1) {
						$('#posForm').clearForm();
						refreshPosList();
						alertMsg.correct('添加成功！');
					}else if (e==2) {
						alertMsg.warn('序列号不合法！');
					}else if (e==3) {
						alertMsg.warn('机器号已存在！');
					}else if (e==4) {
						alertMsg.warn('序列号已存在！');
					} else {
						alertMsg.warn('添加失败！');
					}
				}, null,true);				
			}
			
		});
		$('#posForm .edit').click(function() {
			var form = $(this).parents('form');
			if(form.valid()){
				var sn=$('#posForm input[name=sn]').val().trim();
				var reg=/^[0-9a-fA-F]{32}$/;
				if(!reg.test(sn)){
					alertMsg.warn('序列号不合法！');
					return;
				}
				
				validateCallback(form, function(e) {
					if (e == 1) {
						refreshPosList();
						alertMsg.correct('修改成功！');
					}else if (e==2) {
						alertMsg.warn('序列号不合法！');
					}else if (e==3) {
						alertMsg.warn('机器号已存在！');
					}else if (e==4) {
						alertMsg.warn('序列号已存在！');
					} else {
						alertMsg.warn('修改失败！');
					}
				}, null, true);
			}
		});
		$('#posForm .delete').click(function() {
			if(selectDeviceId==0){
				alertMsg.warn('请选择设备！');
				return;
			}
			var deviceName=$('#posForm input[name=deviceName]').val();
			alertMsg.confirm('确定要删除'+deviceName+'吗？', {
				okCall : function() {
					var sn=$('#posForm input[name=sn]').val();
					$.post('${base }/delete.do?id=' + selectDeviceId+'&sn='+sn,function(e) {
						if (e == 1) {
							refreshPosList();
							$('#posForm').clearForm();
							selectDeviceId=0;
							alertMsg.correct('删除成功！');
						} else if (e == 0) {
							alertMsg.warn('删除失败');
						}
					});
				}
			});
		});
	});

	function refreshPosList() {
		divSearch($('#posList #pagerForm'), 'posList');
	}

	//选择部门
	function selectDeviceDept(a) {
		selectDeptId = a.attr('deptId');
		$('#posList #pagerForm input[name=deptId]').val(selectDeptId);
		if($('.posForm input[name=includeSub]').attr('checked')){
			$('#posList #pagerForm input[name=includeSub]').val(1);				
		}else{
			$('#posList #pagerForm input[name=includeSub]').val('');				
		}
		refreshPosList();
	};
	//选择设备
	function posListClick(tr) {
		selectDeviceId=tr.attr('id');
		$('#posForm input[name=id]').val(selectDeviceId);
		$('#posForm input[name=deviceNum]').val(tr.attr('deviceNum'));
		$('#posForm input[name=deviceName]').val(tr.attr('deviceName'));
		$('#posForm input[name=oldSn]').val(tr.attr('sn'));
		$('#posForm input[name=sn]').val(tr.attr('sn'));
		var enable = tr.attr('enable');
		if(enable==0){
			$('#posForm input[name=status]').attr('checked',false);
		}else{
			$('#posForm input[name=status]').attr('checked',true);			
		}
		
		var deviceTypeSelect=$('#posForm select[name=deviceType]');
		var deviceType=tr.attr('deviceType');
		var selectContent=$('option[value=' + deviceType + ']', deviceTypeSelect).html();
		deviceTypeSelect.val(deviceType).prev().attr('value',deviceType).html(selectContent);
		
		$('ul.comboxop li[param^=p]').hide();
		$('ul.comboxop li[param=p'+deviceType+']').show();
		
		var paramGroupSelect=$('#posForm select[name=paramGroupId]');
		var paramGroupId=tr.attr('paramGroupId');
		selectContent=$('option[param=p'+deviceType+'][value=' + paramGroupId + ']', paramGroupSelect).html();
// 		alert(paramGroupId+" "+selectContent);
		paramGroupSelect.val(paramGroupId).prev().attr('value',paramGroupId).html(selectContent);
		
		var transferSelect=$('#posForm select[name=transferId]');
		var transferId=tr.attr('transferId');
		selectContent=$('option[value=' + transferId + ']', transferSelect).html();
		transferSelect.val(paramGroupId).prev().attr('value',transferId).html(selectContent);
	};
</script>
<link href="themes/css/custom.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.posForm input,.form input {
		width: 230px;
	}
	.posForm dd span.error {
		left: 65px;
		width: 230px;
		top:25px;
	}
</style>

<script type="text/javascript">
	var deptTree=$('.deptTree');
	var list = $('#deptTreeLi li');
	if(list.length!=0){
		$('li', deptTree).append("<ul class='expand'></ul>");
	}
	list.each(function() {
		var $this = $(this);
		var parentId = $this.attr('parentId');		
		if (parentId == '0') {
			$('.expand', deptTree).append($this);
		} else {
			var $li = $('li[deptId="' + parentId + '"]', deptTree);
			if ($('>ul', $li).size() == 0) {
				$('<ul></ul>', deptTree).appendTo($li);
			}
			$('>ul', $li).append($(this));
		}
	});
</script>

<div id="deptTreeLi">
	<c:forEach items="${deptList }" var="d">
		<li deptId="${d.id }" parentId="${d.parentId }"><a href="javascript:;" module="deviceDept"
			deptId="${d.id }">${d.deptName }</a></li>
	</c:forEach>
</div>

<div class="form posForm" layoutH="30" style="float: left; display: block; overflow: auto; width: 305px; border: solid 1px #CCC; line-height: 21px;">
	<div layoutH="360" style="background: #fff;">
		<ul class="tree expand deptTree">
			<li deptId="0"><a href="javascript:;" module="deviceDept" deptId="0">营业部门列表</a>
			</li>
		</ul>
		<div style="position:absolute;top:30px;left: 200px;">
			<input type="checkbox" name="includeSub" style="width: 13px;top:2px; " <c:if test="${includeSub=='on'}">checked</c:if>/>包含下级
		</div> 
	</div>
	<form id="posForm" method="post" action="${base }/addEdit.do" class="pageForm required-validate">
		<div class="pageFormContent">
			<dl>
				<dt>机器号：</dt>
				<dd>
					<input type="hidden" name="id" />
					<input type="hidden" name="deptId" />
					<input type="text" name="deviceNum" min="1" max="99999999" class="required digits" />
					<span style="float: left;margin-top: 5px;">(范围 1-99999999)</span>
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>设备名称：</dt>
				<dd>
					<input type="text" name="deviceName" maxlength="20" class="required" />
				</dd>
			</dl>
			<dl style="margin-bottom: 10px">
				<dt>序列号：</dt>
				<dd>
					<input type="hidden" name="oldSn"/>
					<input type="text" name="sn" minlength="32" maxlength="32" class="required" />
				</dd>
			</dl>
			<dl style="margin-bottom: 10px">
				<dt>设备类型：</dt>
				<dd>
					<select class="combox" name="deviceType"  outerw="208" innerw="225">
						<option clickPram="deviceType" value="2">点餐机</option>
						<option clickPram="deviceType" value="3">水控机</option>
					</select>
				</dd>
			</dl>
			<dl style="margin-bottom: 10px">
				<dt>参数分组：</dt>
				<dd>
					<select class="combox required" name="paramGroupId" outerw="208" innerw=225">
						<option class="hide" value=""> </option>
						<c:forEach items="${posParamGroupList }" var="p">
							<option param="p2" value="${p.id }">${p.groupName }</option>
						</c:forEach>
						<c:forEach items="${waterRateGroupList }" var="w">
							<option class="hide" param="p3" value="${w.id }">${w.groupName }</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>所属中转：</dt>
				<dd>
					<select class="combox required" name="transferId" outerw="208" innerw=225">
						<option value="0">无</option>
						<c:forEach items="${transferList }" var="t">
							<option value="${t.id }">${t.deviceName }</option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>&nbsp;</dt>
				<dd>
					<input type="checkbox" name="status" checked="checked" style="width: 13px;" />是否启用
				</dd>
			</dl>
		</div>
		<security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_DEVICEMANAGER_POS_ADD,ROLE_DEVICEMANAGER_POS_EDIT,ROLE_DEVICEMANAGER_POS_DEL">
			<div class="formBar">
				<div class="panelBar" style="border-style: none;">
					<ul class="toolBar">
						<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_POS_ADD,ROLE_ADMIN">
							<li><a class="add" href="javascript:;"><span>添加</span></a></li>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_POS_EDIT,ROLE_ADMIN">
							<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
						</security:authorize>
						<security:authorize ifAnyGranted="ROLE_DEVICEMANAGER_POS_DEL,ROLE_ADMIN">
							<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
						</security:authorize>
					</ul>
				</div>
			</div>
		</security:authorize>
	</form>
</div>

<div id="posList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/posList.do?pageNum=1&numPerPage=50" />
</div>
