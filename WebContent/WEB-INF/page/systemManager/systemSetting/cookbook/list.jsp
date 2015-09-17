<!-- 菜肴清单列表 -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	function cookbookClick(tr) {
		$('#cookbookForm input').eq(0).val(tr.attr('cookbookId'));
		var tds = tr.find('td');
		$('#cookbookForm input').eq(1).val(tds.eq(1).find('div').html());
		$('#cookbookForm input').eq(2).val(tds.eq(2).find('div').html());
		$('#cookbookForm input').eq(3).val(tds.eq(3).find('div').html());
		var enable = tr.attr('enable');
		if(enable=='false'){
			$('#cookbookForm input[name=status]').attr('checked',false);
		}else{
			$('#cookbookForm input[name=status]').attr('checked',true);			
		}
	}
	
	$(function(){
		$('#coookbookList #search').click(function(){
			var val=$('#coookbookList #searchStr').val().trim();
			if(val==''){
				$('#coookbookList .item').removeClass('hide');
			}else{
				$('#coookbookList .item').addClass('hide');
				$("#coookbookList .item[cookbookCode*="+val+"],#coookbookList .item[cookbookName*="+val+"]").removeClass('hide');				
			}
		});
		$('#coookbookList .item[enable=false]').addClass('red');
	});
</script>
<style type="text/css">
	.red{
		color: red;
	}
	.hide{
		display: none;
	}
</style>
<div id="coookbookList">
	<div class="pageHeader" style="border: 1px #B8D0D6 solid">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td>编号/菜名：<input type="text" id="searchStr"/>
					</td>
					<td><div class="buttonActive">
							<div class="buttonContent">
								<button type="button" id="search">筛选</button>
							</div>
						</div></td>
				</tr>
			</table>
		</div>
	</div>
	<table class="table" width="99%" rel="jbsxBox" layoutH="90">
		<thead>
			<tr>
				<th width="100">编号</th>
				<th width="100">菜名</th>
				<th width="100">价格</th>
				<th width="100">备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="c">
				<tr class="item" target="cookbook" cookbookId="${c.id }" cookbookCode="${c.cookbookCode}" cookbookName="${c.cookbookName }" enable="${c.enable }">
					<td>${c.cookbookCode }</td>
					<td>${c.cookbookName }</td>
					<td>${c.price }</td>
					<td>${c.remark }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>