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
        };
        
        function doSelect(busitripid,startaddr,endaddr,startdate,enddate,tripnum,tripreason,tripdays,relatedpro){
        	var contname = "(从"+startdate+"至"+enddate+") "+startaddr+">>"+endaddr+"["+tripnum+"]";
		    window.opener.setList(busitripid, contname,startaddr,endaddr,startdate,enddate,relatedpro,tripdays,tripreason);
		    window.close();
        };
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oabustrip/oaBusitrip/listforselect">出差申请列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="oaBusitrip" action="${ctx}/oabustrip/oaBusitrip/listforselect" method="post" class="breadcrumb form-search">
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
				<td>
					${oaBusitrip.tripnum}
				</td>
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
				<td>
					<a  onclick="doSelect('${oaBusitrip.busitripid}','${oaBusitrip.startaddr}','${oaBusitrip.endaddr}','${oaBusitrip.startdate}','${oaBusitrip.enddate}','${oaBusitrip.tripnum}','${oaBusitrip.tripreason}','${oaBusitrip.tripdays}','${oaBusitrip.relatedpro}');" style="cursor: pointer;">选取</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>