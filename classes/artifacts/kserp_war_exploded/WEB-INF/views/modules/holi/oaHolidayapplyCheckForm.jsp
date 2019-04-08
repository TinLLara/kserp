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
	<title>请休假申请管理</title>
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
	    
	    	    
	    function countDays(){
			var begin = document.getElementById('starttime').value;
			var end = document.getElementById('endtime').value;
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
				
				document.getElementById('days').value=count/(24*60*60*1000)+h2d;
			} 
	    	
		};
		
		function doRefuse(){
			
			if(checkRemark()){
				var remark = document.getElementById('remark').value;
				var nextnoder = document.getElementById('operatorid').value;
				if(nextnoder!='${oaHolidayapply.applyperson}'){
					alert("温馨提示：请选择申请者作为下一处理人，然后拒绝。");
					return;
				}
				var id = '${oaHolidayapply.happlyid}';
				//var url = '${ctx}'+"/holi/oaHolidayapply/check?tag=refuse&remark="+encodeURIComponent(remark)+'&id='+happlyid;
				var url = '${ctx}'+"/holi/oaHolidayapply/check?tag=refuse&happlyid="+id+"&remark="+remark;
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
		<li><a href="${ctx}/holi/oaHolidayapply/listforcheck">请休假审批列表</a></li>
		<li class="active"><a href="${ctx}/holi/oaHolidayapply/formforcheck?happlyid=${oaHolidayapply.happlyid}">请休假申请<shiro:hasPermission name="holi:oaHolidayapply:edit">${not empty oaHolidayapply.happlyid?'审批':'审批'}</shiro:hasPermission><shiro:lacksPermission name="holi:oaHolidayapply:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaHolidayapply" action="${ctx}/holi/oaHolidayapply/check?tag=pass" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="remarks" />
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.happlyid}">
				<form:hidden path="happlyid" htmlEscape="false" maxlength="32" class="input-xlarge required" />
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=gemid %>" name="happlyid" id="happlyid" class="input-medium required" readonly="readonly"/>
			</c:otherwise>
		</c:choose>
		
		<sys:message content="${message}"/>	
		
		<table  border="0" cellpadding="5" style="align:center;text-align:left;width:80%;" class="content_table">
		  <caption align="center"><h3>请休假申请</h3></caption>
		
			<tr>
			 <td class='content_index' align="right">申请人</td>
			<td  class='content_body'>
				<c:choose>
					<c:when test="${not empty oaHolidayapply.id}">	
						<form:input path="applyperson" htmlEscape="false" maxlength="16" class="input-medium required" readonly="true"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=username %>" name="applyperson" id="applyperson" class="input-medium required" readonly="readonly"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</c:otherwise>
				</c:choose>
			</td>
			<td class='content_index' align="right">申请时间</td>
			<td  class="content_body">
				<c:choose>
					<c:when test="${not empty oaHolidayapply.id}">
						<input name="applytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							value="<fmt:formatDate value="${oaHolidayapply.applytime}" pattern="yyyy-MM-dd"/>"
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
			<td  class='content_body'>
				<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<form:input path="belongdept" htmlEscape="false" maxlength="64" class="input-medium required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</c:when>
				<c:otherwise>
					<input type="text" value="<%=goffice %>" name="belongdept" id="belongdept" class="input-medium required" readonly="readonly"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</c:otherwise>
			</c:choose>
			</td>
			<td class='content_index' align="right">用户名</td>
			<td  class='content_body'>
				<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<form:input path="staffnum" htmlEscape="false" maxlength="32" class="input-medium" readonly="true"/>
			</c:when>
				<c:otherwise>
					<input type="text" value="<%=gnumber %>" name="staffnum" id="staffnum"  class="input-medium" readonly="readonly"/>
				</c:otherwise>
			</c:choose>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">联系电话</td>
			<td  class='content_body'>
				<c:choose>
					<c:when test="${not empty oaHolidayapply.id}">
						<form:input path="staffphone" htmlEscape="false" maxlength="16" class="input-medium " readonly="true"/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=gtel %>" name="staffphone" id="staffphone"  class="input-medium" readonly="readonly"/>
					</c:otherwise>
				</c:choose>
			</td>
			<td class='content_index' align="right">邮箱地址</td>
			<td class='content_body' >
				<c:choose>
					<c:when test="${not empty oaHolidayapply.id}">
						<form:input path="stafftel" htmlEscape="false" maxlength="64" class="input-medium" readonly="true"/>
					</c:when>
					<c:otherwise>
						<input type="text" value="<%=gemail %>" name="stafftel" id="stafftel"  class="input-medium" readonly="readonly"/>
					</c:otherwise>
				</c:choose>
			</td>
			</tr>
			<tr>
			
			<td class='content_index' align="right">起始日期</td>
			<td class='content_body'>
				<input type="text" name="starttime" id="starttime" maxlength="32" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaHolidayapply.starttime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class='content_index' align="right">结束日期</td>
			<td  class='content_body'>
				<input type="text" name="endtime" id="endtime" maxlength="32" onmouseout="countDays();" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaHolidayapply.endtime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			</tr>
			
				<tr>
			
			<td class='content_index' width="15%" align="right">开始时间(上午/下午)</td>
			<td  class='content_body' width="35%">
				<form:select path="starthour" htmlEscape="false" onchange="countDays();" maxlength="16" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" onmouseout="countDays();" itemValue="value" htmlEscape="false"/>
				</form:select>
			</td>
			<td class='content_index' width="15%" align="right">结束时间(上午/下午)</td>
			<td  class='content_body' width="35%">
				<form:select path="endhour" htmlEscape="false" onchange="countDays();" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">天数</td>
			<td class='content_body' >
				<form:input path="days" htmlEscape="false" maxlength="11" class="input-mini required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class='content_index' align="right">休假类型</td>
			<td  class='content_body'>
				<form:select path="holidaytpye" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('holidaytype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">当前休假情况</td>
			<td class='content_body' colspan="3" align="left">
			<pre>.AL-Annual Leave(享有年休假) 8天(已休)8天 (剩余)<font color="red">8</font>天
			<br />.IL-Ill Leave (享有病假)8天 (已休)8天 (剩余)<font color="red">8</font>天
			</pre>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">请休假原因</td>
			<td class='content_body' colspan="3">
				<form:textarea path="reason" onclick="countDays();" htmlEscape="false" cssStyle="width:98%;" maxlength="2000" class="input-xlarge "/>
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
			<td class='content_index' align="right">下一处理人</td>
			<td class='content_body' >
			<c:choose>
				<c:when test="${not empty oaHolidayapply.id}">
					<input type="text" id="nextnoder" value="${oaHolidayapply.nextnoder}"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
					&nbsp;<A href="javascript:choiceNextOper('nextnoder','operatorid');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>请选择处理人>></A>
					<input type="hidden" id="operatorid" name="operatorid" value=""  />
					<font color="red">*</font>
				</c:when>
				<c:otherwise>
					<input type="text" id="nextnoder" value="${oaHolidayapply.nextnoder} " name="nextnoder"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
					&nbsp;<A href="javascript:choiceNextOper('nextnoder','operatorid');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人>></span></A>
					<input type="hidden" id="operatorid" name="operatorid" value=""  />
					<font color="red">*</font>
				</c:otherwise>
			</c:choose>
			</td>
			<td class='content_index' align="right">抄送人</td>
			<td class='content_body'>
			<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<form:input path="sendto" htmlEscape="false" maxlength="128" class="input-medium"/>
			</c:when>
				<c:otherwise>
					<input type="text" id="sendtoname" name="sendtoname" value="${oaHolidayapply.sendto} " maxlength="128" readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
					&nbsp;<A href="javascript:choiceNextOper('sendtoname','sendto');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人>></span></A>
					<input type="hidden" id="sendto" name="sendto" value=""  />
				</c:otherwise>
			</c:choose>
			</td>
			</tr>
			<tr>
			<td class='content_index' align="right">附件信息</td>
			<td class='content_body' colspan="3">
			    <form:hidden id="holfile" path="holidayfile" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
				<sys:ckfinder input="holfile" type="files" uploadPath="/holidayfiles" selectMultiple="true" maxWidth="100" maxHeight="100"/>
			</td>
		  </tr>	
		  <tr>
			<td class='content_index' align="right">审批意见</td>
			<td class='content_body' colspan="3">
			    <textarea id="remark" name="remark" class="required" style="width:98%;" ></textarea>
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
					<shiro:hasPermission name="holi:oaHolidayapply:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意"/>&nbsp;</shiro:hasPermission>
					<shiro:hasPermission name="holi:oaHolidayapply:edit"><input id="refuse" class="btn btn-primary" type="button" value="拒 绝" onclick="doRefuse();"/>&nbsp;</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:otherwise>
		</c:choose>
		
	</form:form>
</body>
</html>