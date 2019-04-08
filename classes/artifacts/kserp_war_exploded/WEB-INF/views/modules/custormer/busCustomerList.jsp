<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户信息管理</title>
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
		<li class="active"><a href="${ctx}/custormer/busCustomer/">客户信息列表</a></li>
		<shiro:hasPermission name="custormer:busCustomer:edit"><li><a href="${ctx}/custormer/busCustomer/form">客户信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="busCustomer" action="${ctx}/custormer/busCustomer/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="cname" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="ctype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>创建时间</th>
				<th>创建人</th>
				<th>名称</th>
				<th>类型</th>
				<th>所属地区</th>
				<shiro:hasPermission name="custormer:busCustomer:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="busCustomer">
			<tr>
				<td><a href="${ctx}/custormer/busCustomer/form?id=${busCustomer.id}">
					<fmt:formatDate value="${busCustomer.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${busCustomer.creator}
				</td>
				<td>
					${busCustomer.cname}
				</td>
				<td>
					${fns:getDictLabel(busCustomer.ctype, '', '')}
				</td>
				<td>
					${busCustomer.carea}
				</td>
				<shiro:hasPermission name="custormer:busCustomer:edit"><td>
    				<a href="${ctx}/custormer/busCustomer/form?id=${busCustomer.id}">修改</a>
					<a href="${ctx}/custormer/busCustomer/delete?id=${busCustomer.id}" onclick="return confirmx('确认要删除该客户信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>