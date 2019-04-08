<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目信息管理</title>
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
		<li class="active"><a href="${ctx}/oaproject/busProject/">项目信息列表</a></li>
		<shiro:hasPermission name="oaproject:busProject:edit"><li><a href="${ctx}/oaproject/busProject/form">项目信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="busProject" action="${ctx}/oaproject/busProject/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>项目名称：</label>
				<form:input path="proname" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>项目名称</th>
				<th>创建时间</th>
				<th>创建人</th>
				<th>项目描述</th>
				<th>客户</th>
				<shiro:hasPermission name="oaproject:busProject:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="busProject">
			<tr>
				<td><a href="${ctx}/oaproject/busProject/form?id=${busProject.id}">
					${busProject.proname}
				</a></td>
				<td>
					<fmt:formatDate value="${busProject.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${busProject.creator}
				</td>
				<td>
					${busProject.procomm}
				</td>
				<td>
					${busProject.customer}
				</td>
				<shiro:hasPermission name="oaproject:busProject:edit"><td>
    				<a href="${ctx}/oaproject/busProject/form?id=${busProject.id}">修改</a>
					<a href="${ctx}/oaproject/busProject/delete?id=${busProject.id}" onclick="return confirmx('确认要删除该项目信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>