/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaproject.web;

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
import com.szcxsl.oa.modules.oaproject.entity.BusProject;
import com.szcxsl.oa.modules.oaproject.service.BusProjectService;

/**
 * 项目信息Controller
 * @author Shi Lei
 * @version 2015-05-28
 */
@Controller
@RequestMapping(value = "${adminPath}/oaproject/busProject")
public class BusProjectController extends BaseController {

	@Autowired
	private BusProjectService busProjectService;
	
	@ModelAttribute
	public BusProject get(@RequestParam(required=false) String id) {
		BusProject entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = busProjectService.get(id);
		}
		if (entity == null){
			entity = new BusProject();
		}
		return entity;
	}
	
	@RequiresPermissions("oaproject:busProject:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusProject busProject, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusProject> page = busProjectService.findPage(new Page<BusProject>(request, response), busProject); 
		model.addAttribute("page", page);
		return "modules/oaproject/busProjectList";
	}

	@RequiresPermissions("oaproject:busProject:view")
	@RequestMapping(value = "form")
	public String form(BusProject busProject, Model model) {
		model.addAttribute("busProject", busProject);
		return "modules/oaproject/busProjectForm";
	}

	@RequiresPermissions("oaproject:busProject:edit")
	@RequestMapping(value = "save")
	public String save(BusProject busProject, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, busProject)){
			return form(busProject, model);
		}
		busProjectService.save(busProject);
		addMessage(redirectAttributes, "保存项目信息成功");
		return "redirect:"+Global.getAdminPath()+"/oaproject/busProject/?repage";
	}
	
	@RequiresPermissions("oaproject:busProject:edit")
	@RequestMapping(value = "delete")
	public String delete(BusProject busProject, RedirectAttributes redirectAttributes) {
		busProjectService.delete(busProject);
		addMessage(redirectAttributes, "删除项目信息成功");
		return "redirect:"+Global.getAdminPath()+"/oaproject/busProject/?repage";
	}
	
	@RequiresPermissions("oaproject:busProject:view")
	@RequestMapping(value = {"listforselect"})
	public String listforselect(BusProject busProject, HttpServletRequest request, HttpServletResponse response, Model model) {
		String clickObjectName = request.getParameter("clickObjectName");
		String clickObjectId = request.getParameter("clickObjectId");
		model.addAttribute("clickObjectName",clickObjectName);
		model.addAttribute("clickObjectId", clickObjectId);
		//Page<BusProject> page = busProjectService.findListforSelect(new Page<BusProject>(request, response), busProject); 
		Page<BusProject> page = busProjectService.findPage(new Page<BusProject>(request, response), busProject); 
		model.addAttribute("page", page);
		return "modules/oaproject/busProjectListforselect";
	}

}