<!-- 消费机首页 -->
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
		$('#posForm input').eq(0).val(selectDeviceId);
		$('#posForm input').eq(2).val(tr.attr('deviceNum'));
		$('#posForm input').eq(3).val(tr.attr('deviceName'));
		$('#posForm input').eq(4).val(tr.attr('sn'));
		var enable = tr.attr('enable');
		if(enable==0){
			$('#posForm input[name=status]').attr('checked',false);
		}else{
			$('#posForm input[name=status]').attr('checked',true);			
		}
		var select = $('#posForm select');
		var posParamGroupId=tr.attr('posParamGroupId');
		select.eq(0).val(posParamGroupId);
		select.eq(0).prev().attr('value',posParamGroupId).html($('option[value=' + posParamGroupId + ']', select.eq(0)).html());

		var deviceType=tr.attr('deviceType');
		select.eq(1).val(deviceType);
		select.eq(1).prev().attr('value',deviceType).html($('option[value=' + deviceType + ']', select.eq(1)).html());
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
	<div layoutH="315" style="background: #fff;">
		<ul class="tree expand deptTree">
			<li deptId="0"><a href="javascript:;" module="deviceDept" deptId="0">营业部门列表</a>
			</li>
		</ul>
		<div style="position:absolute;top:30px;left: 200px;">
			<input type="checkbox" name="includeSub" style="width: 13px;top:2px; " <c:if test="${includeSub=='on'}">checked</c:if>/>包含下级
		</div>
	</div>
</div>

<div id="posList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/posList.do?pageNum=1&numPerPage=50" />
</div>
