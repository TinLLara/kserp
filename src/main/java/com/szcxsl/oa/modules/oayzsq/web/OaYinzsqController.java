/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oayzsq.web;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

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
import com.szcxsl.oa.common.utils.IdGen;
import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.web.BaseController;
import com.szcxsl.oa.common.utils.StringUtils;
import com.szcxsl.oa.common.utils.DateUtils;
import com.szcxsl.oa.modules.sys.utils.UserUtils;
import com.szcxsl.oa.modules.oaflow.entity.oaflow.OaFlow;
import com.szcxsl.oa.modules.oaflow.dao.oaflow.OaFlowDao;
import com.szcxsl.oa.modules.oayzsq.entity.OaYinzsq;
import com.szcxsl.oa.modules.oayzsq.service.OaYinzsqService;
import com.szcxsl.oa.modules.holi.service.OaHolidayapplyService;

/**
 * 印章申请Controller
 * @author Shi Lei
 * @version 2015-05-21
 */
@Controller
@RequestMapping(value = "${adminPath}/oayzsq/oaYinzsq")
public class OaYinzsqController extends BaseController {

	@Autowired
	private OaYinzsqService oaYinzsqService;
	
	@Autowired
	private OaHolidayapplyService oaHolidayapplyService;
	
	@Autowired
	private OaFlowDao oaFlowDao;
	
