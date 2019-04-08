<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>财务组织管理</title>
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
		
		function doSelect(companyid,compname){
			window.opener.setFinance('${clickObjectName}','${clickObjectId}',companyid,compname);
			window.close();
		};
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oafinorg/oaMoneyCompany/">财务组织列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="oaMoneyCompany" action="${ctx}/oafinorg/oaMoneyCompany/?from=select&clickObjectName=${clickObjectName}&clickObjectId=${clickObjectId}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>公司名称：</label>
				<form:input path="compname" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>公司名称</th>
				<th>简称</th>
				<th>简介</th>
				<shiro:hasPermission name="oafinorg:oaMoneyCompany:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaMoneyCompany">
			<tr>
				<td>
					${oaMoneyCompany.compname}
				</td>
				<td>
					${oaMoneyCompany.nativename}
				</td>
				<td>
					${oaMoneyCompany.region}
				</td>
				<shiro:hasPermission name="oafinorg:oaMoneyCompany:edit"><td>
    				<a  onclick="doSelect('${oaMoneyCompany.companyid}','${oaMoneyCompany.compname}');" style="cursor: pointer;">选取</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>