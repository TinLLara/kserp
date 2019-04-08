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
		
		function printer(){
		  	document.execCommand("Print");
		  	return false;
		};
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/holi/oaHolidayapply/">请休假申请列表</a></li>
		<li class="active"><a href="${ctx}/holi/oaHolidayapply/form?id=${oaHolidayapply.id}">请休假申请<shiro:hasPermission name="holi:oaHolidayapply:edit">${not empty oaHolidayapply.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="holi:oaHolidayapply:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaHolidayapply" action="${ctx}/holi/oaHolidayapply/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="remarks" />
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<form:hidden path="happlyid" htmlEscape="false" maxlength="32" class="input-xlarge required" />
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=gemid %>" name="happlyid" id="happlyid" class="input-medium required" readonly="readonly"/>
			</c:otherwise>
		</c:choose>
		
		<sys:message content="${message}"/>	
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">	
				<div class="control-group">
					<label class="control-label">申请人：</label>
					<div class="controls">
						<form:input path="applyperson" htmlEscape="false" maxlength="16" class="input-medium required" readonly="true"/>
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
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<div class="control-group">
					<label class="control-label">申请时间：</label>
					<div class="controls">
						<input name="applytime" type="text" readonly="readonly" disabled="disabled" maxlength="20" class="input-medium Wdate required"
							value="<fmt:formatDate value="${oaHolidayapply.applytime}" pattern="yyyy-MM-dd"/>"
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
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<div class="control-group">
					<label class="control-label">所属部门：</label>
					<div class="controls">
						<form:input path="belongdept" readonly="true" htmlEscape="false" maxlength="64" class="input-medium required"/>
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
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<div class="control-group">
					<label class="control-label">员工编号：</label>
					<div class="controls">
						<form:input path="staffnum" htmlEscape="false" readonly="true" maxlength="32" class="input-medium"/>
					</div>
				</div>
		</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">员工编号：</label>
					<div class="controls">
						<input type="text" value="<%=gnumber %>" readonly="readonly" name="staffnum" id="staffnum"  class="input-medium"/>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<div class="control-group">
					<label class="control-label">联系电话：</label>
					<div class="controls">
						<form:input path="staffphone" htmlEscape="false" readonly="true" maxlength="16" class="input-medium "/>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">联系电话：</label>
					<div class="controls">
						<input type="text" value="<%=gtel %>" readonly="readonly" name="staffphone" id="staffphone"  class="input-medium"/>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<div class="control-group">
					<label class="control-label">邮箱地址：</label>
					<div class="controls">
						<form:input path="stafftel" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge "/>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">邮箱地址：</label>
					<div class="controls">
						<input type="text" value="<%=gemail %>" readonly="readonly" name="stafftel" id="stafftel"  class="input-xlarge"/>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
		<div class="control-group">
			<label class="control-label">休假类型：</label>
			<div class="controls">
				<form:select path="holidaytpye" disabled="true" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('holidaytype')}" disabled="true" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">起始时间：</label>
			<div class="controls">
				<input type="text" name="starttime" id="starttime" readonly="readonly" disabled="disabled" maxlength="32" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaHolidayapply.starttime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				<input type="text" name="endtime" id="endtime" readonly="readonly" disabled="disabled" maxlength="32" onmouseout="countDays();" class="input-medium Wdate required"
					value="<fmt:formatDate value="${oaHolidayapply.endtime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间(上午/下午)：</label>
			<div class="controls">
				<form:select path="starthour" htmlEscape="false" disabled="true" onchange="countDays();" maxlength="16" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" onmouseout="countDays();" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间(上午/下午)：</label>
			<div class="controls">
				<form:select path="endhour" htmlEscape="false" disabled="true" onchange="countDays();" class="input-medium">
					<form:option value="" label="--请选择--"/>
					<form:options items="${fns:getDictList('triptime')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">天数：</label>
			<div class="controls">
				<form:input path="days" htmlEscape="false" maxlength="11" disabled="true" readonly="readonly" class="input-mini required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">请休假原因：</label>
			<div class="controls">
				<form:textarea path="reason" onclick="countDays();" readonly="readonly" disabled="true" htmlEscape="false" maxlength="2000" class="input-xlarge "/>
			</div>
		</div>
		
		<%-- <div class="control-group">
			<label class="control-label">下一处理环节：</label>
			<div class="controls">
				<form:select path="nextnode" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('flowstatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		
		<%-- <c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<div class="control-group">
					<label class="control-label">下一处理人：</label>
					<div class="controls">
						<form:input path="nextnoder" htmlEscape="false" maxlength="32" class="input-xlarge "/>
						<input type="text" id="operatorname"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
					&nbsp;<A href="javascript:choiceNextOper();"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>请选择处理人>></A>
					<input type="hidden" id="operatorid" name="operatorid" value=""  />
					<font color="red">*</font>
					</div>
				</div>
		</c:when>
			<c:otherwise> --%>
				<div class="control-group">
					<label class="control-label">下一处理人：</label>
					<div class="controls">
						<%-- <form:input path="nextnoder" htmlEscape="false" maxlength="32" class="input-xlarge "/> --%>
						<input type="text" id="nextnoder" value="${oaHolidayapply.nextnoder} " name="nextnoder"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
						<%-- &nbsp;<A href="javascript:choiceNextOper('nextnoder','operatorid');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人>></span></A> --%>
						<input type="hidden" id="operatorid" name="operatorid" value=""  />
						<font color="red">*</font>
					</div>
				</div>
			<%-- </c:otherwise>
		</c:choose>	 --%>
		
		<%-- <c:choose>
			<c:when test="${not empty oaHolidayapply.id}">
				<div class="control-group">
					<label class="control-label">抄送人：</label>
					<div class="controls">
						<form:input path="sendto" htmlEscape="false" maxlength="128" class="input-medium"/>
					</div>
				</div>
		</c:when>
			<c:otherwise> --%>
				<div class="control-group">
						<label class="control-label">抄送人：</label>
						<div class="controls">
							<input type="text" id="sendtoname" name="sendtoname" value="${oaHolidayapply.sendto} " maxlength="128" readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
							<%-- &nbsp;<A href="javascript:choiceNextOper('sendtoname','sendto');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人>></span></A> --%>
							<input type="hidden" id="sendto" name="sendto" value=""  />
						</div>
				</div>
			<%-- </c:otherwise>
		</c:choose>	 --%>
		
		<%-- <div class="control-group">
			<label class="control-label">年假总天数：</label>
			<div class="controls">
				<form:input path="yholiday" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div> --%>
		
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:hidden id="holfile" path="holidayfile" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
				<sys:ckfinder input="holfile" type="files" readonly="true" uploadPath="/holidayfiles" selectMultiple="true" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="holi:oaHolidayapply:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>&nbsp;</shiro:hasPermission> --%>
			<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>