	@ModelAttribute
	public OaYinzsq get(@RequestParam(required=false) String id) {
		OaYinzsq entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = oaYinzsqService.get(id);
		}
		if (entity == null){
			entity = new OaYinzsq();
		}
		return entity;
	}
	
	@RequiresPermissions("oayzsq:oaYinzsq:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaYinzsq oaYinzsq, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaYinzsq> page = oaYinzsqService.findPage(new Page<OaYinzsq>(request, response), oaYinzsq); 
		model.addAttribute("page", page);
		return "modules/oayzsq/oaYinzsqList";
	}

	@RequiresPermissions("oayzsq:oaYinzsq:view")
	@RequestMapping(value = "form")
	public String form(OaYinzsq oaYinzsq, Model model,@RequestParam(required=false) String tag) {
		model.addAttribute("oaYinzsq", oaYinzsq);
		if (StringUtils.isNotBlank(tag)){
			model.addAttribute("tagvalue", tag);
		}
		if("view".equals(tag)){
			/**
			 * find the oa_flow list for the relation_id.
			 */
			OaFlow oaFlow = new OaFlow();
			oaFlow.setRelationId(oaYinzsq.getId());
			List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
			model.addAttribute("flowList", flowList);
		}
		return "modules/oayzsq/oaYinzsqForm";
	}

	@RequiresPermissions("oayzsq:oaYinzsq:edit")
	@RequestMapping(value = "save")
	public String save(OaYinzsq oaYinzsq, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response,@RequestParam(required=false) String submit) {
		if (!beanValidator(model, oaYinzsq)){
			return form(oaYinzsq, model,"");
		}
		
		String applyperson = oaYinzsq.getCreator(); 
		String nextnoder = request.getParameter("nextoper");
		String overtime = DateUtils.getDateTime();
		String loginName = UserUtils.getUser().getLoginName();
		String gemid = IdGen.uuid();
		String gemid2 = IdGen.uuid();
		String id = oaYinzsq.getId();
		String coper = request.getParameter("mailcopier");
		String type = oaYinzsq.getType();
		String [] types = null;
		types = type.split(",");
		
		String typetext = "";
		for(int i=0;i<types.length;i++){
			
			if(types[i].trim().toLowerCase().equals("gz")){
				typetext += "公章、";
			}else if(types[i].trim().toLowerCase().equals("cw")){
				typetext += "财务章、";
			}else if(types[i].trim().toLowerCase().equals("fr")){
				typetext += "法人签章、";
			}else if(types[i].trim().toLowerCase().equals("qt")){
				typetext += "其他、";
			}
		}
		if(typetext.length()>0){
			typetext = typetext.substring(0, typetext.length()-1);
		}
		
		oaYinzsq.setFilename(typetext);
		Map paramadd2 = new HashMap();
		paramadd2.put("oaflowid", gemid);
		paramadd2.put("flowtype", "yzsq");
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
		paramupdate1.put("table","oa_yinzsq");
		paramupdate1.put("status","nextop");
		paramupdate1.put("tabid","id");
		paramupdate1.put("nextnode", "'unauth'");
		paramupdate1.put("id", "'"+id+"'");
		
		/*set the tag to call the insert or update method*/
		if("insert".equals(submit)){
			oaYinzsq.setIsNewRecord(true);
		}
		/*else{
			oaYinzsq.setIsNewRecord(false);
			oaYinzsq.setId(id);
		}*/
		
		oaYinzsqService.save(oaYinzsq);
		oaHolidayapplyService.checkToUpdate1(paramupdate1);
		addMessage(redirectAttributes, "保存印章申请成功");
		return "redirect:"+Global.getAdminPath()+"/oayzsq/oaYinzsq/?repage";
	}
	
	@RequiresPermissions("oayzsq:oaYinzsq:edit")
	@RequestMapping(value = "delete")
	public String delete(OaYinzsq oaYinzsq, RedirectAttributes redirectAttributes) {
		oaYinzsqService.delete(oaYinzsq);
		addMessage(redirectAttributes, "删除印章申请成功");
		return "redirect:"+Global.getAdminPath()+"/oayzsq/oaYinzsq/?repage";
	}
	
	@RequiresPermissions("oayzsq:oaYinzsq:view")
	@RequestMapping(value = {"listforcheck"})
	public String listforcheck(OaYinzsq oaYinzsq, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaYinzsq> page = oaYinzsqService.findCheckYinzList(new Page<OaYinzsq>(request, response), oaYinzsq); 
		model.addAttribute("page", page);
		return "modules/oayzsq/oaYinzsqCheckList";
	}
	
	@RequiresPermissions("oayzsq:oaYinzsq:view")
	@RequestMapping(value = "formforcheck")
	public String formForCheck(OaYinzsq oaYinzsq, Model model,@RequestParam(required=false)String tag) {
		if (StringUtils.isNotBlank(tag)){
			model.addAttribute("tagvalue", tag);
		}
		/**
		 * find the oa_flow list for the relation_id.
		 */
		OaFlow oaFlow = new OaFlow();
		oaFlow.setRelationId(oaYinzsq.getId());
		List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
		model.addAttribute("flowList", flowList);
		model.addAttribute("oaYinzsq", oaYinzsq);
		return "modules/oayzsq/oaYinzsqCheckForm";
	}
	
	@RequiresPermissions("oayzsq:oaYinzsq:edit")
	@RequestMapping(value = "check")
	public String check(OaYinzsq oaYinzsq, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		String tag = request.getParameter("tag");
		String remark = request.getParameter("remark");
		try{
			remark = java.net.URLDecoder.decode(remark, "UTF-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		String applyperson = oaYinzsq.getCreator(); 
		
		Map paramadd1 = null;
		Map paramadd2 = null;
		Map paramupdate1 = null;
		Map paramadd11 = null;
		String overtime = DateUtils.getDateTime();
		String loginName = UserUtils.getUser().getLoginName();
		String gemid = IdGen.uuid();
		String id = oaYinzsq.getId();
		String nextnoder = request.getParameter("nextoper");
		
		if("pass".equals(tag)){
			
			paramadd1 = new HashMap();
			paramadd2 = new HashMap();
			paramadd1.put("overtime", overtime);
			paramadd1.put("remark", remark);
			paramadd1.put("loginName", loginName);
			paramadd1.put("id", id);
			
			if(applyperson.equals(nextnoder)){
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "yzsq");
				paramadd2.put("id", id);
				paramadd2.put("createtime", overtime);
				paramadd2.put("overtime", overtime);
				paramadd2.put("loginName", loginName);
				paramadd2.put("flowstate", "end");
				
				paramupdate1 = new HashMap();
				paramupdate1.put("table","oa_yinzsq");
				paramupdate1.put("status","nextop");
				paramupdate1.put("tabid","id");
				paramupdate1.put("nextnode", "'authed'");
				paramupdate1.put("id", "'"+id+"'");
				oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"pass","is");
			}
			else{
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "yzsq");
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
			paramupdate1.put("table","oa_yinzsq");
			paramupdate1.put("status","nextop");
			paramupdate1.put("tabid","id");
			paramupdate1.put("nextnode", "'refuse'");
			paramupdate1.put("id", "'"+id+"'");
			oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"refuse","is");
		}
		addMessage(redirectAttributes, "审批印章申请成功");
		return "redirect:"+Global.getAdminPath()+"/oayzsq/oaYinzsq/listforcheck/?repage";
	}

}