<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日程安排管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oachedule/oachedule/oaSchedule/">日程安排列表</a></li>
		<shiro:hasPermission name="oachedule:oachedule:oaSchedule:edit"><li><a href="${ctx}/oachedule/oachedule/oaSchedule/form">日程安排添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaSchedule" action="${ctx}/oachedule/oachedule/oaSchedule/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>日程主题：</label>
				<form:input path="title" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>开始时间：</label>
				<input name="beginStrattime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaSchedule.beginStrattime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endStrattime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaSchedule.endStrattime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>日程主题</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<shiro:hasPermission name="oachedule:oachedule:oaSchedule:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaSchedule">
			<tr>
				<td><a href="${ctx}/oachedule/oachedule/oaSchedule/form?id=${oaSchedule.id}">
					${oaSchedule.title}
				</a></td>
				<td>
					${oaSchedule.strattime}
				</td>
				<td>
					${oaSchedule.endtime}
				</td>
				<shiro:hasPermission name="oachedule:oachedule:oaSchedule:edit"><td>
    				<a href="${ctx}/oachedule/oachedule/oaSchedule/form?id=${oaSchedule.id}">修改</a>
					<a href="${ctx}/oachedule/oachedule/oaSchedule/delete?id=${oaSchedule.id}" onclick="return confirmx('确认要删除该日程安排吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>