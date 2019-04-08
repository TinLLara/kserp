<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@page import="com.szcxsl.oa.common.utils.IdGen"%>
<%
	String gemid = IdGen.uuid();
%>
<html>
<head>
	<title>财务组织管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oafinorg/oaMoneyCompany/">财务组织列表</a></li>
		<li class="active"><a href="${ctx}/oafinorg/oaMoneyCompany/form?companyid=${oaMoneyCompany.companyid}">财务组织<shiro:hasPermission name="oafinorg:oaMoneyCompany:edit">${not empty oaMoneyCompany.companyid?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="oafinorg:oaMoneyCompany:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaMoneyCompany" action="${ctx}/oafinorg/oaMoneyCompany/save?submit=${not empty oaMoneyCompany.companyid?'update':'insert'}" method="post" class="form-horizontal">
		<c:choose>
			<c:when test="${not empty oaMoneyCompany.companyid}"> 
				<form:hidden path="companyid"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=gemid %>" name="companyid" id="companyid" />
			</c:otherwise>
		</c:choose>
		
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">公司名称：</label>
			<div class="controls">
				<form:input path="compname" htmlEscape="false" maxlength="128" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">简称：</label>
			<div class="controls">
				<form:input path="nativename" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">简介：</label>
			<div class="controls">
				<form:textarea path="region" htmlEscape="false" rows="4" maxlength="64" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="oafinorg:oaMoneyCompany:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>