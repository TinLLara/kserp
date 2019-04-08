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
        };
        
        function doSelect(projectid,proname){
			window.opener.setChoiseProj('${clickObjectName}','${clickObjectId}',projectid,proname);
			window.close();
		};
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oaproject/busProject/listforselect">项目信息列表</a></li>
		<%-- <shiro:hasPermission name="oaproject:busProject:edit"><li><a href="${ctx}/oaproject/busProject/form">项目信息添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="busProject" action="${ctx}/oaproject/busProject/listforselect" method="post" class="breadcrumb form-search">
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
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="busProject">
			<tr>
				<td>
					${busProject.proname}
				</td>
				<td>
					<fmt:formatDate value="${busProject.createtime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${busProject.creator}
				</td>
				<td>
					${fns:abbr(busProject.procomm,25)}
				</td>
				<td>
					${busProject.customer}
				</td>
				<td>
    				<a  onclick="doSelect('${busProject.projectid}','${busProject.proname}');" style="cursor: pointer;">选取</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>