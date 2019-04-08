<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>出差申请管理</title>
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
		<li class="active"><a href="${ctx}/oabustrip/oaBusitrip/">出差申请列表</a></li>
		<shiro:hasPermission name="oabustrip:oaBusitrip:edit"><li><a href="${ctx}/oabustrip/oaBusitrip/form">出差申请添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaBusitrip" action="${ctx}/oabustrip/oaBusitrip/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>申请时间：</label>
				<input name="beginApplytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaBusitrip.beginApplytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
				<input name="endApplytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${oaBusitrip.endApplytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>出差申请单号</th>
				<th>申请时间</th>
				<th>申请人</th>
				<th>出发地点</th>
				<th>目的地</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>出差天数</th>
				<th>相关项目</th>
				<th>审批状态</th>
				<shiro:hasPermission name="oabustrip:oaBusitrip:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaBusitrip">
			<tr>
				<td><a href="${ctx}/oabustrip/oaBusitrip/form?busitripid=${oaBusitrip.busitripid}&tag=view">
					${oaBusitrip.tripnum}
				</a></td>
				<td>
					<fmt:formatDate value="${oaBusitrip.applytime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${oaBusitrip.applyperson}
				</td>
				<td>
					${oaBusitrip.startaddr}
				</td>
				<td>
					${oaBusitrip.endaddr}
				</td>
				<td>
					<fmt:formatDate value="${oaBusitrip.startdate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${oaBusitrip.enddate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${oaBusitrip.tripdays}
				</td>
				<td>
					${oaBusitrip.relatedpro}
				</td>
				<td>
					${fns:getDictLabel(oaBusitrip.nextnode, 'flowstatus', '')}
				</td>
				<shiro:hasPermission name="oabustrip:oaBusitrip:edit"><td>
    				<a href="${ctx}/oabustrip/oaBusitrip/form?busitripid=${oaBusitrip.busitripid}" onclick="if('${oaBusitrip.nextnode}'!='save'&&'${oaBusitrip.nextnode}'!='refuse'){alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">修改</a>
					<a href="${ctx}/oabustrip/oaBusitrip/delete?busitripid=${oaBusitrip.busitripid}" onclick="if('${oaBusitrip.nextnode}'=='save'||'${oaBusitrip.nextnode}'=='refuse'){return confirmx('确认要删除该请休假申请吗？', this.href);}else{alert('温馨提示：该记录已提交或已审批，不能执行此操作！');return false;}">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>