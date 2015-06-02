<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var list = $("#list li");
	list.each(function() {
		var $this = $(this);
		var parendDeptId = $this.attr("parentDeptId");
		if (parendDeptId == "") {
			$(".expand").append($this);
		} else {
			var $li = $("li[deptId='" + parendDeptId + "']");
			if ($(">ul", $li).size() == 0) {
				$("<ul></ul>").appendTo($li);
			}
			$(">ul", $li).append($(this));
		}
	});
</script>

<div id="list">
	<li deptId="1" parentDeptId=""><a href="/cardManager/userList.do?deptId=1">111</a></li>
	<li deptId="2" parentDeptId=""><a href="/cardManager/userList.do?deptId=1">112</a></li>
	<li deptId="3" parentDeptId="1"><a href="/cardManager/userList.do?deptId=1">113</a></li>
	<li deptId="4" parentDeptId="2"><a href="/cardManager/userList.do?deptId=1">114</a></li>
	<li deptId="5" parentDeptId="1"><a href="/cardManager/userList.do?deptId=1">115</a></li>
	<li deptId="6" parentDeptId=""><a href="/cardManager/userList.do?deptId=1">116</a></li>
	<li deptId="7" parentDeptId="3"><a href="/cardManager/userList.do?deptId=1">116</a></li>
</div>
<ul class="tree collapse" layoutH="${h }">
	<li deptId="0"><a href="javascript">部门列表</a>
		<ul class="expand">

		</ul></li>
</ul>
