<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@page import="com.szcxsl.oa.common.utils.DateUtils"%>
<%@page import="com.szcxsl.oa.modules.sys.utils.UserUtils"%>
<%@page import="com.szcxsl.oa.modules.sys.entity.User"%>
<%@page import="com.szcxsl.oa.common.utils.IdGen"%>
<html>
<%
	String date = DateUtils.getDate();
	String gemid = IdGen.uuid();
	User currentUser = UserUtils.getUser();
	String username = currentUser.getLoginName();
	String gtel = currentUser.getMobile();
	String goffice = (currentUser.getOffice()).toString();
	String gnumber = currentUser.getNo();
	String gemail = currentUser.getEmail();
	/*Context context = (Context) request.getAttribute(EMPConstance.ATTR_CONTEXT);
	String yearh = context.getDataValue("yearh").toString();
	String illh = context.getDataValue("illh").toString();
	String yused = context.getDataValue("yused").toString();
	String iused = context.getDataValue("iused").toString();*/
%>
<head>
	<title>出差申请管理</title>
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
		
		function choiceNextOper(clickObjectName,clickObjectId){
			 var url = '${ctx}/sys/user/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		
		function choiceNameNum(clickObjectName,clickObjectId,setObjectName){
			 var url = '${ctx}/sys/user/listforselectnum?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId+'&setObjectName='+setObjectName;		
			 openWin(url,'',800,550);
		};
		 
	 	function setNextOper(clickObjectName,clickObjectId,oid,oname) {
	   		document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
	    };
	    
	    function setNameNumber(clickObjectName,clickObjectId,setObjectName,oid,oname,num) {
	   		document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
	   		document.getElementById(setObjectName).value=num;
	    };
	    
	    function choicepro(clickObjectName,clickObjectId){
	    	var url = '${ctx}/oaproject/busProject/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		
		function setChoiseProj(clickObjectName,clickObjectId,oid,oname) {
			document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
	    };
	    
	    function openWin(u,param, w, h) {
	        var l = (screen.width - w) / 2;
	        var t = (screen.height - h-80) / 2;
	        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l;
	        s += ', toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no,titlebar=no,directories=no';
	        window.open(u, param, s); 
	    };
	    
	    	    
	    function countDays(){
			var begin = document.getElementById('startdate').value;
			var end = document.getElementById('enddate').value;
			var beginH = document.getElementById('starthour').value;
			var endH = document.getElementById('endhour').value;
			
			if(begin!=null && begin!='' && end!=null && end!=''){
				var bVar = begin.split('-');
				var eVar = end.split('-');
				var bnewDate = new Date(bVar[0],bVar[1],bVar[2]); 
				var enewDate = new Date(eVar[0],eVar[1],eVar[2]);
				count = enewDate - bnewDate;
				/*if(count<0){
					alert('起始时间必须小于结束时间！');
					return;
				}*/
				var h2d;
				var count2;
				count2 = endH-beginH;
				if(count2==0 ){
					h2d = 0.5;
				}
				else if(count2>0){
					h2d = 1;
				}
				else{
					h2d = -0.5;
				}
				
				document.getElementById('tripdays').value=count/(24*60*60*1000)+h2d;
			} 
	    	
		};
		
		function printer(){
		  	document.execCommand("Print");
		  	return false;
		};
	</script>
	<style type="text/css">
	 TABLE
	{
	    font-family: verdana;
		font-size: 12px;
		cursor: default;
		border-collapse: collapse;
	}
	TH {
		FONT-SIZE: 9pt;
		font-family: verdana;
	}
	TR {
	}
	td
	{
		font-size:12px;
		font-family:Verdana, Arial, Helvetica, sans-serif;
	}
	.content_index
	{	
		background-color: #f7f8fd;
		line-height: 20px;
		border-bottom:1px solid #dcdcdc;
		border-left:1px solid #dcdcdc;
		padding: 5px;
	    color:black;
		}
	.content_table
	{
		border-top:5px solid #dcdcdc;
		border-bottom:1px solid #dcdcdc;
		border-left:1px solid #dcdcdc;
		border-right:1px solid #dcdcdc;
		border:1px solid #dcdcdc;
		padding: 5px;
		}
	.content_body
	{	
		background-color:#ffffff;
		border-bottom:1px solid #dcdcdc;
		border-left:1px solid #dcdcdc;
		border-right:1px solid #dcdcdc;
		padding:5px;
		}
	.content_title                                              
		{                                                           
			/*background-color:#d2e3f6;*/                             
			line-height: 25px;                                                                            
			padding-left:10px;                                        
			/*background-image:url("images/sor_header2.png");  */  
			border-bottom:1px solid #dcdcdc;                          
			}                                                         
		.content_title td                                           
		{                                                           
			background-color:floralwhite;                                                                  
		/*	background-image:url("images/sor_header2.png");  */
			border-bottom:1px solid #dcdcdc;                          
		 }
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oabustrip/oaBusitrip/">出差申请列表</a></li>
		<li class="active"><a href="${ctx}/oabustrip/oaBusitrip/form?busitripid=${oaBusitrip.busitripid}">出差申请<shiro:hasPermission name="oabustrip:oaBusitrip:edit">${not empty oaBusitrip.busitripid?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="oabustrip:oaBusitrip:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaBusitrip" action="${ctx}/oabustrip/oaBusitrip/save?submit=${not empty oaBusitrip.busitripid?'update':'insert'}" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		
		<c:choose>
			<c:when test="${not empty oaBusitrip.busitripid}">
				<form:hidden path="busitripid" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" id="busitripid" name="busitripid" value="<%=gemid %>" maxlength="32" class="input-xlarge required"  />
			</c:otherwise>
		</c:choose>
		<sys:message content="${message}"/>		
		<%-- <div class="control-group">
			<label class="control-label">出差申请单号：</label>
			<div class="controls">
				<form:input path="tripnum" htmlEscape="false" maxlength="16" class="input-medium required" readonly="readonly"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">出差申请ID：</label>
			<div class="controls">
				<form:input path="busitripid" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		
		<%-- <c:choose>
			<c:when test="${not empty oaBusitrip.busitripid}">
				<form:hidden path="busitripid" htmlEscape="false" maxlength="32" class="input-xlarge required" />
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=gemid %>" name="busitripid" id="busitripid" class="input-medium required" />
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaBusitrip.busitripid}">
				<div class="control-group">
					<label class="control-label">申请时间：</label>
					<div class="controls">
						<input name="applytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							value="<fmt:formatDate value="${oaBusitrip.applytime}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
						<span class="help-inline"><font color="red">*</font> </span>
				</div>
		</div>
		</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">申请时间：</label>
					<div class="controls">
						<input type="text" value="<%=date %>" name="applytime" id="applytime" class="input-medium required" readonly="readonly"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</c:otherwise>
		</c:choose> --%>
		<%-- <div class="control-group">
			<label class="control-label">申请人：</label>
			<div class="controls">
				<form:input path="applyperson" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		
		<%-- <c:choose>
			<c:when test="${not empty oaBusitrip.busitripid}">	
				<div class="control-group">
					<label class="control-label">申请人：</label>
					<div class="controls">
						<form:input path="applyperson" htmlEscape="false" maxlength="64" class="input-medium required" readonly="true"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</c:when>
		<c:otherwise>
				<div class="control-group">
					<label class="control-label">申请人：</label>
					<div class="controls">
						<input type="text" value="<%=username %>" name="applyperson" id="applyperson" class="input-medium required" readonly="readonly"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</c:otherwise>
		</c:choose> --%>
		
		<%-- <div class="control-group">
			<label class="control-label">所属部门：</label>
			<div class="controls">
				<form:input path="belongdept" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		
		<%-- <c:choose>
			<c:when test="${not empty oaBusitrip.busitripid}">
				<div class="control-group">
					<label class="control-label">联系电话：</label>
					<div class="controls">
						<form:input path="urgenttel" htmlEscape="false" maxlength="32" class="input-medium "/>
					</div>
				</div>
		</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">联系电话：</label>
					<div class="controls">
						<input type="text" value="<%=gtel %>" name="urgenttel" id="urgenttel"  class="input-medium"/>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaBusitrip.busitripid}">
				<div class="control-group">
					<label class="control-label">所属部门：</label>
					<div class="controls">
						<form:input path="belongdept" htmlEscape="false" maxlength="256" class="input-medium required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
		</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">所属部门：</label>
					<div class="controls">
						<input type="text" value="<%=goffice %>" name="belongdept" id="belongdept" class="input-medium required" readonly="readonly"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</c:otherwise>
		</c:choose> --%>
		
		<%-- <div class="control-group">
			<label class="control-label">员工编号：</label>
			<div class="controls">
				<form:input path="staffnum" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">出发地点：</label>
			<div class="controls">
				<form:input path="startaddr" htmlEscape="false" maxlength="64" class="input-medium required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目的地：</label>
			<div class="controls">
				<form:input path="endaddr" htmlEscape="false" maxlength="64" class="input-medium required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间：</label>
			<div class="controls">
				<input name="startdate" id="startdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaBusitrip.startdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				<input name="enddate" id="enddate" type="text" readonly="readonly" maxlength="20" onmouseout="countDays();" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaBusitrip.enddate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间(上午/下午)：</label>
			<div class="controls">
				<form:input path="starthour" htmlEscape="false" maxlength="16" class="input-xlarge "/>
				<form:select path="starthour" htmlEscape="false" onchange="countDays();" maxlength="16" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" onmouseout="countDays();" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间(上午/下午)：</label>
			<div class="controls">
				<form:input path="endhour" htmlEscape="false" maxlength="16" class="input-xlarge "/>
				<form:select path="endhour" htmlEscape="false" onchange="countDays();" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差天数：</label>
			<div class="controls">
				<form:input path="tripdays" htmlEscape="false" maxlength="11" class="input-mini required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">相关项目：</label>
			<div class="controls">
				<form:input path="relatedpro" onclick="countDays();" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作代理人：</label>
			<div class="controls">
				<form:input path="workhelper" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">代理人电话：</label>
			<div class="controls">
				<form:input path="contactstyle" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差原因：</label>
			<div class="controls">
				<form:textarea path="tripreason" htmlEscape="false" maxlength="2000" class="input-xlarge "/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">币种：</label>
			<div class="controls">
				<form:input path="currency" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预支现金：</label>
			<div class="controls">
				<form:input path="cashadvance" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预支现金大写：</label>
			<div class="controls">
				<form:input path="cashadvancech" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div> --%>
		
		<%-- <div class="control-group">
			<label class="control-label">下一处理环节：</label>
			<div class="controls">
				<form:input path="nextnode" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">下一处理人：</label>
			<div class="controls">
				<form:input path="nextnoder" htmlEscape="false" maxlength="32" class="input-xlarge "/>
				<input type="text" id="nextnoder" value="${oaBusitrip.nextnoder} " name="nextnoder"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
				&nbsp;<A href="javascript:choiceNextOper('nextnoder','operatorid');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人>></span></A>
				<input type="hidden" id="operatorid" name="operatorid" value=""  />
				<font color="red">*</font>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">抄送人：</label>
			<div class="controls">
				<input type="text" id="sendtoname" name="sendtoname"  maxlength="128" readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
				&nbsp;<A href="javascript:choiceNextOper('sendtoname','sendto');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人>></span></A>
				<input type="hidden" id="sendto" name="sendto" value=""  />
			</div>
		</div> 
		
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:hidden id="trifile" path="tripfile" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
				<sys:ckfinder input="trifile" type="files" uploadPath="/tripfiles" selectMultiple="true" maxWidth="100" maxHeight="100"/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">remarks：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div> --%>
		<%-- <c:choose>
			<c:when test="${tagvalue eq 'view'}">
				<div class="form-actions">
					<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:when>
			<c:otherwise>
				<div class="form-actions">
					<shiro:hasPermission name="oabustrip:oaBusitrip:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>&nbsp;</shiro:hasPermission>
					<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:otherwise>
		</c:choose> --%>
		
			<table  border="0" cellpadding="5" style="align:center;text-align:left;width:80%;" class="content_table">
		  <caption align="center"><h3>出差申请</h3></caption>
			<tr>
			<td class='content_index' align="right">申请人</td>
			<td class='content_body'>
				<c:choose>
					<c:when test="${not empty oaBusitrip.busitripid}">	
						<form:input path="applyperson" htmlEscape="false" maxlength="64" class="input-medium required" readonly="true"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=username %>" name="applyperson" id="applyperson" class="input-medium required" readonly="readonly"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</c:otherwise>
				</c:choose> 
			</td>
			<td class='content_index' align="right">申请时间</td>
			<td class='content_body'>
				<c:choose>
					<c:when test="${not empty oaBusitrip.busitripid}">
						<input name="applytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							value="<fmt:formatDate value="${oaBusitrip.applytime}" pattern="yyyy-MM-dd"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</c:when>
					<c:otherwise>
							<input type="text" value="<%=date %>" name="applytime" id="applytime" class="input-medium required" readonly="readonly"/>
							<span class="help-inline"><font color="red">*</font> </span>
					</c:otherwise>
				</c:choose>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">所属部门</td>
			<td class='content_body'>
				<c:choose>
					<c:when test="${not empty oaBusitrip.busitripid}">
						<form:input path="belongdept" htmlEscape="false" maxlength="256" class="input-medium required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=goffice %>" name="belongdept" id="belongdept" class="input-medium required" readonly="readonly"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</c:otherwise>
				</c:choose>
			</td>
			<td class='content_index' align="right">用户名</td>
			<td class='content_body'>
				<form:input path="staffnum" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">出发地点</td>
			<td class='content_body'>
				<form:input path="startaddr" htmlEscape="false" maxlength="64" class="input-medium required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class='content_index' align="right">目的地</td>
			<td class='content_body'>
				<form:input path="endaddr" htmlEscape="false" maxlength="64" class="input-medium required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">开始日期</td>
			<td class='content_body'>
				<input name="startdate" id="startdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaBusitrip.startdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class='content_index' align="right">结束日期</td>
			<td class='content_body'>
				<input name="enddate" id="enddate" type="text" readonly="readonly" maxlength="20" onmouseout="countDays();" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaBusitrip.enddate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">开始时间(上午/下午)</td>
			<td  class='content_body'>
				<form:select path="starthour" htmlEscape="false" onchange="countDays();" maxlength="16" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" onmouseout="countDays();" itemValue="value" htmlEscape="false"/>
				</form:select>
			</td>
			<td class='content_index' align="right">结束时间(上午/下午)</td>
			<td  class='content_body'>
				<form:select path="endhour" htmlEscape="false" onchange="countDays();" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</td>
			</tr>
			
			<tr>
			<td class='content_index' align="right">出差天数</td>
			<td class='content_body'>
				<form:input path="tripdays" htmlEscape="false" maxlength="11" class="input-mini required" readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class='content_index' align="right">相关项目</td>
			<td class='content_body'>
				<input type="hidden" id="relatedpro" name="relatedpro"/>	
				<input type="text" id="relatedproname" name="relatedproproname" style="width:205px;" readonly="readonly"  />
				<A onclick="choicepro('relatedproname','relatedpro');" style="cursor:pointer;"><IMG id="fan" src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A><font color="red">*</font>
			</td>
			</tr>
			<tr><td class='content_index' align="right">联系电话</td>
			<td class='content_body'>
				<c:choose>
				<c:when test="${not empty oaBusitrip.busitripid}">
					<form:input path="urgenttel" htmlEscape="false" maxlength="32" class="input-medium " readonly="true"/>
				</c:when>
				<c:otherwise>
					<input type="text" value="<%=gtel %>" name="urgenttel" id="urgenttel"  class="input-medium" readonly="readonly"/>
				</c:otherwise>
				</c:choose>
			</td>
			<td class='content_index' align="right">工作代理人</td>
			<td class='content_body'>
				&nbsp;<input type="text" id="workhelper" name="workhelper"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
				<A href="javascript:choiceNameNum('workhelper','workhelperid','contactstyle');" ><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/><span style="vertical-align: middle;">请选择工作代理人>></span></A>
				<input type="hidden" id="workhelperid" name="workhelperid" value=""  />
			</td>
			</tr>
			
			<tr><td class='content_index' align="right">代理人电话</td>
			<td class='content_body'>
				<form:input path="contactstyle" htmlEscape="false" maxlength="64" class="input-medium " readonly="true"/>
			</td>
			<td class='content_index' align="right"></td>
			<td class='content_body'>
				<%-- <form:input path="tripnum" htmlEscape="false" maxlength="16" class="input-medium required" readonly="readonly"/> --%>
			</td>
			</tr>
			
			<tr>
			<td class='content_index' align="right">出差原因</td>
			<td class='content_body' colspan="3">
				<form:textarea path="tripreason" htmlEscape="false" maxlength="2000" cssStyle="width:98%;" class="input-xlarge "/>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">下一处理人</td>
			<td class='content_body' >
			<input type="text" id="nextnoder" value="${oaBusitrip.nextnoder} " name="nextnoder"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
				&nbsp;<A href="javascript:choiceNextOper('nextnoder','operatorid');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人>></span></A>
				<input type="hidden" id="operatorid" name="operatorid" value=""  />
				<font color="red"><span style="vertical-align: middle;">*</span></font>
			</td>
			<td class='content_index' align="right">抄送人</td>
			<td class='content_body'>
			<input type="text" id="sendtoname" name="sendtoname"  maxlength="128" readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
				&nbsp;<A href="javascript:choiceNextOper('sendtoname','sendto');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人>></span></A>
				<input type="hidden" id="sendto" name="sendto" value=""  />
			</td>
			</tr>
			<c:choose>
			<c:when test="${tagvalue eq 'view'}">
				  <tr>
					<td class='content_index' align="right">审批流程</td>
					<td class='content_body' colspan="3">
						<table  border="0" cellpadding="5" style="align:center;text-align:center;width:100%;" class="content_table">
			            	<tr class="content_title"><td >审核人</td><td >审核状态</td><td >操作时间</td><td >审核内容</td></tr>
							<c:forEach items="${flowList}" var="OaFlow">
								<tr>
									<td class="content_body">
									${OaFlow.operator}
									</td>
									<td class="content_body">
										${fns:getDictLabel(OaFlow.flowState, 'flowstatus', '')}
									</td>
									<td class="content_body">
										${OaFlow.overTime}
									</td>
									<td class="content_body">
										${OaFlow.remark}
									</td>
								</tr>
							</c:forEach>	            
			            </table>
					</td>
				  </tr>	
		  	</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
			<tr>
			<td class='content_index' align="right">附件信息</td>
			<td class='content_body' colspan="3">
			    <form:hidden id="trifile" path="tripfile" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
				<sys:ckfinder input="trifile" type="files" uploadPath="/tripfiles" selectMultiple="true" maxWidth="100" maxHeight="100"/>
			</td>
		  </tr>		
			</table>
		 <c:choose>
			<c:when test="${tagvalue eq 'view'}">
				<div class="form-actions">
					<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:when>
			<c:otherwise>
				<div class="form-actions">
					<shiro:hasPermission name="oabustrip:oaBusitrip:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>&nbsp;</shiro:hasPermission>
					<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:otherwise>
		</c:choose>
	</form:form>
</body>
</html>