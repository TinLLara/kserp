/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oabustrip.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.szcxsl.oa.common.config.Global;
import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.web.BaseController;
import com.szcxsl.oa.common.utils.StringUtils;
import com.szcxsl.oa.modules.oabustrip.entity.OaBusitrip;
import com.szcxsl.oa.modules.oabustrip.service.OaBusitripService;
import com.szcxsl.oa.common.mail.MailSenderInfo;
import com.szcxsl.oa.common.mail.SimpleMailSender;
import com.szcxsl.oa.modules.sys.entity.User;
import com.szcxsl.oa.modules.sys.utils.UserUtils;
import com.szcxsl.oa.common.utils.DateUtils;
import com.szcxsl.oa.modules.sys.dao.UserDao;
import com.szcxsl.oa.modules.oaflow.entity.oaflow.OaFlow;
import com.szcxsl.oa.modules.oaflow.dao.oaflow.OaFlowDao;
import com.szcxsl.oa.modules.holi.service.OaHolidayapplyService;
import com.szcxsl.oa.common.utils.IdGen;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

/**
 * 出差申请增删改查Controller
 * @author Shilei
 * @version 2015-03-25
 */
@Controller
@RequestMapping(value = "${adminPath}/oabustrip/oaBusitrip")
public class OaBusitripController extends BaseController {

	@Autowired
	private OaBusitripService oaBusitripService;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private OaHolidayapplyService oaHolidayapplyService;
	
	@Autowired
	private OaFlowDao oaFlowDao;
	
	@ModelAttribute
	public OaBusitrip get(@RequestParam(required=false) String busitripid) {
		OaBusitrip entity = null;
		if (StringUtils.isNotBlank(busitripid)){
			entity = oaBusitripService.get(busitripid);
		}
		if (entity == null){
			entity = new OaBusitrip();
		}
		return entity;
	}
	
	@RequiresPermissions("oabustrip:oaBusitrip:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaBusitrip oaBusitrip, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaBusitrip> page = oaBusitripService.findPage(new Page<OaBusitrip>(request, response), oaBusitrip); 
		model.addAttribute("page", page);
		return "modules/oabustrip/oaBusitripList";
	}

	@RequiresPermissions("oabustrip:oaBusitrip:view")
	@RequestMapping(value = "form")
	public String form(OaBusitrip oaBusitrip, Model model,@RequestParam(required=false) String tag) {
		model.addAttribute("oaBusitrip", oaBusitrip);
		if (StringUtils.isNotBlank(tag)){
			model.addAttribute("tagvalue", tag);
		}
		if("view".equals(tag)){
			/**
			 * find the oa_flow list for the relation_id.
			 */
			OaFlow oaFlow = new OaFlow();
			oaFlow.setRelationId(oaBusitrip.getBusitripid());
			List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
			model.addAttribute("flowList", flowList);
		}
		return "modules/oabustrip/oaBusitripForm";
	}
	
	public String genTripnum() {
		
		/*generate the trip id*/
		String year = DateUtils.getDate();
		year = year.substring(0, 4);
		
		long num = oaBusitripService.findTripCount(year);
		String back = "";
		num+=1;
		if((num+"").length()==1){
			back = "000"+(num+"");
		}else if((num+"").length()==2){
			back = "00"+(num+"");
		}else if((num+"").length()==3){
			back = "0"+(num+"");
		}
		else {
			back = (num+"");
		}
		
		String tripnumNew = "T"+year+back;
		return tripnumNew;
	}
	
