
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
			insert();
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
		
		function insert(){
			tag = document.getElementById("currency").value;
			if(tag=="1"){
				div1.innerHTML="<input type=\"text\" name=\"planefee\" id=\"planefee\"  size=\"15\" value=\"${oaFee.planefee}\" style=\"width:90px;\" onclick=\"getfee('0','plane');\" onkeyup=\"countTotal();\" />";
				div2.innerHTML="<input type=\"text\" style=\"width:90px;\" onkeyup=\"countTotal();\" value=\"${oaFee.livingfee}\" onclick=\"getfee('0','living');\" name=\"livingfee\" id=\"livingfee\"  size=\"15\" />";
			}else{
				div1.innerHTML='<input type="text" name="planefee" id="planefee"  size="15" style="width:90px;"  onkeyup="countTotal();"/>';
				div2.innerHTML='<input type="text" style="width:90px;" onkeyup="countTotal();"  name="livingfee" id="livingfee"  size="15"/>';
			}
		};
		
		function choiceList(i){
			var url = '${ctx}/oabustrip/oaBusitrip/listforselect';		
			openWin(url,'',800,550);
	 	};
	 	
	 	function setList(busitripid, contname,startaddr,endaddr,startdate,enddate,relatedpro,tripdays,tripreason) {
	   		document.getElementById('triplist').value=busitripid;
	   		document.getElementById('triplistname').value=contname;
	   		document.getElementById('saddr').value=startaddr;
	   		document.getElementById('eaddr').value=endaddr;
	   		document.getElementById('proname').value=relatedpro;
	   		document.getElementById('projectid').value=relatedpro;
	   		document.getElementById('remarks').value=tripreason;
	   		if(parseInt(tripdays)==0){
	   			document.getElementById('tripfee').value=1;//200;
	   		}else{
	   			document.getElementById('tripfee').value=parseInt(tripdays);//*200;
	   		}
	   		document.getElementById('sdate').value=startdate;
	   		document.getElementById('edate').value=enddate;
     	};
     	
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
	    
	    function getfee(i,tag){
			var url = '<emp:url action="getViewTengbangInfoPage2.do"/>&indexNum='+i+'&tag='+tag;		
			url = EMPTools.encodeURI(url);
			openWin(url,'',800,550);
		};
		
		function setfee(oid,index) {
		   	document.getElementById('planefee'+index).value=oid;
		   	countTotal();
	    };
	    
	    function setlivingfee(oid) {
		   	document.getElementById('livingfee').value=oid;
		   	countTotal();
	    };
	    
	    function printer(){
		  	document.execCommand("Print");
		  	return false;
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
		
		/*count the total cash*/
		function countTotal(){
			var totalValue=0;
			var planefee = document.getElementById('planefee').value;
			var distancefee = document.getElementById('distancefee').value;
			var cityfee = document.getElementById('cityfee').value;
			var tripfee0 = document.getElementById('tripfee').value;
			var livingfee = document.getElementById('livingfee').value;
			var otherfee = document.getElementById('otherfee').value;
			var livingcash = document.getElementById('advancecash').value;//住宿费（自填写）
			var feecomment = document.getElementById('feecomment').value;//机票费（自填写）
			
			if(isEmpty(planefee)||!isNumbers(planefee))
			{
					planefee = 0;
			}else{
					totalValue+=parseFloat(planefee);
			}
			
			if(isEmpty(distancefee)||!isNumbers(distancefee))
			{
					distancefee = 0;
			}else{
					totalValue+=parseFloat(distancefee);
			}
			
			if(isEmpty(cityfee)||!isNumbers(cityfee))
			{
					cityfee = 0;
			}else{
					totalValue+=parseFloat(cityfee);
			}
			
			/*if(isEmpty(tripfee0)||!isNumbers(tripfee0))
			{
					tripfee0 = 0;
			}else{
					totalValue+=parseFloat(tripfee0);
			}*/
			
			if(isEmpty(livingfee)||!isNumbers(livingfee))
			{
					livingfee = 0;
			}else{
					totalValue+=parseFloat(livingfee);
			}
			
			if(isEmpty(otherfee)||!isNumbers(otherfee))
			{
					otherfee = 0;
			}else{
					totalValue+=parseFloat(otherfee);
			}
			
			if(isEmpty(livingcash)||!isNumbers(livingcash))
			{
					livingfee = 0;
			}else{
					totalValue+=parseFloat(livingcash);
			}
			if(isEmpty(feecomment)||!isNumbers(feecomment))
			{
					feecomment = 0;
			}else{
					totalValue+=parseFloat(feecomment);
			}
			
			var tp = document.getElementById("currency").value;
			if(tp=="2"){
				document.getElementById("totalcash").value = (totalValue-parseFloat(planefee)-parseFloat(livingfee)).toFixed(2)+"港元";
			}else if(tp=="3"){
				document.getElementById("totalcash").value = (totalValue-parseFloat(planefee)-parseFloat(livingfee)).toFixed(2)+"美元";
			}else{
				
				document.getElementById("totalcash").value = (totalValue-parseFloat(planefee)-parseFloat(livingfee)).toFixed(2)+"元";
			}
			document.getElementById("checkedfee").value = totalValue.toFixed(2);
			document.getElementById("totalcashzh").value = RMB((totalValue-parseFloat(planefee)-parseFloat(livingfee)).toFixed(2));
		};
		
		function choiceNextOper(clickObjectName,clickObjectId){
			 var url = '${ctx}/sys/user/listforselect?clickObjectName='+clickObjectName+'&clickObjectId='+clickObjectId;		
			 openWin(url,'',800,550);
		};
		 
	 	function setNextOper(clickObjectName,clickObjectId,oid,oname) {
	   		document.getElementById(clickObjectId).value=oid;
	   		document.getElementById(clickObjectName).value=oname;
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
		<li><a href="${ctx}/oafee/oaFee/?feecat=${oaFee.feecat}">费用管理列表</a></li>
		<li class="active"><a href="${ctx}/oafee/oaFee/form?feeid=${oaFee.feeid}">费用管理<shiro:hasPermission name="oafee:oaFee:edit">${not empty oaFee.feeid?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="oafee:oaFee:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="oaFee" action="${ctx}/oafee/oaFee/save?submit=${not empty oaFee.feeid?'update':'insert'}" method="post" class="form-horizontal">
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
		<%-- 
		<c:choose>
			<c:when test="${not empty oaFee.feeid}">
				<div class="control-group">
					<label class="control-label">申请人：</label>
					<div class="controls">
						<form:input path="applyperson" htmlEscape="false" maxlength="32" class="input-medium "/>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">申请人：</label>
					<div class="controls">
						<input type="text" name="applyperson" id="applyperson" value="<%=username %>" maxlength="32" class="input-medium "/>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="control-group">
			<label class="control-label">申请时间：</label>
			<div class="controls">
				<input name="applytime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${oaFee.applytime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请人所属部门：</label>
			<div class="controls">
				<form:input path="belongdept" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">费用归属部门：</label>
			<div class="controls">
				<form:input path="feebelongdept" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目名称：</label>
			<div class="controls">
				<form:input path="proname" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">费用说明：</label>
			<div class="controls">
				<form:input path="feecomment" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差起始时间：</label>
			<div class="controls">
				<input name="sdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${oaFee.sdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差结束时间：</label>
			<div class="controls">
				<input name="edate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${oaFee.edate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差出发地点：</label>
			<div class="controls">
				<form:input path="saddr" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差目的地：</label>
			<div class="controls">
				<form:input path="eaddr" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交通工具：</label>
			<div class="controls">
				<form:input path="tools" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">币种类型：</label>
			<div class="controls">
				<form:input path="currency" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">飞机费用：</label>
			<div class="controls">
				<form:input path="planefee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">市内交通费用：</label>
			<div class="controls">
				<form:input path="cityfee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">住宿费用：</label>
			<div class="controls">
				<form:input path="livingfee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差补助（200*days）：</label>
			<div class="controls">
				<form:input path="tripfee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">其他费用：</label>
			<div class="controls">
				<form:input path="otherfee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">核定币种：</label>
			<div class="controls">
				<form:input path="checkedcu" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">核定金额：</label>
			<div class="controls">
				<form:input path="checkedfee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出差申请单：</label>
			<div class="controls">
				<form:input path="triplist" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:input path="files" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审批状态：</label>
			<div class="controls">
				<form:select path="state" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">回执标志：</label>
			<div class="controls">
				<form:input path="noticetag" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参与人：</label>
			<div class="controls">
				<form:input path="joinedper" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预支金额：</label>
			<div class="controls">
				<form:input path="advancecash" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">费用类型：</label>
			<div class="controls">
				<form:input path="feetype" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">费用发生时间：</label>
			<div class="controls">
				<form:input path="happentime" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原币金额：</label>
			<div class="controls">
				<form:input path="oldatm" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">合计金额：</label>
			<div class="controls">
				<form:input path="totalcash" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">合计金额(大写)：</label>
			<div class="controls">
				<form:input path="totalcashzh" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">长途交通费：</label>
			<div class="controls">
				<form:input path="distancefee" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">费用大类：</label>
			<div class="controls">
				<form:input path="feecat" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">相关项目：</label>
			<div class="controls">
				<form:input path="projectid" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">事由：</label>
			<div class="controls">
				<form:input path="comeon" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">其他：</label>
			<div class="controls">
				<form:input path="other" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">说明：</label>
			<div class="controls">
				<form:input path="details" htmlEscape="false" maxlength="256" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">相关事件：</label>
			<div class="controls">
				<form:input path="eventid" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下一处理人：</label>
			<div class="controls">
				<form:input path="nextnoder" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">修改备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div> --%>
		
		<table  border="0" cellpadding="5" style="align:center;text-align:left;width:80%;" class="content_table">
		  <caption align="center"><h3>差旅费用报销</h3></caption>
			
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
			<tr style="padding:0px;margin:0px;">
				 <td class='content_index' align="right">出差申请单(<font color="red">*</font>)</td>
				<td  class='content_body'  >
				<%-- <form:input path="triplist" htmlEscape="false" maxlength="32" class="input-xlarge "/> --%>
				<input type="hidden" id="triplist" name="triplist" />	
				<input type="text" id="triplistname" name="triplistname" style="width:280px;" value="${oaFee.triplist }"/>
				<A onclick="choiceList();" style="cursor:pointer;"><IMG id="fan" src="${pageContext.request.contextPath}/images/but_Searchfile.gif" /></A>
				</td>
				 <td class='content_index' align="right">币种</td>
				<td class='content_body'><select id="currency" name="currency" style="width:75px;" onchange="insert();"><option value="" >-请选择-</option><option value="1" selected="selected" onclick="countTotal();">人民币</option><option value="2" onclick="countTotal();">港元</option><option value="3" onclick="countTotal();">美元</option><option value="4" >其他</option></select></td>
				</tr>
			<tr>
				<td class='content_body' colspan="4">
				<table border="0" cellpadding="5" style="align:center;text-align:left;width:100%;" class="content_table">
				
				<tr style="padding:0px;margin:0px;">
				<td align="center" class='content_index' >项目名称</td><td align="center" class='content_index' >出发日期</td><td align="center" class='content_index'>回程日期</td>
				<td align="center" class='content_index'>出发地</td><td align="center" class='content_index'>目的地</td><!-- <td align="center" class='content_index'>交通工具</td> -->
				<td align="center" class='content_index'>机票费(自填)</td><td align="center" class='content_index'>住宿费(自填)</td>
				</tr>
				<tr>
				<td class='content_body'>
					<input type="hidden" id="projectid" name="projectid" value="${oaFee.projectid}"/>	
					<input type="text" id="proname" name="proname" style="width:90px;" readonly="readonly" value="${oaFee.proname}" /></td>
				<td class='content_body'><input type="text" onkeyup="counttripf()" value="${oaFee.sdate}" name="sdate" style="width:90px;" id="sdate"  size="15"/></td>
				<td class='content_body'><input type="text" onkeyup="counttripf()" value="${oaFee.edate}" name="edate" style="width:90px;" id="edate"  size="15"/></td>
				<td class='content_body'><input type="text" name="saddr" id="saddr" value="${oaFee.saddr}" style="width:90px;"  readonly="readonly" size="15"/></td>
				<td class='content_body'><input type="text" name="eaddr" id="eaddr" value="${oaFee.eaddr}" style="width:90px;"  readonly="readonly" size="15"/></td>
				<!-- <td class='content_body'><select name="tools" style="width:90px;"><option value="" >-请选择-</option><option value="1" >飞机</option><option value="2" >火车</option><option value="3" >汽车</option><option value="4" >轮船</option><option value="5" >其他</option></select></td> -->
				<td class='content_body'><input type="text" id="feecomment" value="${oaFee.feecomment}" onkeyup="countTotal();" name="feecomment" style="width:90px;"  size="20" /></td><td class='content_body'><form:input path="advancecash" onkeyup="countTotal();" htmlEscape="false" style="width:95px;"/></td>
				</tr>
				<tr>
				<td align="center" class='content_index'>机票费</td><td align="center" class='content_index'>住宿费</td><td align="center" class='content_index'>长途费用</td><td align="center" class='content_index'>市内交通费</td>
				<td align="center" class='content_index'>出差天数</td><td align="center" class='content_index'>其他</td><td align="center" class='content_index'>小计</td>
				</tr>
				<tr>
				
				<td class='content_body' id="div1">
				</td>
				<td class='content_body' id="div2"></td>
				<td class='content_body'><input type="text" style="width:90px;" onkeyup="countTotal();" value="${oaFee.distancefee}" name="distancefee" id="distancefee"   size="20" /></td>
				<td class='content_body'><input type="text" style="width:90px;" onkeyup="countTotal();" value="${oaFee.cityfee}" name="cityfee" id="cityfee"  size="15"/></td>
				<td class='content_body'><input type="text" style="width:90px;" onkeyup="countTotal();" value="${oaFee.tripfee}" id="tripfee"  name="tripfee"   size="15"/></td>
				<td class='content_body'><input type="text" style="width:90px;" onkeyup="countTotal();" value="${oaFee.otherfee}" name="otherfee" id="otherfee"  size="15"/></td>
				<td class='content_body'><input type="text" style="width:90px;" onkeyup="countTotal();" value="${oaFee.checkedfee}" name="checkedfee" id="checkedfee" readonly="readonly"  size="15"/></td>
				</tr>
				<tr>
				<td align="center" class='content_index' align="center" >说明</td>
				<td  class='content_body' colspan="6">
				<input type="text" id="details" name = "details" style="width:98%;"/>
				</td>
				</tr>
				<tr>
				<td align="center" class='content_index' align="center" >出差事由</td>
				<td  class='content_body' colspan="6">
					<textarea id="remarks" name="remarks"  maxlength="1000" class="ccsycss"></textarea>
				</td>
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
			
		  <tr>
			<td class='content_index' align="right">下一处理人</td>
			<td class='content_body' >
			<input type="text" id="operatorname" value="${oaFee.nextnoder}" readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
			&nbsp;<A href="javascript:choiceNextOper('operatorname','nextnoder');"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择处理人>></span></A>
			<input type="hidden" id="nextnoder" name="nextnoder" value="${oaFee.nextnoder}"  />
			</td>
			<td class='content_index' align="right">抄送人</td>
			<td class='content_body'>
			<input type="text" id="sendname"  readonly="readonly" style="width:120px;background:#F9F9F9;border:0px;color:red;" />
			<input type="hidden" id="sendmail" name="sendmail"  />
			<a href="javascript:choiceNextOper('sendname','sendmail')"><img src="${pageContext.request.contextPath}/images/ico_18.gif" style="border:0px;"/>&nbsp;<span style="vertical-align: middle;">请选择抄送人>></span></a>
			</td>
			</tr>
		  <!-- <tr>
			<td class='content_index' align="right">附件信息</td>
			<td class='content_body' colspan="3">
			    
				提示:每次保存附件大小不能超过<font color="red">50M</font>.
			</td>
		  </tr>	 -->
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
					<shiro:hasPermission name="oafee:oaFee:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交"/>&nbsp;</shiro:hasPermission>
					<input id="print" class="btn" type="button" value="打 印" onclick="printer()"/>&nbsp;
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</c:otherwise>
		</c:choose>
	</form:form>
</body>
</html>