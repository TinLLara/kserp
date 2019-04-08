/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafinorg.web;

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
import com.szcxsl.oa.modules.oafinorg.entity.OaMoneyCompany;
import com.szcxsl.oa.modules.oafinorg.service.OaMoneyCompanyService;
import com.szcxsl.oa.common.utils.IdGen;


/**
 * 财务组织维护Controller
 * @author Shi Lei
 * @version 2015-05-21
 */
@Controller
@RequestMapping(value = "${adminPath}/oafinorg/oaMoneyCompany")
public class OaMoneyCompanyController extends BaseController {

	@Autowired
	private OaMoneyCompanyService oaMoneyCompanyService;
	
	@ModelAttribute
	public OaMoneyCompany get(@RequestParam(required=false) String companyid) {
		OaMoneyCompany entity = null;
		if (StringUtils.isNotBlank(companyid)){
			entity = oaMoneyCompanyService.get(companyid);
		}
		if (entity == null){
			entity = new OaMoneyCompany();
		}
		return entity;
	}
	
	@RequiresPermissions("oafinorg:oaMoneyCompany:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaMoneyCompany oaMoneyCompany, HttpServletRequest request, HttpServletResponse response, Model model,@RequestParam(required=false) String from) {
		
		Page<OaMoneyCompany> page = oaMoneyCompanyService.findPage(new Page<OaMoneyCompany>(request, response), oaMoneyCompany); 
		model.addAttribute("page", page);
		if("select".equals(from)){
			String clickObjectName = request.getParameter("clickObjectName");
			String clickObjectId = request.getParameter("clickObjectId");
			model.addAttribute("clickObjectName",clickObjectName);
			model.addAttribute("clickObjectId", clickObjectId);
			return "modules/oafinorg/oaMoneyCompanyForSelectList";
		}
		else
			return "modules/oafinorg/oaMoneyCompanyList";
	}

	@RequiresPermissions("oafinorg:oaMoneyCompany:view")
	@RequestMapping(value = "form")
	public String form(OaMoneyCompany oaMoneyCompany, Model model) {
		model.addAttribute("oaMoneyCompany", oaMoneyCompany);
		return "modules/oafinorg/oaMoneyCompanyForm";
	}

	@RequiresPermissions("oafinorg:oaMoneyCompany:edit")
	@RequestMapping(value = "save")
	public String save(OaMoneyCompany oaMoneyCompany, Model model, RedirectAttributes redirectAttributes,@RequestParam(required=false) String submit) {
		if (!beanValidator(model, oaMoneyCompany)){
			return form(oaMoneyCompany, model);
		}
		String companyId = oaMoneyCompany.getCompanyid();
		if("insert".equals(submit)){
			oaMoneyCompany.setIsNewRecord(true);
		}
		else{
			oaMoneyCompany.setIsNewRecord(false);
			oaMoneyCompany.setId(companyId);
		}
		oaMoneyCompanyService.save(oaMoneyCompany);
		addMessage(redirectAttributes, "保存财务组织成功");
		return "redirect:"+Global.getAdminPath()+"/oafinorg/oaMoneyCompany/?repage";
	}
	
	@RequiresPermissions("oafinorg:oaMoneyCompany:edit")
	@RequestMapping(value = "delete")
	public String delete(OaMoneyCompany oaMoneyCompany, RedirectAttributes redirectAttributes) {
		oaMoneyCompanyService.delete(oaMoneyCompany);
		addMessage(redirectAttributes, "删除财务组织成功");
		return "redirect:"+Global.getAdminPath()+"/oafinorg/oaMoneyCompany/?repage";
	}
	
	@RequiresPermissions("oafinorg:oaMoneyCompany:view")
	@RequestMapping(value = {"listforselect"})
	public String listforselect(OaMoneyCompany oaMoneyCompany, HttpServletRequest request, HttpServletResponse response, Model model) {
		String clickObjectName = request.getParameter("clickObjectName");
		String clickObjectId = request.getParameter("clickObjectId");
		model.addAttribute("clickObjectName",clickObjectName);
		model.addAttribute("clickObjectId", clickObjectId);
		Page<OaMoneyCompany> page = oaMoneyCompanyService.findListforSelect(new Page<OaMoneyCompany>(request, response), oaMoneyCompany); 
		model.addAttribute("page", page);
		return "modules/oafinorg/oaMoneyCompanyForSelectList";
	}

}