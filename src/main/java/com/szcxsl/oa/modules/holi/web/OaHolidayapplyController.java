/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.holi.web;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

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

import com.szcxsl.oa.common.utils.IdGen;
import com.szcxsl.oa.common.utils.DateUtils;
import com.szcxsl.oa.modules.sys.utils.UserUtils;
import com.szcxsl.oa.common.config.Global;
import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.web.BaseController;
import com.szcxsl.oa.common.utils.StringUtils;
import com.szcxsl.oa.modules.oaflow.entity.oaflow.OaFlow;
import com.szcxsl.oa.modules.oaflow.dao.oaflow.OaFlowDao;
import com.szcxsl.oa.modules.holi.entity.OaHolidayapply;
import com.szcxsl.oa.modules.holi.service.OaHolidayapplyService;

/**
 * 请休假申请Controller
 * @author Tin Shi
 * @version 2015-04-28
 */
@Controller
@RequestMapping(value = "${adminPath}/holi/oaHolidayapply")
public class OaHolidayapplyController extends BaseController {

	@Autowired
	private OaHolidayapplyService oaHolidayapplyService;
	
	@Autowired
	private OaFlowDao oaFlowDao;
	
	@ModelAttribute
	public OaHolidayapply get(@RequestParam(required=false) String happlyid) {
		OaHolidayapply entity = null;
		if (StringUtils.isNotBlank(happlyid)){
			entity = oaHolidayapplyService.get(happlyid);
		}
		if (entity == null){
			entity = new OaHolidayapply();
		}
		return entity;
	}
	
	@RequiresPermissions("holi:oaHolidayapply:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaHolidayapply oaHolidayapply, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaHolidayapply> page = oaHolidayapplyService.findPage(new Page<OaHolidayapply>(request, response), oaHolidayapply); 
		model.addAttribute("page", page);
		return "modules/holi/oaHolidayapplyList";
	}

	@RequiresPermissions("holi:oaHolidayapply:view")
	@RequestMapping(value = "form")
	public String form(OaHolidayapply oaHolidayapply, Model model,@RequestParam(required=false) String tag) {
		model.addAttribute("oaHolidayapply", oaHolidayapply);
		if("view".equals(tag)){
			/**
			 * find the oa_flow list for the relation_id.
			 */
			OaFlow oaFlow = new OaFlow();
			oaFlow.setRelationId(oaHolidayapply.getHapplyid());
			List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
			model.addAttribute("flowList", flowList);
		}
		if((!"".equals(tag)&&tag!=null)&&"view".equals(tag)){
			return "modules/holi/oaHolidayapplyViewForm";
		}
		else{
			return "modules/holi/oaHolidayapplyForm";
		}
	}

	@RequiresPermissions("holi:oaHolidayapply:edit")
	@RequestMapping(value = "save")
	public String save(OaHolidayapply oaHolidayapply, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response,@RequestParam(required=false) String submit) {
		if (!beanValidator(model, oaHolidayapply)){
			return form(oaHolidayapply, model,"");
		}
		
		String applyperson = oaHolidayapply.getApplyperson(); 
		String nextnoder = request.getParameter("operatorid");
		String overtime = DateUtils.getDateTime();
		String loginName = UserUtils.getUser().getLoginName();
		String gemid = IdGen.uuid();
		String gemid2 = IdGen.uuid();
		String id = oaHolidayapply.getHapplyid();
		String coper = request.getParameter("sendto");
		
		Map paramadd2 = new HashMap();
		paramadd2.put("oaflowid", gemid);
		paramadd2.put("flowtype", "xjsq");
		paramadd2.put("id", id);
		paramadd2.put("createtime", overtime);
		paramadd2.put("overtime", overtime);
		paramadd2.put("loginName", loginName);
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
		paramupdate1.put("table","oa_holidayapply");
		paramupdate1.put("status","nextnode");
		paramupdate1.put("tabid","happlyid");
		paramupdate1.put("nextnode", "'unauth'");
		paramupdate1.put("id", "'"+id+"'");
		
		addMessage(redirectAttributes, "保存请休假申请成功");
		
		/*set the tag to call the insert or update method*/
		if("insert".equals(submit)){
			oaHolidayapply.setIsNewRecord(true);
		}
		else{
			oaHolidayapply.setIsNewRecord(false);
			oaHolidayapply.setId(id);
		}
		oaHolidayapplyService.save(oaHolidayapply);
		oaHolidayapplyService.checkToUpdate1(paramupdate1);
		return "redirect:"+Global.getAdminPath()+"/holi/oaHolidayapply/?repage";
	}
	
