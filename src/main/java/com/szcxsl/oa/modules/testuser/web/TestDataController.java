/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.testuser.web;

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
import com.szcxsl.oa.modules.testuser.entity.TestData;
import com.szcxsl.oa.modules.testuser.service.TestDataService;
import com.szcxsl.oa.common.mail.MailSenderInfo;
import com.szcxsl.oa.common.mail.SimpleMailSender;

/**
 * 测试Controller
 * @author tin
 * @version 2015-03-17
 */
@Controller
@RequestMapping(value = "${adminPath}/testuser/testData")
public class TestDataController extends BaseController {

	@Autowired
	private TestDataService testDataService;
	
	@ModelAttribute
	public TestData get(@RequestParam(required=false) String id) {
		TestData entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = testDataService.get(id);
		}
		if (entity == null){
			entity = new TestData();
		}
		return entity;
	}
	
	@RequiresPermissions("testuser:testData:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestData testData, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestData> page = testDataService.findPage(new Page<TestData>(request, response), testData); 
		model.addAttribute("page", page);
		return "modules/testuser/testDataList";
	}

	@RequiresPermissions("testuser:testData:view")
	@RequestMapping(value = "form")
	public String form(TestData testData, Model model) {
		model.addAttribute("testData", testData);
		return "modules/testuser/testDataForm";
	}

	@RequiresPermissions("testuser:testData:edit")
	@RequestMapping(value = "save")
	public String save(TestData testData, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testData)){
			return form(testData, model);
		}
		testDataService.save(testData);
		addMessage(redirectAttributes, "保存测试成功");
		MailSenderInfo mailInfo = new MailSenderInfo(); 
		  mailInfo.setMailServerHost("smtp.163.com"); 
		  mailInfo.setMailServerPort("25"); 
		  mailInfo.setValidate(true); 
		  mailInfo.setUserName("slei19881012@163.com"); 
		  mailInfo.setPassword("lei19881012");//您的邮箱密码 
		  mailInfo.setFromAddress("slei19881012@163.com"); 
		  mailInfo.setToAddress("286185834@qq.com"); 
		  mailInfo.setSubject("this is a mail test."); 
		  mailInfo.setContent("You have a new message."); 
	        //这个类主要来发送邮件
		  SimpleMailSender sms = new SimpleMailSender();
	      sms.sendTextMail(mailInfo);//发送文体格式 
		return "redirect:"+Global.getAdminPath()+"/testuser/testData/?repage";
	}
	
	@RequiresPermissions("testuser:testData:edit")
	@RequestMapping(value = "delete")
	public String delete(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.delete(testData);
		addMessage(redirectAttributes, "删除测试成功");
		return "redirect:"+Global.getAdminPath()+"/testuser/testData/?repage";
	}

}