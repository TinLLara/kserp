/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.custormer.web;

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
import com.szcxsl.oa.modules.custormer.entity.BusCustomer;
import com.szcxsl.oa.modules.custormer.service.BusCustomerService;

/**
 * 客户信息管理Controller
 * @author Tin
 * @version 2015-10-15
 */
@Controller
@RequestMapping(value = "${adminPath}/custormer/busCustomer")
public class BusCustomerController extends BaseController {

	@Autowired
	private BusCustomerService busCustomerService;
	
	@ModelAttribute
	public BusCustomer get(@RequestParam(required=false) String id) {
		BusCustomer entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = busCustomerService.get(id);
		}
		if (entity == null){
			entity = new BusCustomer();
		}
		return entity;
	}
	
	@RequiresPermissions("custormer:busCustomer:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusCustomer busCustomer, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusCustomer> page = busCustomerService.findPage(new Page<BusCustomer>(request, response), busCustomer); 
		model.addAttribute("page", page);
		return "modules/custormer/busCustomerList";
	}

	@RequiresPermissions("custormer:busCustomer:view")
	@RequestMapping(value = "form")
	public String form(BusCustomer busCustomer, Model model) {
		model.addAttribute("busCustomer", busCustomer);
		return "modules/custormer/busCustomerForm";
	}

	@RequiresPermissions("custormer:busCustomer:edit")
	@RequestMapping(value = "save")
	public String save(BusCustomer busCustomer, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, busCustomer)){
			return form(busCustomer, model);
		}
		busCustomerService.save(busCustomer);
		addMessage(redirectAttributes, "保存客户信息成功");
		return "redirect:"+Global.getAdminPath()+"/custormer/busCustomer/?repage";
	}
	
	@RequiresPermissions("custormer:busCustomer:edit")
	@RequestMapping(value = "delete")
	public String delete(BusCustomer busCustomer, RedirectAttributes redirectAttributes) {
		busCustomerService.delete(busCustomer);
		addMessage(redirectAttributes, "删除客户信息成功");
		return "redirect:"+Global.getAdminPath()+"/custormer/busCustomer/?repage";
	}

}