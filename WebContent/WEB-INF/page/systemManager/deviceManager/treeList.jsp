<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	var deviceTree=$('.deviceTree');
	var list = $('#deviceTree li');
	list.each(function() {
		var $this = $(this);
		var parentId = $this.attr('parentId');		
		if (parentId == '0') {
			$('.expand', deviceTree).append($this);
		} else {
			var $li = $('li[deviceId="' + parentId + '"]', deviceTree);
			if ($('>ul', $li).size() == 0) {
				$('<ul></ul>', deviceTree).appendTo($li);
			}
			$('>ul', $li).append($(this));
		}
	});
</script>

<div id="deviceTree">
	<c:forEach items="${groupList }" var="g">
		<li deviceId="g${g.id }" parentId="g0"><a href="javascript:;" module="deviceManager"
			deviceId="${g.id }">${g.groupName }</a></li>
	</c:forEach>
	<c:forEach items="${deviceList }" var="d">
		<li deviceId="${d.id }" parentId="g${d.groupId }"><a href="javascript:;" module="deviceManager"
			deviceId="${d.id }">${d.deviceName }</a></li>
	</c:forEach>
</div>
<ul class="tree collapse deviceTree">
	<li deviceId="g0"><a href="javascript:;" module="device" deviceId="0">设备列表</a>
		<ul class="expand">

		</ul></li>
</ul>
