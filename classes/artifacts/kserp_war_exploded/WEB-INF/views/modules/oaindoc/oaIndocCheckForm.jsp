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
%>
<head>
	<title>内部公函管理</title>
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
	    
	    function choicepro(clickObjectName,clickObjectId){
	    	var url = '${ctx}/oaproject/busProject/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		
		function setChoiseProj(clickObjectName,clickObjectId,oid,oname) {
			document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
	    };
	    
		function doRefuse(){
			
			if(checkRemark()){
				var remark = document.getElementById('remark').value;
				var nextnoder = document.getElementById('indocnextoper').value;
				if(nextnoder!='${oaIndoc.indoccreator}'){
					alert("温馨提示：请选择申请者作为下一处理人，然后拒绝。");
					return;
				}
				var id = '${oaIndoc.indocid}';
				//var url = '${ctx}'+"/holi/oaHolidayapply/check?tag=refuse&remark="+encodeURIComponent(remark)+'&id='+happlyid;
				var url = '${ctx}'+"/oaindoc/oaIndoc/check?tag=refuse&indocid="+id+"&remark="+remark;
				url = encodeURI(url);
				url = encodeURI(url);
				window.location = url;
			}
			else
				return;
		}
		
		function checkRemark(){
			var remark = document.getElementById("remark").value;
			if(remark==null||remark==""){
				alert("请填写审批意见！");
				return false;
			}
			else
				return true;
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
		<li><a href="${ctx}/oaindoc/oaIndoc/listforcheck">内部公函列表</a></li>
		<li class="active"><a href="${ctx}/oaindoc/oaIndoc/formforcheck?indocid=${oaIndoc.indocid}">内部公函<shiro:hasPermission name="oaindoc:oaIndoc:edit">${not empty oaIndoc.indocid?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="oaindoc:oaIndoc:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaIndoc" action="${ctx}/oaindoc/oaIndoc/check?tag=pass" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<c:choose>
			<c:when test="${not empty oaIndoc.indocid}">
				<form:hidden path="indocid" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=gemid %>" style="border:0px;" readonly="readonly" name="indocid" id="indocid" class="input-medium " />
			</c:otherwise>
		</c:choose>
		
		<table border="0" cellpadding="5" style="align:center;text-align:left;width:80%;" class="content_table">
		  <caption align="center"><h3>内部公函</h3></caption>
		  <tr>
		    <td align="right" class="content_index">标题</td>
		    <td align="left" class="content_body" colspan="3"><input type="text" disabled="disabled" name="indocname" value="${oaIndoc.indocname }" id="indocname" class="input-xxlarge required" /><span class="help-inline"><font color="red">*</font> </span></td>	   
		  </tr>
		  <tr>
		    <td align="right" class="content_index">呈文部门.单位</td>
		    <td align="left" class="content_body">
		    	<c:choose>
					<c:when test="${not empty oaIndoc.indocid}">
						<form:input path="indoccode" htmlEscape="false" maxlength="64" class="input-medium " disabled="true"/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=goffice %>" style="border:0px;" readonly="readonly" name="indoccode" id="indoccode" class="input-medium " />
					</c:otherwise>
				</c:choose>
		    </td>
		    <td width="10%" align="right" class="content_index" style="border-top:1px solid #dcdcdc;">呈文日期</td>
		    <td align="left" class="content_body" style="border-top:1px solid #dcdcdc;color:blue;"><input name="indoccdate" disabled="disabled" type="text" id="indoccdate" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${oaIndoc.indoccdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/><span class="help-inline"><font color="red">*</font> </span></td>
		  </tr>
		  <tr>
		    <td align="right" class="content_index">拟稿人</td>
		    <td align="left" class="content_body">
			    <c:choose>
					<c:when test="${not empty oaIndoc.indocid}">
						<form:input path="indoccreator" htmlEscape="false" maxlength="32" class="input-medium " disabled="true"/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=username %>" style="border:0px;" readonly="readonly" name="indoccreator" id="indoccreator" class="input-medium " />
					</c:otherwise>
				</c:choose>
			</td>
		    <td align="right" class="content_index">电话</td>
		    <td align="left" class="content_body">
		    	<c:choose>
					<c:when test="${not empty oaIndoc.indocid}">
						<form:input path="indocmobile" htmlEscape="false" maxlength="32" class="input-medium " disabled="true"/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=gtel %>" style="border:0px;" readonly="readonly" name="indocmobile" id="indocmobile" class="input-medium " />
					</c:otherwise>
				</c:choose>
		    </td>
		  </tr>
		  <tr>
		    <td align="right" class="content_index">密级</td>
		    <td align="left" class="content_body"><%-- <form:input path="indocsec" htmlEscape="false" maxlength="32" class="input-xlarge required"/> --%>
		    	<form:select path="indocsec" htmlEscape="false" maxlength="16" class="input-medium" disabled="true">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('oasec')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select><span class="help-inline"><font color="red">*</font> </span></td>
		    <td align="right" class="content_index">缓级</td>
		    <td align="left" class="content_body"><%-- <form:input path="indocstate" htmlEscape="false" maxlength="32" class="input-xlarge required"/> --%>
		    	<form:select path="indocstate" htmlEscape="false" maxlength="16" class="input-medium" disabled="true">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('oastate')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select><span class="help-inline"><font color="red">*</font> </span></td>
		  </tr>
		   <tr>
		    <td align="right" class="content_index">关联项目</td>
		    <td align="left" class="content_body">
		     <input type="hidden" id='projid' name='projid' />
		     <input id="indocproject" name="indocproject" value="" type="text"  readonly="readonly" style="width:205px;"/><%-- &nbsp;&nbsp;<A onclick="choicepro('indocproject','projid');"
					style="cursor:pointer;"><IMG id="fan"
					src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A>&nbsp;&nbsp;<A id="pjoimg" onclick="canclText('pjoimg')"
					style="cursor:pointer;visibility: hidden"><IMG 
					src="${pageContext.request.contextPath}/images/cancel.gif" /></A> --%>
		    </td>
		    <td align="right" class="content_index">关联事件</td>
		    <td align="left" class="content_body">
				<!-- <emp:select id="OaIndoc.indocevent" label="事件类型" dictname="eventtype" required="true"  /> -->
				<%-- <form:input path="indocevent" htmlEscape="false" maxlength="100" class="input-xlarge required"/> --%>
				<form:select path="indocevent" htmlEscape="false" maxlength="16" class="input-medium" disabled="true">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('eventtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
		    </td>
		  </tr>
		   <tr>
		    <td align="right" class="content_index">正文(<font color='red'>*</font>)</td>
		    <td class="content_body" colspan="3">
		    <div>
		    	<form:textarea path="indoccontent" htmlEscape="false" maxlength="4000" cssStyle="width:82%;height:150px;" class="input-xlarge required" disabled="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
		    </div>
		    </td>   	    
		  </tr>

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
		  <tr>
		    <td align="right" class="content_index" nowrap="nowrap">下一处理人</td>
		    <td align="left" class="content_body">
		    <div>
		    <table><tr><td nowrap="nowrap" >
		    <input name="nextOper1" id="nextOper1" value="" type="text" readonly="readonly" style="border:0px;color: red;"/>
		    <a href="javascript:choiceNextOper('nextOper1','indocnextoper');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人>></span></a>&nbsp;
		    <input name="indocnextoper" id="indocnextoper" value="" type="hidden" />
		    </td></tr></table>
		    </div>
		    </td>   
		    <td align="right" class="content_index"></td>
		    <td align="left" class="content_body" colspan="3">
		    <%-- <input name="copyer1" id="copyer1" value="" type="text" readonly="readonly" style="border:0px;color: red;"/>
		    <a href="javascript:choiceNextOper('copyer1','indocmailcopier');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人>></span></a>&nbsp;
		     <input name="indocmailcopier" id="indocmailcopier" value="" type="hidden"/> --%>
		    </td>   
		  </tr>
		  <tr style="display: none;">
		    <td align="right" class="content_index"></td>
		    <td align="left" class="content_body">
		      <input name="recall" id="recall" type="hidden" value="yes" />
		    </td>
		  </tr>
		 <%--  <tr>
		    <td align="right" class="content_index">附件信息</td>
		    <td align="left" class="content_body" colspan="3">
		       	<form:hidden id="indocAdvice" path="indocAdvice" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
				<sys:ckfinder input="indocAdvice" type="indocAdvice" uploadPath="/InternalLetters" selectMultiple="true" maxWidth="100" maxHeight="100"/>
				<br><br>提示:每次保存附件大小不能超过<font color="red">50M</font>.	   
		    </td>
		  </tr> --%>
		   <tr>
			<td class='content_index' align="right">审批意见</td>
			<td class='content_body' colspan="3">
			    <textarea id="remark" name="remark" class="required" style="width:85%;"></textarea>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
		  </tr>
		</table>
		<c:choose>
			<c:when test="${tagvalue eq 'view'}">
				<div class="form-actions">
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:when>
			<c:otherwise>
				<div class="form-actions">
					<shiro:hasPermission name="oaindoc:oaIndoc:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>&nbsp;</shiro:hasPermission>
					<shiro:hasPermission name="oaindoc:oaIndoc:edit"><input id="refuse" class="btn btn-primary" type="button" value="拒 绝" onclick="doRefuse();"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:otherwise>
		</c:choose>
	</form:form>
</body>
</html>