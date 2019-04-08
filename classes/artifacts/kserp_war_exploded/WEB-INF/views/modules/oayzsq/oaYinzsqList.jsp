<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>印章申请管理</title>
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
		<li class="active"><a href="${ctx}/oayzsq/oaYinzsq/">印章申请列表</a></li>
		<shiro:hasPermission name="oayzsq:oaYinzsq:edit"><li><a href="${ctx}/oayzsq/oaYinzsq/form">印章申请添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaYinzsq" action="${ctx}/oayzsq/oaYinzsq/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用章类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('oayzlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>审批状态：</label>
				<form:select path="appresult" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('flowstatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>起草人</th>
				<th>起草时间</th>
				<th>用印份数</th>
				<th>用章类型</th>
				<th>用途</th>
				<th>审批状态</th>
				<shiro:hasPermission name="oayzsq:oaYinzsq:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaYinzsq">
			<tr>
				<td><a href="${ctx}/oayzsq/oaYinzsq/form?id=${oaYinzsq.id}&tag=view">
					${oaYinzsq.appname}
				</a></td>
				<td>
					${oaYinzsq.appdate}
				</td>
				<td>
					${oaYinzsq.yynum}
				</td>
				<td>
					${oaYinzsq.filename}
				</td>
				<td>
					${oaYinzsq.fileormeno}
				</td>
				<td>
					${fns:getDictLabel(oaYinzsq.nextop, 'flowstatus', '')}
				</td>
				<shiro:hasPermission name="oayzsq:oaYinzsq:edit"><td>
    				<a href="${ctx}/oayzsq/oaYinzsq/form?id=${oaYinzsq.id}" onclick="if('${oaYinzsq.nextop}'!='save'&&'${oaYinzsq.nextop}'!='refuse'){alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">修改</a>
					<a href="${ctx}/oayzsq/oaYinzsq/delete?id=${oaYinzsq.id}" onclick="if('${oaYinzsq.nextop}'=='save'||'${oaYinzsq.nextop}'=='refuse'){return confirmx('确认要删除该请印章申请吗？', this.href);}else{alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>