	@RequiresPermissions("oabustrip:oaBusitrip:edit")
	@RequestMapping(value = "save")
	public String save(OaBusitrip oaBusitrip, Model model, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response,@RequestParam(required=false) String submit) {
		if (!beanValidator(model, oaBusitrip)){
			return form(oaBusitrip, model,"");
		}
		oaBusitrip.setTripnum(genTripnum());
		
		String applyperson = oaBusitrip.getApplyperson(); 
		String nextnoder = request.getParameter("operatorid");
		String overtime = DateUtils.getDateTime();
		String loginUserName = UserUtils.getUser().getLoginName();
		String gemid = IdGen.uuid();
		String gemid2 = IdGen.uuid();
		String id = oaBusitrip.getBusitripid();
		String coper = request.getParameter("sendto");
		
		Map paramadd2 = new HashMap();
		paramadd2.put("oaflowid", gemid);
		paramadd2.put("flowtype", "ccsq");
		paramadd2.put("id", id);
		paramadd2.put("createtime", overtime);
		paramadd2.put("overtime", overtime);
		paramadd2.put("loginName", loginUserName);
		paramadd2.put("flowstate", "start");
		paramadd2.put("remark", "");
		paramadd2.put("coper", coper);
		/*流程开始 - start*/
		oaHolidayapplyService.insertFlow(paramadd2); // insert data into the table oa_flow .
		paramadd2.put("oaflowid", gemid2);
		paramadd2.put("loginName", nextnoder);
		paramadd2.put("flowstate", "unauth");
		paramadd2.put("coper", "");
		/*流程开始 - unauth*/
		oaHolidayapplyService.insertFlow(paramadd2);
		Map paramupdate1 = new HashMap();
		paramupdate1.put("table","oa_busitrip");
		paramupdate1.put("status","nextnode");
		paramupdate1.put("tabid","busitripid");
		paramupdate1.put("nextnode", "'unauth'");
		paramupdate1.put("id", "'"+id+"'");
		
		/*set the tag to call the insert or update method*/
		if("insert".equals(submit)){
			oaBusitrip.setIsNewRecord(true);
		}
		else{
			oaBusitrip.setIsNewRecord(false);
			oaBusitrip.setId(id);
		}
		oaBusitripService.save(oaBusitrip);
		oaHolidayapplyService.checkToUpdate1(paramupdate1);
		addMessage(redirectAttributes, "温馨提示:出差申请提交成功！");
		
		/*保存成功发送邮件通知*/
		User currentUser = UserUtils.getUser();
		
		String email = currentUser.getEmail();
		String emailp = currentUser.getEmailp();
		String loginName = currentUser.getLoginName();
		String name = currentUser.getName();
		String dtime = DateUtils.getDateTime();
		
		User paramUser = new User();
		paramUser.setLoginName(nextnoder);
		User nextUser = userDao.getByLoginName(paramUser);
		String sendToEmail = nextUser.getEmail();
		
		if(("".equals(email)||email==null)||("".equals(emailp)||email==null)){
			addMessage(redirectAttributes, "温馨提示:出差申请提交成功，但由于未设置用户邮箱或密码，未以邮件形式通知审批人!");
		}
		else{
			MailSenderInfo mailInfo = new MailSenderInfo(); 
			Global global = new Global();
			String smtp = null;
			smtp = global.getConfig("smtp");
		    //mailInfo.setMailServerHost("smtp.163.com"); 
			mailInfo.setMailServerHost(smtp); 
		    mailInfo.setMailServerPort("25"); 
		    mailInfo.setValidate(true); 
		    mailInfo.setUserName(email); 
		    mailInfo.setPassword(emailp);
		    mailInfo.setFromAddress(email); 
		    mailInfo.setToAddress(sendToEmail); 
		    mailInfo.setSubject("你好！"+name+"("+loginName+")于"+dtime+"提交出差申请，请知悉！"); 
		    mailInfo.setContent("你好！"+name+"("+loginName+")于"+dtime+"提交出差申请！详情或审批请点击如下链接:<a target='_blank' href='http://www.kszhineng.cn'>www.ebrfasset.com/OA/</a>"); 
		    SimpleMailSender sms = new SimpleMailSender();
	        //boolean isSucc = sms.sendTextMail(mailInfo);
		    boolean isSucc = sms.sendHtmlMail(mailInfo);
		    if(isSucc){
		    	addMessage(redirectAttributes, "温馨提示:出差申请提交成功，系统已经以邮件形式通知审批人!");
		    }
		    else{
		    	addMessage(redirectAttributes, "温馨提示:出差申请提交成功，但由于您设置的邮箱或密码错误，未以邮件形式通知审批人!");
		    }
		}
		return "redirect:"+Global.getAdminPath()+"/oabustrip/oaBusitrip/?repage";
	}
	
	@RequiresPermissions("oabustrip:oaBusitrip:edit")
	@RequestMapping(value = "delete")
	public String delete(OaBusitrip oaBusitrip, RedirectAttributes redirectAttributes) {
		oaBusitripService.delete(oaBusitrip);
		addMessage(redirectAttributes, "删除出差申请成功");
		return "redirect:"+Global.getAdminPath()+"/oabustrip/oaBusitrip/?repage";
	}
	
