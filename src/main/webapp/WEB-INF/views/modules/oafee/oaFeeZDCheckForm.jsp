
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@page import="com.szcxsl.oa.common.utils.DateUtils"%>
<%@page import="com.szcxsl.oa.modules.sys.utils.UserUtils"%>
<%@page import="com.szcxsl.oa.modules.sys.entity.User"%>
<%@page import="com.szcxsl.oa.common.utils.IdGen"%>
<%
	String date = DateUtils.getDate();
	String gemid = IdGen.uuid();
	User currentUser = UserUtils.getUser();
	String username = currentUser.getLoginName();
	//String gtel = currentUser.getMobile();
	//String goffice = (currentUser.getOffice()).toString();
	//String gnumber = currentUser.getNo();
	//String gemail = currentUser.getEmail();
	/*Context context = (Context) request.getAttribute(EMPConstance.ATTR_CONTEXT);
	String yearh = context.getDataValue("yearh").toString();
	String illh = context.getDataValue("illh").toString();
	String yused = context.getDataValue("yused").toString();
	String iused = context.getDataValue("iused").toString();*/
%>
<html>
<head>
	<title>费用管理管理</title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/map.js"></script>
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
		
     	function choiceFinance(clickObjectName,clickObjectId){
			 var url = '${ctx}/oafinorg/oaMoneyCompany/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		 
	 	function setFinance(clickObjectName,clickObjectId,oid,oname) {
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
	    
	    function printer(){
		  	document.execCommand("Print");
		  	return false;
		};
		
		/*count the total cash*/
		function countTotal(){
			var totalValue=0;
			var getValues = document.getElementById('oldatm');
				if(isEmpty(getValues.value)||!isNumbers(getValues.value))
				{
					totalValue = 0;
				}else{
					totalValue = parseFloat(getValues.value);
				}
			var tp = document.getElementById("currency").value;
			if(tp=="2"){
				document.getElementById("totalcash").value = totalValue.toFixed(2)+"港元";
			}else if(tp=="3"){
				document.getElementById("totalcash").value = totalValue.toFixed(2)+"美元";
			}else{
				
				document.getElementById("totalcash").value = totalValue.toFixed(2)+"元";
			}
			
			alert(RMB(totalValue.toFixed(2)));
			document.getElementById("totalcashzh").value = RMB(totalValue.toFixed(2));
		};
		
		function RMB(s){
	         var num = {1:'壹',2:'贰',3:'叁',4:'肆',5:'伍',6:'陆',7:'柒',8:'捌',9:'玖',0:'零'};
	         var result = "";
	         var s = (new Number(s)).toString();
		 	 var tp = document.getElementById("currency").value;
	         var t = function(s,index){
	                   var isZero = false;
	                   for(var i = 0;i<index;i++){
	                            var c = s.charAt(i);
	                            var n = 1;
	                            for(var k = 0;k<index-i;k++){
	                                     n = n*10;
	                            }
	                            
	                            if(c!='0'){
	                                     isZero = false;
	                                     result+=num[c];
	                                     if(index-i==4)
	                                               result+='仟';
	                                     if(index-i==3)
	                                               result+='佰';
	                                     if(index-i==2)
	                                               result+='拾';
	                            }else{
	
	                                     if(new String(s/n).indexOf('.')<0)
	                                               break ;
	                                     if(!isZero&&i<index-1)
	                                               result+=num[c];
	                                     isZero = true ;
	                            }
	                            
	                   }
	         }
	
	         if(s!='NaN'){
	                  var p = s.indexOf('.');
	                   var string=s;
	                   var index = p<0?s.length:p;
	
	                   while(true){
	                            if(5>index>0){
	                                     t(s,index);
	                                     if(tp=="2"){
	                                     	result+='港圆';
	                                     }else if(tp=="3"){
	                                     	result+='美圆';
	                                     }else{
											result+='圆';                                     
	                                     }
	                                     break ;
	                            }else if(index>4&&index<9){
	                                     var w = s.substr(0,index-4);
	                                     t(w,w.length);
	                                     result += '万';
	                                     s=s.substr(index-4,index-w.length);
	                                     index = index-w.length;
	                            }else if(index>8&&index<13){
	                                     var w = s.substr(0,index-8);
	                                     t(w,w.length);
	                                     result += '亿';
	                                     s=s.substr(index-8,index-w.length);
	                                     index = index-w.length;
	                            }else{
	                                     return ;
	                            }
	                   }
	                   if (p>0){
	                            result+=num[string.charAt(p+1)]+"角";
	                   }
	                   
	         }
	
	         return result;
		};
		
		
		
		function choiceNextOper(clickObjectName,clickObjectId){
			 var url = '${ctx}/sys/user/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		 
	 	function setNextOper(clickObjectName,clickObjectId,oid,oname) {
	   		document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
	    };
	    
	    function choosetime(clickObjectName){
	    	var url = '${ctx}/oachedule/oachedule/oaSchedule/listforselect?clickObjectName='+clickObjectName;		
			 openWin(url,'',800,550);
		};
		
		function setTime(clickObjectName,time) {
		   	document.getElementById(clickObjectName).value=time;
	    };
	    
	    function showorhid(param){
	    	var param = document.getElementById("other").value;
	    	if(param=="2"){
	    		document.getElementById("showh").style.display='none';
	    		document.getElementById("showh2").style.display='none';
	    	}else{
	    		document.getElementById("showh").style.display='';
	    		document.getElementById("showh2").style.display='';
	    	}
	    };
	    
	    function checkForm(){
	    	
			var partname = document.getElementById("partname");
			if(isEmpty(partname.value)){
				alert("费用承担财务组织为必选项，请选择！");
				return false;
			}
			
			var pronameValues = document.getElementsByName("proname");
			var other = document.getElementsByName("other");
			for(var i=0;i<pronameValues.length;i++){
				if(other=="1"){
					if(isEmpty(pronameValues[i].value)){
						alert("项目名称为必选项，请选择！");
						return false;
					}
				}
			}
			
			var times = document.getElementsByName("happentime");
			for(var i=0;i<times.length;i++){
				if(isEmpty(times[i].value)){
					alert("发生时间为必选项，请选择！");
					return false;
				}
			}
			
			var oldatms = document.getElementsByName("oldatm");
			for(var i=0;i<oldatms.length;i++){
				if(isEmpty(oldatms[i].value)){
					alert("金额为必填项，请填写！");
					return false;
				}
			}
			
			
			var feecomments = document.getElementsByName("feecomment");
			for(var i=0;i<feecomments.length;i++){
				if(isEmpty(feecomments[i].value)){
					alert("事由为必填项，请填写！");
					return false;
				}
			}
			
			var np = document.getElementById("operatorname").value;
			if(np=="" || np==null){
	     	  	alert('请选择下一处理人！');
	     	  	return false;
	     	  }
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
				var nextnoder = document.getElementById('operatorid').value;
				if(nextnoder!='${oaFee.applyperson}'){
					alert("温馨提示：请选择申请者作为下一处理人，然后拒绝。");
					return;
				}
				var id = '${oaFee.feeid}';
				
				//var url = '${ctx}'+"/holi/oaHolidayapply/check?tag=refuse&remark="+encodeURIComponent(remark)+'&id='+happlyid;
				var url = '${ctx}'+"/oayzsq/oaYinzsq/check?tag=refuse&id="+id+"&remark="+remark;
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
	th{
		text-align: center;
	  }
	.content_null{
		border-left:0px;
		border-right:0px;
		border-bottom:1px solid #dcdcdc;
	}
	.content_body_null{
		border-right:0px;
		border-bottom:1px solid #dcdcdc;
		
	}
	.cssclss{
		width:90px;
		border:1px solid #7F9DB9;
	}
	.ccsycss{
		width:98%;
		height:60px;
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
		<li><a href="${ctx}/oafee/oaFee/formforcheck?feecat=${oaFee.feecat}">费用列表</a></li>
		<li class="active"><a href="${ctx}/oafee/oaFee/formforcheck?feecat=ZD&feeid=${oaFee.feeid}">费用<shiro:hasPermission name="oafee:oaFee:edit">${not empty oaFee.feeid?'审批':'审批'}</shiro:hasPermission><shiro:lacksPermission name="oafee:oaFee:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaFee" action="${ctx}/oafee/oaFee/check?tag=pass" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<c:choose>
			<c:when test="${not empty oaFee.feeid}">
				<form:hidden path="feeid" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" value="<%=gemid %>" name="feeid" id="feeid" class="input-medium required" />
			</c:otherwise>
		</c:choose>
		
		<table  border="0" cellpadding="5" style="align:center;text-align:left;width:80%;" class="content_table">
		  <caption align="center"><h3>招待费用报销</h3></caption>
			
			<tr>
			 <td class='content_index' align="right">申请人</td>
			<td  class='content_body'>
			<c:choose>
				<c:when test="${not empty oaFee.feeid}">
					<form:input path="applyperson" htmlEscape="false" maxlength="32" class="input-medium "/>
				</c:when>
				<c:otherwise>
					<input type="text" name="applyperson" id="applyperson" value="<%=username %>" maxlength="32" class="input-medium "/>
			</c:otherwise>
		</c:choose>
			</td>
			<td class='content_index' align="right">填报时间</td>
			<td  class="content_body">
				<input name="applytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${oaFee.applytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</td>
			</tr>
			
			<tr>
			 <td class='content_index' align="right">申请人所属部门</td>
			<td  class='content_body'>
				<form:input path="belongdept" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</td>
			<td class='content_index' align="right">费用承担财务组织(<font color="red">*</font>)</td>
			<td  class="content_body">
				<%-- <form:input path="feebelongdept" htmlEscape="false" maxlength="128" class="input-xlarge "/> --%>
				<input type="hidden" id="partid" name="partid"/>	
				<input type="text" id="feebelongdept" name="feebelongdept" value="${oaFee.feebelongdept}" style="width:205px;" readonly="readonly"  />
				<A onclick="choiceFinance('feebelongdept','partid');" style="cursor:pointer;"><IMG id="fan" src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A>
			</td>
			</tr>
			<tr>
				<td class='content_body' colspan="4">
				<table border="0" cellpadding="5" style="align:center;text-align:left;width:100%;"  class="content_table">
				<tr style="padding:0px;margin:0px;">
				<td align="center" class='content_index'>招待类型</td><td align="center" class='content_index' id="showh">项目名称</td><td align="center" class='content_index'>发生时间</td><td align="center" class='content_index' width="78px;">币种</td>
				<td align="center" class='content_index'>金额</td><td align="center" class='content_index'>事由(<font color="red">必填</font>)</td>
				</tr>
				<tr>
				<td class='content_body' align="center">
				<select name="other" id="other" style="width:75px;" onchange="showorhid(this.value);"><option value="1" selected="selected" >项目</option><option value="2" >其他</option></select>
				</td>
				<td class='content_body' align="center" id="showh2">
				<input type="hidden" id="projectid" name="projectid" value="${oaFee.projectid}"/>	
				<input type="text" id="proname" name="proname" style="width:155px;" readonly="readonly"  value="${oaFee.proname}" />
				<A onclick="choicepro('proname','projectid');" style="cursor:pointer;"><IMG id="fan" src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A></td>
				<td class='content_body' align="center"><input type="text" name="happentime" id="happentime" value="${oaFee.happentime}"  size="30" style="width:120px;" readonly="readonly"/>
				<input type="hidden" name="eventid" id="eventid" />
				<A onclick="choosetime('happentime');" style="cursor:pointer;"><IMG id="fan" src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A>
				</td>
				<td class='content_body' align="center"><select name="currency" id="currency" style="width:75px;"><option value="" >-请选择-</option><option value="1" selected="selected">人民币</option><option value="2" >港元</option><option value="3" >美元</option><option value="4" >其他</option></select></td>
				<td class='content_body' align="center"><input type="text" name="oldatm" id="oldatm" value="${oaFee.oldatm}" onkeyup="countTotal();" style="width:60px;" size="20" /></td>
				<td class='content_body' align="center"><input type="text" name="feecomment" id="feecomment" value="${oaFee.feecomment}" size="20" /></td>
				</tr>
				</table>
				<table id="b_addLine" border="0" cellpadding="5" style="align:center;text-align:left;width:100%;"  class="content_table">
				</table>
					
				</td>
			</tr>
			<tr>
				<td class='content_index' align="right">报销金额(小写)</td>
				<td class='content_body'><form:input path="totalcash" htmlEscape="false" maxlength="32" class="input-xlarge " readonly="true"/></td>
				<td class='content_index' align="right">报销金额(大写)</td>
				<td class='content_body'><form:input path="totalcashzh" htmlEscape="false" maxlength="32" class="input-xlarge " readonly="true"/></td>
			</tr>
			
		 
		  <!-- <tr>
			<td class='content_index' align="right">附件信息</td>
			<td class='content_body' colspan="3">
			    
				提示:每次保存附件大小不能超过<font color="red">50M</font>.
			</td>
		  </tr>	 -->
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
		  <c:choose>
			<c:when test="${tagvalue eq 'view'}">
			</c:when>
			<c:otherwise>
		   <tr>
			<td class='content_index' align="right">下一处理人</td>
			<td class='content_body' >
			<input type="text" id="operatorname" readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
			&nbsp;<A href="javascript:choiceNextOper('operatorname','operatorid');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人>></span></A>
			<input type="hidden" id="operatorid" name="operatorid" value=" "  />
			</td>
			<td class='content_index' align="right"></td>
			<td class='content_body'>
			<!-- <input type="text" id="sendname"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
			<input type="hidden" id="sendmail" name="sendmail"  /> -->
			<%-- <a href="javascript:choiceNextOper('sendname','sendmail')"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人>></span></a> --%>
			</td>
			</tr>
			</c:otherwise>
		</c:choose>
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
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意"/>
					<input id="refuse" class="btn btn-primary" type="button" value="拒 绝" onclick="doRefuse();"/>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:otherwise>
		</c:choose>
	</form:form>
</body>
</html>