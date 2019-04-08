/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oachedule.web.oachedule;

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
import com.szcxsl.oa.modules.oachedule.entity.oachedule.OaSchedule;
import com.szcxsl.oa.modules.oachedule.service.oachedule.OaScheduleService;

/**
 * 日程管理Controller
 * @author Shi Lei
 * @version 2015-06-04
 */
@Controller
@RequestMapping(value = "${adminPath}/oachedule/oachedule/oaSchedule")
public class OaScheduleController extends BaseController {

	@Autowired
	private OaScheduleService oaScheduleService;
	
	@ModelAttribute
	public OaSchedule get(@RequestParam(required=false) String scheduleId) {
		OaSchedule entity = null;
		if (StringUtils.isNotBlank(scheduleId)){
			entity = oaScheduleService.get(scheduleId);
		}
		if (entity == null){
			entity = new OaSchedule();
		}
		return entity;
	}
	
	@RequiresPermissions("oachedule:oachedule:oaSchedule:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaSchedule oaSchedule, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaSchedule> page = oaScheduleService.findPage(new Page<OaSchedule>(request, response), oaSchedule); 
		model.addAttribute("page", page);
		return "modules/oachedule/oachedule/oaScheduleList";
	}

	@RequiresPermissions("oachedule:oachedule:oaSchedule:view")
	@RequestMapping(value = "form")
	public String form(OaSchedule oaSchedule, Model model) {
		model.addAttribute("oaSchedule", oaSchedule);
		return "modules/oachedule/oachedule/oaScheduleForm";
	}

	@RequiresPermissions("oachedule:oachedule:oaSchedule:edit")
	@RequestMapping(value = "save")
	public String save(OaSchedule oaSchedule, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, oaSchedule)){
			return form(oaSchedule, model);
		}
		oaScheduleService.save(oaSchedule);
		addMessage(redirectAttributes, "保存日程安排成功");
		return "redirect:"+Global.getAdminPath()+"/oachedule/oachedule/oaSchedule/?repage";
	}
	
	@RequiresPermissions("oachedule:oachedule:oaSchedule:edit")
	@RequestMapping(value = "delete")
	public String delete(OaSchedule oaSchedule, RedirectAttributes redirectAttributes) {
		oaScheduleService.delete(oaSchedule);
		addMessage(redirectAttributes, "删除日程安排成功");
		return "redirect:"+Global.getAdminPath()+"/oachedule/oachedule/oaSchedule/?repage";
	}
	
	@RequiresPermissions("oachedule:oachedule:oaSchedule:view")
	@RequestMapping(value = {"listforselect"})
	public String listforselect(OaSchedule oaSchedule, HttpServletRequest request, HttpServletResponse response, Model model) {
		String clickObjectName = request.getParameter("clickObjectName");
		model.addAttribute("clickObjectName",clickObjectName);
		Page<OaSchedule> page = oaScheduleService.findListforSelect(new Page<OaSchedule>(request, response), oaSchedule); 
		model.addAttribute("page", page);
		return "modules/oachedule/oachedule/oaScheduleForSelectList";
	}

}