<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>费用管理</title>
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
		<li class="active"><a href="${ctx}/oafee/oaFee/?feecat=${feecat}">费用列表</a></li>
		<shiro:hasPermission name="oafee:oaFee:edit"><li><a href="${ctx}/oafee/oaFee/form?feecat=${feecat}">费用添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaFee" action="${ctx}/oafee/oaFee/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="feecat" name="feecat" type="hidden" value="${feecat}"/>
		<ul class="ul-form">
			<li><label>申请人：</label>
				<form:input path="applyperson" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>申请时间：</label>
				<input name="beginApplytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaFee.beginApplytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
				<input name="endApplytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaFee.endApplytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li><label>审批状态：</label>
				<form:select path="state" class="input-medium">
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
				<th>申请人</th>
				<th>申请时间</th>
				<th>费用归属部门</th>
				<c:choose>
					<c:when test="${oaFee.feecat=='QT'}">
					</c:when>
					<c:when test="${oaFee.feecat=='ZD'}">
					</c:when>
					<c:otherwise>
						<th>出差目的地</th>
					</c:otherwise>
				</c:choose>
				<th>合计金额</th>
				<c:choose>
					<c:when test="${oaFee.feecat=='QT'}">
					</c:when>
					<c:when test="${oaFee.feecat=='ZD'}">
					</c:when>
					<c:otherwise>
						<th>相关项目</th>
					</c:otherwise>
				</c:choose>
				<th>审批状态</th>
				<shiro:hasPermission name="oafee:oaFee:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaFee">
			<tr>
				<td><a href="${ctx}/oafee/oaFee/form?feeid=${oaFee.feeid}&tag=view">
					${oaFee.applyperson}
				</a></td>
				<td>
					<fmt:formatDate value="${oaFee.applytime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${oaFee.feebelongdept}
				</td>
				<c:choose>
					<c:when test="${oaFee.feecat=='QT'}">
					</c:when>
					<c:when test="${oaFee.feecat=='ZD'}">
					</c:when>
					<c:otherwise>
						<td>
							${oaFee.eaddr}
						</td>
					</c:otherwise>
				</c:choose>
				<td>
					${oaFee.totalcash}
				</td>
				<c:choose>
					<c:when test="${oaFee.feecat=='QT'}">
					</c:when>
					<c:when test="${oaFee.feecat=='ZD'}">
					</c:when>
					<c:otherwise>
						<td>
							${oaFee.projectid}
						</td>
					</c:otherwise>
				</c:choose>
				<td>
					${fns:getDictLabel(oaFee.state, 'flowstatus', '')}
				</td>
				<shiro:hasPermission name="oafee:oaFee:edit"><td>
    				<a href="${ctx}/oafee/oaFee/form?feeid=${oaFee.feeid}" onclick="if('${oaFee.state}'!='save'&&'${oaFee.state}'!='refuse'){alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">修改</a>
					<a href="${ctx}/oafee/oaFee/delete?feeid=${oaFee.feeid}" onclick="if('${oaFee.state}'=='save'||'${oaFee.state}'=='refuse'){return confirmx('确认要删除该费用吗？', this.href);}else{alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>