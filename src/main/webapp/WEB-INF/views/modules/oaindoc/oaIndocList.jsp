<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内部公函管理</title>
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
		<li class="active"><a href="${ctx}/oaindoc/oaIndoc/">内部公函列表</a></li>
		<shiro:hasPermission name="oaindoc:oaIndoc:edit"><li><a href="${ctx}/oaindoc/oaIndoc/form">内部公函添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaIndoc" action="${ctx}/oaindoc/oaIndoc/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>公函题目：</label>
				<form:input path="indocname" htmlEscape="false" maxlength="400" class="input-medium"/>
			</li>
			<li><label>审批状态：</label>
				<form:select path="indocnextop" class="input-medium">
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
		<thead align="center">
			<tr>
				<th>部门名称</th>
				<th>公函题目</th>
				<th>呈文日期</th>
				<th>下一处理事件</th>
				<shiro:hasPermission name="oaindoc:oaIndoc:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaIndoc">
			<tr>
				<td><a href="${ctx}/oaindoc/oaIndoc/form?indocid=${oaIndoc.indocid}&tag=view">
					${oaIndoc.indoccode}
				</a></td>
				<td>
					${oaIndoc.indocname}
				</td>
				<td>
					<fmt:formatDate value="${oaIndoc.indoccdate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(oaIndoc.indocnextop, 'flowstatus', '')}
				</td>
				<shiro:hasPermission name="oaindoc:oaIndoc:edit"><td>
    				<a href="${ctx}/oaindoc/oaIndoc/form?indocid=${oaIndoc.indocid}" onclick="if('${oaIndoc.indocnextop}'!='save'&&'${oaIndoc.indocnextop}'!='refuse'){alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">修改</a>
					<a href="${ctx}/oaindoc/oaIndoc/delete?indocid=${oaIndoc.indocid}" onclick="if('${oaIndoc.indocnextop}'=='save'||'${oaIndoc.indocnextop}'=='refuse'){return confirmx('确认要删除该请内部公函吗？', this.href);}else{alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>