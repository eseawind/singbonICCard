<!-- 单位设置 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
	$(function() {
		$('#companyForm .add').click(function() {
			$('#companyForm input').eq(0).val('');
			var form = $(this).parents('form');
			validateCallback(form, function(e) {
				if (e == 1) {
					alertMsg.correct('添加成功！');					
					form.clearForm();
					refreshcompanyList();
				}else if (e == 2) {
					alertMsg.correct('该单位名称已存在！');
				} else {
					alertMsg.error('添加失败！');
				}
			}, null);
		});

		$('#companyForm .edit').click(function() {
			var form = $(this).parents('form');
			validateCallback(form, function(e) {
				if (e == 1) {
					alertMsg.correct('修改成功！');					
					refreshcompanyList();
				}else if (e == 2) {
					alertMsg.correct('该单位名称已存在！');
				} else {
					alertMsg.error('修改失败！');
				}
			}, null, false);
		});
		$('#companyForm .delete').click(function(){
			var form = $(this).parents('form');
			var id = $('#companyForm input[name=id]').val();
			if(id==''){
				alertMsg.error('请选择一个单位！');				
			}else{
				var companyName = $('#companyForm input[name=companyName]').val();
				alertMsg.confirm('确定要删除'+companyName+'吗？', {
					okCall : function() {
						$.post('${base }/delete.do?id=' + id,function(e){
							if (e == 1) {
								alertMsg.correct('删除成功！');
								refreshcompanyList();
							} else {
								alertMsg.warn('删除失败！');
							} 
						});
					}
				});
			}
		});
	});

	function refreshcompanyList() {
		var url='${base}/list.do?pageNum='+$('#companyList form input[name=pageNum]').val()+'&numPerPage='+$('#companyList form input[name=numPerPage]').val();
		$('#companyList').loadUrl(url,{},function(){
			$('#companyList').find('[layoutH]').layoutH();
		});
	}
	
	//选择单位
	function companyClick(tr) {
		var i=0;
		$('#companyForm input').eq(i++).val(tr.attr('id'));
		tr.find('td:not(:first)').each(function(){
			if(i==5){
				i=4;
			}
			$('#companyForm input').eq(i++).val($('div',this).html());
		});
		var select = $('#companyForm select');
		select.prev().val(tr.attr('baseSection')).html($('option[value=' + tr.attr('baseSection') + ']', select).html());
	};
</script>
<link href="/themes/css/custom.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
	.form input {
		width: 150px;
	}
</style>
<div class="form" layoutH="30"
	style="float: left; display: block; overflow: auto; width: 240px; border: solid 1px #CCC; line-height: 21px; background: #fff">
	<div layoutH="332"></div>
	<form id="companyForm" method="post" action="${base}/addEdit.do"
		class="pageForm required-validate">
		<div class="pageFormContent">
			<dl style="margin: 10px 0;">
				<dt>单位名称：</dt>
				<dd>
					<input type="hidden" name="id" /> 
					<input type="text" name="companyName" maxlength="20" class="required" />
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>序列号：</dt>
				<dd>
					<input type="text" name="serialNumber" maxlength="20" class="required"/>
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>授权号：</dt>
				<dd>
					<input type="text" name="authNumber" maxlength="20" class="required"/>
				</dd>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>扇区号：</dt>
				<select class="combox" name=baseSection outerw="128" innerw="145">
					<c:forEach var="i" begin="1" end="13" step="1">
						<option value="${i}">${i}</option>
					</c:forEach>
				</select>
			</dl>
			<dl style="margin: 10px 0;">
				<dt>试用日期：</dt>
				<dd>
					<input type="text" name="invalidDate" maxlength="20" class="date"/>
				</dd>
			</dl>
		</div>
		<div class="formBar">
			<div class="panelBar" style="border-style: none;">
				<ul class="toolBar">
					<li><a class="add" href="javascript:;"><span>添加</span></a></li>
					<li><a class="edit" href="javascript:;"><span>修改</span></a></li>
					<li><a class="delete" href="javascript:;"><span>删除</span></a></li>
				</ul>
			</div>
		</div>
	</form>
</div>

<div id="companyList" class="unitBox" style="margin-left: 246px;">
	<jsp:include page="${base}/list.do?pageNum=1&numPerPage=50" />
</div>
