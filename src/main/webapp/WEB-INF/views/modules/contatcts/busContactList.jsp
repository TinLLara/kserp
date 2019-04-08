<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>名片管理</title>
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
		<li class="active"><a href="${ctx}/contatcts/busContact/">名片列表</a></li>
		<shiro:hasPermission name="contatcts:busContact:edit"><li><a href="${ctx}/contatcts/busContact/form">名片添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="busContact" action="${ctx}/contatcts/busContact/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>中文名：</label>
				<form:input path="nativename" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>公司名称：</label>
				<form:input path="addr" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>中文名</th>
				<th>性别</th>
				<th>邮箱</th>
				<th>手机号码</th>
				<th>办公电话</th>
				<th>联系人职位</th>
				<th>公司名称</th>
				<shiro:hasPermission name="contatcts:busContact:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="busContact">
			<tr>
				<td><a href="${ctx}/contatcts/busContact/form?id=${busContact.id}">
					${busContact.nativename}
				</a></td>
				<td>
					${fns:getDictLabel(busContact.sex, 'lxr_sex', '')}
				</td>
				<td>
					${busContact.email}
				</td>
				<td>
					${busContact.commutel}
				</td>
				<td>
					${busContact.commuphone}
				</td>
				<td>
					${busContact.position}
				</td>
				<td>
					${busContact.addr}
				</td>
				<shiro:hasPermission name="contatcts:busContact:edit"><td>
    				<a href="${ctx}/contatcts/busContact/form?id=${busContact.id}">修改</a>
					<a href="${ctx}/contatcts/busContact/delete?id=${busContact.id}" onclick="return confirmx('确认要删除该名片吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>