	@RequiresPermissions("holi:oaHolidayapply:edit")
	@RequestMapping(value = "delete")
	public String delete(OaHolidayapply oaHolidayapply, RedirectAttributes redirectAttributes) {
		oaHolidayapplyService.delete(oaHolidayapply);
		addMessage(redirectAttributes, "删除请休假申请成功");
		return "redirect:"+Global.getAdminPath()+"/holi/oaHolidayapply/?repage";
	}
	
	@RequiresPermissions("holi:oaHolidayapply:view")
	@RequestMapping(value = {"listforcheck"})
	public String listforcheck(OaHolidayapply oaHolidayapply, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaHolidayapply> page = oaHolidayapplyService.findCheckList(new Page<OaHolidayapply>(request, response), oaHolidayapply); 
		model.addAttribute("page", page);
		return "modules/holi/oaHolidayapplyCheckList";
	}
	
	@RequiresPermissions("holi:oaHolidayapply:view")
	@RequestMapping(value = "formforcheck")
	public String formForCheck(OaHolidayapply oaHolidayapply, Model model,@RequestParam(required=false)String tag) {
		if (StringUtils.isNotBlank(tag)){
			model.addAttribute("tagvalue", tag);
		}
		/**
		 * find the oa_flow list for the relation_id.
		 */
		OaFlow oaFlow = new OaFlow();
		oaFlow.setRelationId(oaHolidayapply.getHapplyid());
		List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
		model.addAttribute("flowList", flowList);
		model.addAttribute("oaHolidayapply", oaHolidayapply);
		return "modules/holi/oaHolidayapplyCheckForm";
	}
	
	@RequiresPermissions("holi:oaHolidayapply:edit")
	@RequestMapping(value = "check")
	public String check(OaHolidayapply oaHolidayapply, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		String tag = request.getParameter("tag");
		String remark = request.getParameter("remark");
		try{
			remark = java.net.URLDecoder.decode(remark, "UTF-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		String applyperson = oaHolidayapply.getApplyperson(); 
		
		Map paramadd1 = null;
		Map paramadd2 = null;
		Map paramupdate1 = null;
		Map paramadd11 = null;
		String overtime = DateUtils.getDateTime();
		String loginName = UserUtils.getUser().getLoginName();
		String gemid = IdGen.uuid();
		String id = oaHolidayapply.getHapplyid();
		String nextnoder = request.getParameter("operatorid");
		
		if("pass".equals(tag)){
			
			paramadd1 = new HashMap();
			paramadd2 = new HashMap();
			paramadd1.put("overtime", overtime);
			paramadd1.put("remark", remark);
			paramadd1.put("loginName", loginName);
			paramadd1.put("id", id);
			
			if(applyperson.equals(nextnoder)){
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "xjsq");
				paramadd2.put("id", id);
				paramadd2.put("createtime", overtime);
				paramadd2.put("overtime", overtime);
				paramadd2.put("loginName", loginName);
				paramadd2.put("flowstate", "end");
				
				paramupdate1 = new HashMap();
				paramupdate1.put("table","oa_holidayapply");
				paramupdate1.put("status","nextnode");
				paramupdate1.put("tabid","happlyid");
				paramupdate1.put("nextnode", "'authed'");
				paramupdate1.put("id", "'"+id+"'");
				oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"pass","is");
			}
			else{
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "xjsq");
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
			paramupdate1.put("table","oa_holidayapply");
			paramupdate1.put("status","nextnode");
			paramupdate1.put("tabid","happlyid");
			paramupdate1.put("nextnode", "'refuse'");
			paramupdate1.put("id", "'"+id+"'");
			oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"refuse","is");
		}
		addMessage(redirectAttributes, "审批请休假申请成功");
		return "redirect:"+Global.getAdminPath()+"/holi/oaHolidayapply/listforcheck/?repage";
	}

}