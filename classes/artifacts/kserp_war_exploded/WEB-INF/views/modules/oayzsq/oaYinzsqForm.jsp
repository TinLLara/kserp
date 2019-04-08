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
	String userzhname = currentUser.getName();
	String goffice = (currentUser.getOffice()).toString();
%>
<head>
	<title>印章申请管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			initType();
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
		 
	 	function setNextOper(clickObjectName,clickObjectId,oid,oname) {
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
	    
	    function choiceFinance(clickObjectName,clickObjectId){
			 var url = '${ctx}/oafinorg/oaMoneyCompany/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		 
	 	function setFinance(clickObjectName,clickObjectId,oid,oname) {
	   		document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
	    };
	    
	    function clearUp(){
	    	document.getElementById('project').value="";	
	    	document.getElementById('projectname').value="";
	    };
	    
	    function choicepro(clickObjectName,clickObjectId){
	    	var url = '${ctx}/oaproject/busProject/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		
		function setChoiseProj(clickObjectName,clickObjectId,oid,oname) {
			document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
	    };
	    
	    function initType(){
		    var type = '${oaYinzsq.type}';
		    var types = document.getElementsByName('type');
	        for(var i=0;i<types.length;i++){
	           var ev = types[i].value;         
	           if(type.indexOf(ev)!=-1){
	              types[i].checked = true;
	           }
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
		<li><a href="${ctx}/oayzsq/oaYinzsq/">印章申请列表</a></li>
		<li class="active"><a href="${ctx}/oayzsq/oaYinzsq/form?id=${oaYinzsq.id}">印章申请<shiro:hasPermission name="oayzsq:oaYinzsq:edit">${not empty oaYinzsq.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="oayzsq:oaYinzsq:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaYinzsq" action="${ctx}/oayzsq/oaYinzsq/save?submit=${not empty oaYinzsq.id?'update':'insert'}" method="post" class="form-horizontal">
		<%-- <form:hidden path="id"/> --%>
		<c:choose>
			<c:when test="${not empty oaYinzsq.id}">
				<form:hidden path="id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=gemid %>" style="border:0px;" readonly="readonly" name="id" id="id" class="input-medium " />
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaYinzsq.id}">
				<form:hidden path="creator" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=username %>" style="border:0px;" readonly="readonly" name="creator" id="creator" class="input-medium " />
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaYinzsq.id}">
				<form:hidden path="creatdate" htmlEscape="false" maxlength="32" class="input-medium "/>
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=date %>" name="creatdate" id="creatdate" class="input-medium " />
			</c:otherwise>
		</c:choose>
		<sys:message content="${message}"/>		
		<%-- <div class="control-group">
			<label class="control-label">起草人：</label>
			<div class="controls">
				<form:input path="appname" htmlEscape="false" maxlength="256" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">起草时间：</label>
			<div class="controls">
				<form:input path="appdate" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所在部门：</label>
			<div class="controls">
				<form:input path="depart" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用印份数：</label>
			<div class="controls">
				<form:input path="yynum" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用章类型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('oayzlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司名称：</label>
			<div class="controls">
				<form:input path="corpname" htmlEscape="false" maxlength="500" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件名或用途：</label>
			<div class="controls">
				<form:input path="fileormeno" htmlEscape="false" maxlength="4000" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件名称：</label>
			<div class="controls">
				<form:input path="filename" htmlEscape="false" maxlength="500" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件id：</label>
			<div class="controls">
				<form:input path="fileid" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">意见：</label>
			<div class="controls">
				<form:input path="advice" htmlEscape="false" maxlength="4000" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">抄送人：</label>
			<div class="controls">
				<form:input path="mailcopier" htmlEscape="false" maxlength="4000" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建人：</label>
			<div class="controls">
				<form:input path="creator" htmlEscape="false" maxlength="256" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间：</label>
			<div class="controls">
				<form:input path="creatdate" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关联事件：</label>
			<div class="controls">
				<form:input path="event" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关联项目：</label>
			<div class="controls">
				<form:input path="project" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下一处理环节：</label>
			<div class="controls">
				<form:input path="nextop" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下一处理人：</label>
			<div class="controls">
				<form:input path="nextoper" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否回执：</label>
			<div class="controls">
				<form:input path="comeon" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">推送流程状态：</label>
			<div class="controls">
				<form:select path="appresult" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('flowstatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		
		<table id="jihuaTable" border="0" cellpadding="5" style="align:center;text-align:left;width:80%;" class="content_table">	
		 <caption align="center"><h3>印章申请</h3></caption>
		  <tr>
			<td class='content_index' align="right">起草人</td>
			<td class='content_body'>
				<c:choose>
					<c:when test="${not empty oaYinzsq.id}">
						<form:input path="appname" htmlEscape="false" maxlength="256" class="input-medium "/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=userzhname %>" name="appname" id="appname" class="input-medium " />
					</c:otherwise>
				</c:choose>
			</td>
			<td class='content_index' align="right">起草时间</td>
			<td class='content_body'>
				<c:choose>
					<c:when test="${not empty oaYinzsq.id}">
						<form:input path="appdate" htmlEscape="false" maxlength="32" class="input-medium "/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=date %>" name="appdate" id="appdate" class="input-medium " />
					</c:otherwise>
				</c:choose>
			</td>
		  </tr>
		  <tr>
			<td class='content_index' align="right">所在部门</td>
			<td class='content_body'>
				
				<c:choose>
					<c:when test="${not empty oaYinzsq.id}">
						<form:input path="depart" htmlEscape="false" maxlength="100" class="input-medium "/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=goffice %>" name="depart" id="depart" class="input-medium " />
					</c:otherwise>
				</c:choose>
			</td>
			<td class='content_index' align="right">用印份数</td>
			<td class='content_body'><form:input path="yynum" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</td>
		  </tr>	
		  <tr>
		    <td class='content_index' align="right">公司名称(<font color="red">*</font>)</td>
		    <td  class="content_body">
				<input type="hidden" id="corpname" name="corpname"/>	
				<input type="text" id="corpnametext" name="corpnametext" value="${oaYinzsq.corpname }" style="width:315px;" readonly="readonly"  />
				<A onclick="choiceFinance('corpnametext','corpname');" style="cursor:pointer;"><IMG id="fan" src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A>
			</td>
			<td class="content_index" align="right">关联项目</td>
		    <td class="content_body">
		    	<input id="project" name="project" type="hidden" class="input-xlarge "/>
		        <input id="projectname" name="projectname" type="text" value="${oaYinzsq.project }" readonly="readonly"/>&nbsp;&nbsp;<A onclick="choicepro('projectname','project');"
					style="cursor:pointer;"><IMG id="fan"
					src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A>&nbsp;&nbsp;<a onclick="clearUp();" style="text-decoration:underline;cursor: pointer;">清空</a>
		    </td>		
		  </tr>		
		  <tr> 
		    <td class='content_index' align="right">印章类型(<font color='red'>*</font>)</td>
			  <td align="left" class="content_body">
		       <input name="type" id="type" type="checkbox" value="gz" />公章
		       <input name="type" id="type" type="checkbox" value="cw" />财务章
		       <input name="type" id="type" type="checkbox" value="fr" />法人签章
		       <input name="type" id="type" type="checkbox" value="qt" />其他
		    </td>
		    <td align="right" class="content_index">关联事件</td>
		    <td align="left" class="content_body">
				<%-- <form:input path="event" htmlEscape="false" maxlength="100" class="input-xlarge required"/> --%>
				<form:select path="event" htmlEscape="false" maxlength="16" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('eventtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
		    </td>
		  </tr>  
		  <tr >
			<td class='content_index' align="right">印章用途</td>
			<td class='content_body' colspan="3">
				<form:textarea path="fileormeno" htmlEscape="false" cssStyle="width:82%;height:150px;" maxlength="4000" ></form:textarea>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
		  </tr>	
		  <tr>
			<td class='content_index' align="right">下一处理人</td>
			<td class='content_body' ><input name="nextOper1" id="nextOper1" value="" type="text" readonly="readonly" style="border:0px;color: red;"/>
		    <%-- <form:input path="nextoper" htmlEscape="false" maxlength="32" class="input-xlarge "/> --%><a href="javascript:choiceNextOper('nextOper1','nextoper');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人</span></a>
			<input name="nextoper" id="nextoper" value="" type="hidden" />
			</td>
			<td class='content_index' align="right">抄送人</td>
			<td class='content_body' >
				<input name="copyer1" id="copyer1" value="" type="text" readonly="readonly" style="border:0px;color: red;"/>
		    <%-- <form:input path="mailcopier" htmlEscape="false" maxlength="4000" class="input-xlarge "/> --%><a href="javascript:choiceNextOper('copyer1','mailcopier');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人</span></a>
			<input name="mailcopier" id="mailcopier" value="" type="hidden"/>
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
<!-- 		  <tr>
			<td class='content_index' align="right">附件信息</td>
			<td class='content_body' colspan="3">
				<br><br>提示:每次保存附件大小不能超过<font color="red">50M</font>.	
			</td>
		  </tr>		
 -->		</table> 
		<c:choose>
			<c:when test="${tagvalue eq 'view'}">
				<div class="form-actions">
					<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:when>
			<c:otherwise>
				<div class="form-actions">
					<shiro:hasPermission name="oayzsq:oaYinzsq:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
					<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:otherwise>
		</c:choose>
		<%-- <div class="form-actions">
			<shiro:hasPermission name="oayzsq:oaYinzsq:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div> --%>
	</form:form>
</body>
</html>