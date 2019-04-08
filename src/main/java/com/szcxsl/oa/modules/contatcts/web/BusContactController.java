/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.contatcts.web;

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
import com.szcxsl.oa.modules.contatcts.entity.BusContact;
import com.szcxsl.oa.modules.contatcts.service.BusContactService;

/**
 * 名片/联系人信息管理Controller
 * @author Tin
 * @version 2015-10-19
 */
@Controller
@RequestMapping(value = "${adminPath}/contatcts/busContact")
public class BusContactController extends BaseController {

	@Autowired
	private BusContactService busContactService;
	
	@ModelAttribute
	public BusContact get(@RequestParam(required=false) String id) {
		BusContact entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = busContactService.get(id);
		}
		if (entity == null){
			entity = new BusContact();
		}
		return entity;
	}
	
	@RequiresPermissions("contatcts:busContact:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusContact busContact, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusContact> page = busContactService.findPage(new Page<BusContact>(request, response), busContact); 
		model.addAttribute("page", page);
		return "modules/contatcts/busContactList";
	}

	@RequiresPermissions("contatcts:busContact:view")
	@RequestMapping(value = "form")
	public String form(BusContact busContact, Model model) {
		model.addAttribute("busContact", busContact);
		return "modules/contatcts/busContactForm";
	}

	@RequiresPermissions("contatcts:busContact:edit")
	@RequestMapping(value = "save")
	public String save(BusContact busContact, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, busContact)){
			return form(busContact, model);
		}
		busContactService.save(busContact);
		addMessage(redirectAttributes, "保存名片成功");
		return "redirect:"+Global.getAdminPath()+"/contatcts/busContact/?repage";
	}
	
	@RequiresPermissions("contatcts:busContact:edit")
	@RequestMapping(value = "delete")
	public String delete(BusContact busContact, RedirectAttributes redirectAttributes) {
		busContactService.delete(busContact);
		addMessage(redirectAttributes, "删除名片成功");
		return "redirect:"+Global.getAdminPath()+"/contatcts/busContact/?repage";
	}

}