	@RequiresPermissions("oabustrip:oaBusitrip:view")
	@RequestMapping(value = {"listforcheck"})
	public String listforcheck(OaBusitrip oaBusitrip, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaBusitrip> page = oaBusitripService.findCheckTripList(new Page<OaBusitrip>(request, response), oaBusitrip); 
		model.addAttribute("page", page);
		return "modules/oabustrip/oaBusitripCheckList";
	}
	
	@RequiresPermissions("oabustrip:oaBusitrip:view")
	@RequestMapping(value = "formforcheck")
	public String formForCheck(OaBusitrip oaBusitrip, Model model,@RequestParam(required=false)String tag) {
		if (StringUtils.isNotBlank(tag)){
			model.addAttribute("tagvalue", tag);
		}
		/**
		 * find the oa_flow list for the relation_id.
		 */
		OaFlow oaFlow = new OaFlow();
		oaFlow.setRelationId(oaBusitrip.getBusitripid());
		List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
		model.addAttribute("flowList", flowList);
		model.addAttribute("oaBusitrip", oaBusitrip);
		return "modules/oabustrip/oaBusitripCheckForm";
	}
	
	@RequiresPermissions("oabustrip:oaBusitrip:edit")
	@RequestMapping(value = "check")
	public String check(OaBusitrip oaBusitrip, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		String tag = request.getParameter("tag");
		String remark = request.getParameter("remark");
		try{
			remark = java.net.URLDecoder.decode(remark, "UTF-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		String applyperson = oaBusitrip.getApplyperson(); 
		Map paramadd1 = null;
		Map paramadd2 = null;
		Map paramupdate1 = null;
		Map paramadd11 = null;
		String overtime = DateUtils.getDateTime();
		String loginName = UserUtils.getUser().getLoginName();
		String nextnoder = request.getParameter("operatorid");
		String gemid = IdGen.uuid();
		String id = oaBusitrip.getBusitripid();
		
		if("pass".equals(tag)){
			
			paramadd1 = new HashMap();
			paramadd2 = new HashMap();
			paramadd1.put("overtime", overtime);
			paramadd1.put("remark", remark);
			paramadd1.put("loginName", loginName);
			paramadd1.put("id", id);
			
			if(applyperson.equals(nextnoder)){
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "ccsq");
				paramadd2.put("id", id);
				paramadd2.put("createtime", overtime);
				paramadd2.put("overtime", overtime);
				paramadd2.put("loginName", loginName);
				paramadd2.put("flowstate", "end");
				
				paramupdate1 = new HashMap();
				paramupdate1.put("table","oa_busitrip");
				paramupdate1.put("status","nextnode");
				paramupdate1.put("tabid","busitripid");
				paramupdate1.put("nextnode", "'authed'");
				paramupdate1.put("id", "'"+id+"'");
				oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"pass","is");
			}
			else{
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "ccsq");
				paramadd2.put("id", id);
				paramadd2.put("createtime", overtime);
				paramadd2.put("overtime", overtime);
				paramadd2.put("loginName", nextnoder);
				paramadd2.put("flowstate", "unauth");
				oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"pass","no");
			}
		}
		else if("refuse".equals(tag)){
			//String nextnoder = request.getParameter("nextnoder");
			paramadd11 = new HashMap();
			paramadd11.put("overtime", overtime);
			paramadd11.put("remark", remark);
			paramadd11.put("loginName", loginName);
			paramadd11.put("id", id);
			
			paramupdate1 = new HashMap();
			paramupdate1.put("table","oa_busitrip");
			paramupdate1.put("status","nextnode");
			paramupdate1.put("tabid","busitripid");
			paramupdate1.put("nextnode", "'refuse'");
			paramupdate1.put("id", "'"+id+"'");
			oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"refuse","is");
		}
		addMessage(redirectAttributes, "审批出差申请成功");
		return "redirect:"+Global.getAdminPath()+"/oabustrip/oaBusitrip/listforcheck/?repage";
	}
	
	@RequiresPermissions("oabustrip:oaBusitrip:view")
	@RequestMapping(value = {"listforselect"})
	public String listforselect(OaBusitrip oaBusitrip, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaBusitrip> page = oaBusitripService.findPage(new Page<OaBusitrip>(request, response), oaBusitrip); 
		model.addAttribute("page", page);
		return "modules/oabustrip/oaBusitripForSelectList";
	}
}