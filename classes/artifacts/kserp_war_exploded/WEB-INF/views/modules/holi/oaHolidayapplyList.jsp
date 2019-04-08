<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>请休假申请管理</title>
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
		<li class="active"><a href="${ctx}/holi/oaHolidayapply/">请休假申请列表</a></li>
		<shiro:hasPermission name="holi:oaHolidayapply:edit"><li><a href="${ctx}/holi/oaHolidayapply/form">请休假申请添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaHolidayapply" action="${ctx}/holi/oaHolidayapply/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>申请时间：</label>
				<input name="beginApplytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaHolidayapply.beginApplytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
				<input name="endApplytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaHolidayapply.endApplytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li><label>休假类型：</label>
				<form:select path="holidaytpye" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('holidaytype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>审批状态：</label>
				<form:select path="nextnode" class="input-medium">
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
				<th>休假类型</th>
				<th>起始时间</th>
				<th>结束时间</th>
				<th>天数</th>
				<th>审批状态</th>
				<shiro:hasPermission name="holi:oaHolidayapply:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaHolidayapply">
			<tr>
				<td><a href="${ctx}/holi/oaHolidayapply/formforcheck?happlyid=${oaHolidayapply.happlyid}&tag=view">
					${oaHolidayapply.applyperson}
				</a></td>
				<td>
					<fmt:formatDate value="${oaHolidayapply.applytime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(oaHolidayapply.holidaytpye, 'holidaytype', '')}
				</td>
				<td>
					<fmt:formatDate value="${oaHolidayapply.starttime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${oaHolidayapply.endtime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${oaHolidayapply.days}
				</td>
				<td>
					${fns:getDictLabel(oaHolidayapply.nextnode, 'flowstatus', '')}
				</td>
				<shiro:hasPermission name="holi:oaHolidayapply:edit"><td>
    				<a href="${ctx}/holi/oaHolidayapply/form?happlyid=${oaHolidayapply.happlyid}" onclick="if('${oaHolidayapply.nextnode}'!='save'&&'${oaHolidayapply.nextnode}'!='refuse'){alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">修改</a>
					<a href="${ctx}/holi/oaHolidayapply/delete?happlyid=${oaHolidayapply.happlyid}" onclick="if('${oaHolidayapply.nextnode}'=='save'||'${oaHolidayapply.nextnode}'=='refuse'){return confirmx('确认要删除该请休假申请吗？', this.href);}else{alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>