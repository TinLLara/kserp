/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafee.web;

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
import com.szcxsl.oa.modules.oafee.entity.OaFee;
import com.szcxsl.oa.modules.otherfee.entity.OaOtherfee;
import com.szcxsl.oa.modules.oabustrip.entity.OaBusitrip;
import com.szcxsl.oa.modules.oafee.service.OaFeeService;
import com.szcxsl.oa.modules.oaflow.entity.oaflow.OaFlow;
import com.szcxsl.oa.modules.oaflow.dao.oaflow.OaFlowDao;
import com.szcxsl.oa.modules.otherfee.dao.OaOtherfeeDao;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Date;
import java.text.SimpleDateFormat;

import com.szcxsl.oa.common.utils.IdGen;
import com.szcxsl.oa.common.utils.DateUtils;
import com.szcxsl.oa.modules.sys.utils.UserUtils;
import com.szcxsl.oa.modules.holi.service.OaHolidayapplyService;
import com.szcxsl.oa.modules.oabustrip.service.OaBusitripService;

/**
 * 费用申请增删改查Controller
 * @author Shilei
 * @version 2015-04-08
 */
@Controller
@RequestMapping(value = "${adminPath}/oafee/oaFee")
public class OaFeeController extends BaseController {

	@Autowired
	private OaFeeService oaFeeService;
	
	@Autowired
	private OaHolidayapplyService oaHolidayapplyService;
	
	@Autowired
	private OaFlowDao oaFlowDao;
	
	@Autowired
	private OaOtherfeeDao oaOtherfeeDao;
	
	@Autowired
	private OaBusitripService oaBusitripService;
	
	@ModelAttribute
	public OaFee get(@RequestParam(required=false) String feeid) {
		OaFee entity = null;
		if (StringUtils.isNotBlank(feeid)){
			entity = oaFeeService.get(feeid);
		}
		if (entity == null){
			entity = new OaFee();
		}
		return entity;
	}
	
	@RequiresPermissions("oafee:oaFee:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaFee oaFee, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaFee> page = oaFeeService.findPage(new Page<OaFee>(request, response), oaFee); 
		String feecat = request.getParameter("feecat");
		model.addAttribute("page", page);
		model.addAttribute("feecat", feecat);
		return "modules/oafee/oaFeeList";
	}

	@RequiresPermissions("oafee:oaFee:view")
	@RequestMapping(value = "form")
	public String form(OaFee oaFee, Model model,@RequestParam(required=false) String tag) {
		
		String feecat = oaFee.getFeecat();
		if (StringUtils.isNotBlank(feecat)){
			if("ZD".equals(feecat)){
				model.addAttribute("oaFee", oaFee);
				if (StringUtils.isNotBlank(tag)){
					model.addAttribute("tagvalue", tag);
				}
				
				if("view".equals(tag)){
					/**
					 * find the oa_flow list for the relation_id.
					 */
					OaFlow oaFlow = new OaFlow();
					oaFlow.setRelationId(oaFee.getFeeid());
					List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
					model.addAttribute("flowList", flowList);
				}
				return "modules/oafee/oaFeeZDForm";
			}
			else if("QT".equals(feecat)){
				model.addAttribute("oaFee", oaFee);
				String feeidForQT = oaFee.getFeeid();
				if (StringUtils.isNotBlank(tag)){
					model.addAttribute("tagvalue", tag);
				}
				
				if("view".equals(tag)){
					/**
					 * find the oa_flow list for the relation_id.
					 */
					OaFlow oaFlow = new OaFlow();
					oaFlow.setRelationId(feeidForQT);
					List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
					model.addAttribute("flowList", flowList);
					
					List<OaOtherfee> otherfeeList = getOtherfee(feeidForQT);
					model.addAttribute("otherfeeList", otherfeeList);
				}
				
				return "modules/oafee/oaFeeQTForm";
			}
			else{
				/*get the trip string.*/
				String madestr = "";
				OaBusitrip busitripEntity = oaBusitripService.get(oaFee.getTriplist());
				if(busitripEntity!=null){
					String startDate = busitripEntity.getStartdate()+"";
					String endDate = busitripEntity.getEnddate()+"";
					String startAddr = busitripEntity.getStartaddr();
					String endAddr = busitripEntity.getEndaddr();
					String tripnum = busitripEntity.getTripnum();
					madestr = "(从"+startDate.substring(0, 10)+"至"+endDate.substring(0, 10)+") "+startAddr+">>"+endAddr+"["+tripnum+"]";
				}
				
				oaFee.setTriplist(madestr);
				
				model.addAttribute("oaFee", oaFee);
				if (StringUtils.isNotBlank(tag)){
					model.addAttribute("tagvalue", tag);
				}
				
				if("view".equals(tag)){
					/**
					 * find the oa_flow list for the relation_id.
					 */
					OaFlow oaFlow = new OaFlow();
					oaFlow.setRelationId(oaFee.getFeeid());
					List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
					model.addAttribute("flowList", flowList);
				}
				return "modules/oafee/oaFeeForm";
			}
		}
		else{
			/*get the trip string.*/
			String madestr = "";
			OaBusitrip busitripEntity = oaBusitripService.get(oaFee.getTriplist());
			if(busitripEntity!=null){
				String startDate = busitripEntity.getStartdate()+"";
				String endDate = busitripEntity.getEnddate()+"";
				String startAddr = busitripEntity.getStartaddr();
				String endAddr = busitripEntity.getEndaddr();
				String tripnum = busitripEntity.getTripnum();
				madestr = "(从"+startDate.substring(0, 10)+"至"+endDate.substring(0, 10)+") "+startAddr+">>"+endAddr+"["+tripnum+"]";
			}
			
			oaFee.setTriplist(madestr);
			
			model.addAttribute("oaFee", oaFee);
			if (StringUtils.isNotBlank(tag)){
				model.addAttribute("tagvalue", tag);
			}
			
			if("view".equals(tag)){
				/**
				 * find the oa_flow list for the relation_id.
				 */
				OaFlow oaFlow = new OaFlow();
				oaFlow.setRelationId(oaFee.getFeeid());
				List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
				model.addAttribute("flowList", flowList);
			}
			return "modules/oafee/oaFeeForm";
		}
	}

	@RequiresPermissions("oafee:oaFee:edit")
	@RequestMapping(value = "save")
	public String save(OaFee oaFee, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response,@RequestParam(required=false) String submit) {
		if (!beanValidator(model, oaFee)){
			return form(oaFee, model,"");
		}
		String feecat = request.getParameter("feecat");
		oaFee.setFeecat(feecat);
		String applyperson = oaFee.getApplyperson(); 
		String nextnoder = request.getParameter("nextnoder");
		String overtime = DateUtils.getDateTime();
		String loginName = UserUtils.getUser().getLoginName();
		String gemid = IdGen.uuid();
		String gemid2 = IdGen.uuid();
		String id = oaFee.getFeeid();
		String coper = request.getParameter("sendmail");
		
		Map paramadd2 = new HashMap();
		paramadd2.put("oaflowid", gemid);
		paramadd2.put("flowtype", "fybx");
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
		paramupdate1.put("table","oa_fee");
		paramupdate1.put("status","state");
		paramupdate1.put("tabid","feeid");
		paramupdate1.put("nextnode", "'unauth'");
		paramupdate1.put("id", "'"+id+"'");
		
		/*set the tag to call the insert or update method*/
		if("insert".equals(submit)){
			oaFee.setIsNewRecord(true);
		}
		else{
			oaFee.setIsNewRecord(false);
			oaFee.setId(id);
		}
		
		String [] feetypes = request.getParameterValues("feetypes[]");
		String [] happentimes = request.getParameterValues("ohappentime[]");
		String [] oldatms = request.getParameterValues("oldatms[]");
		String [] reasons = request.getParameterValues("reason[]");
		String [] currencys = request.getParameterValues("proid[]");
		if("QT".equals(feecat)){
			oaOtherfeeDao.delete(id);
			OaOtherfee oaOtherfee = new OaOtherfee();
			oaOtherfee.setFeeid(id);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			for(int i=0;i<feetypes.length;i++){
				System.out.println(happentimes[i]);
				try{
				oaOtherfee.setHaptime(sdf.parse(happentimes[i]));
				}catch(Exception ex){
					ex.printStackTrace();
				}
				oaOtherfee.setFeetype(feetypes[i]);
				oaOtherfee.setOldcash(oldatms[i]);
				oaOtherfee.setReason(reasons[i]);
				oaOtherfee.setAtmtype(currencys[i]);  //出差单号
				oaOtherfeeDao.insert(oaOtherfee);
			}
			
		}
		oaFeeService.save(oaFee);
		oaHolidayapplyService.checkToUpdate1(paramupdate1);
		addMessage(redirectAttributes, "保存费用成功");
		
		//model.addAttribute("feecat", feecat);
		return "redirect:"+Global.getAdminPath()+"/oafee/oaFee/?repage&feecat="+feecat;
	}
	
	@RequiresPermissions("oafee:oaFee:edit")
	@RequestMapping(value = "delete")
	public String delete(OaFee oaFee, RedirectAttributes redirectAttributes) {
		String feecat = oaFee.getFeecat();
		oaFeeService.delete(oaFee);
		addMessage(redirectAttributes, "删除费用成功");
		return "redirect:"+Global.getAdminPath()+"/oafee/oaFee/?repage&feecat="+feecat;
	}
	
	@RequiresPermissions("oafee:oaFee:view")
	@RequestMapping(value = {"listforcheck"})
	public String listforcheck(OaFee oaFee, HttpServletRequest request, HttpServletResponse response, Model model) {
		String feecat = request.getParameter("feecat");
		Page<OaFee> page = oaFeeService.findCheckOafeeList(new Page<OaFee>(request, response), oaFee); 
		model.addAttribute("page", page);
		model.addAttribute("feecat", feecat);
		return "modules/oafee/oaFeeCheckList";
	}
	
	@RequiresPermissions("oafee:oaFee:view")
	@RequestMapping(value = "formforcheck")
	public String formForCheck(OaFee oaFee, Model model,@RequestParam(required=false)String tag) {
		if (StringUtils.isNotBlank(tag)){
			model.addAttribute("tagvalue", tag);
		}
		
		/*get the trip string.*/
		String madestr = "";
		OaBusitrip busitripEntity = oaBusitripService.get(oaFee.getTriplist());
		if(busitripEntity!=null){
			String startDate = busitripEntity.getStartdate()+"";
			String endDate = busitripEntity.getEnddate()+"";
			String startAddr = busitripEntity.getStartaddr();
			String endAddr = busitripEntity.getEndaddr();
			String tripnum = busitripEntity.getTripnum();
			madestr = "(从"+startDate.substring(0, 10)+"至"+endDate.substring(0, 10)+") "+startAddr+">>"+endAddr+"["+tripnum+"]";
		}
		
		oaFee.setTriplist(madestr);
		/**
		 * find the oa_flow list for the relation_id.
		 */
		String feeidForCheck = oaFee.getFeeid();
		OaFlow oaFlow = new OaFlow();
		oaFlow.setRelationId(feeidForCheck);
		List<OaFlow> flowList  = oaFlowDao.findList(oaFlow); 
		model.addAttribute("flowList", flowList);
		model.addAttribute("oaFee", oaFee);
		String feecat = oaFee.getFeecat();
		if(!"".equals(feecat)&&feecat!=null){
			if("ZD".equals(feecat)){
				return "modules/oafee/oaFeeZDCheckForm";
			}
			else if("QT".equals(feecat)){
				List<OaOtherfee> otherfeeList = getOtherfee(feeidForCheck);
				model.addAttribute("otherfeeList", otherfeeList);
				return "modules/oafee/oaFeeQTCheckForm";
			}
			else{
				return "modules/oafee/oaFeeCheckForm";
			}
		}
		else
			return "modules/oafee/oaFeeCheckForm";
	}
	
	@RequiresPermissions("oafee:oaFee:edit")
	@RequestMapping(value = "check")
	public String check(OaFee oaFee, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		String tag = request.getParameter("tag");
		String remark = request.getParameter("remark");
		try{
			remark = java.net.URLDecoder.decode(remark, "UTF-8");
		}catch(Exception e){
			e.printStackTrace();
		}
		String applyperson = oaFee.getApplyperson(); 
		
		Map paramadd1 = null;
		Map paramadd2 = null;
		Map paramupdate1 = null;
		Map paramadd11 = null;
		String overtime = DateUtils.getDateTime();
		String loginName = UserUtils.getUser().getLoginName();
		String gemid = IdGen.uuid();
		String id = oaFee.getFeeid();
		
		if("pass".equals(tag)){
			String nextnoder = request.getParameter("operatorid");
			paramadd1 = new HashMap();
			paramadd2 = new HashMap();
			paramadd1.put("overtime", overtime);
			paramadd1.put("remark", remark);
			paramadd1.put("loginName", loginName);
			paramadd1.put("id", id);
			
			if(applyperson.equals(nextnoder)){
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "fybx");
				paramadd2.put("id", id);
				paramadd2.put("createtime", overtime);
				paramadd2.put("overtime", overtime);
				paramadd2.put("loginName", loginName);
				paramadd2.put("flowstate", "end");
				
				paramupdate1 = new HashMap();
				paramupdate1.put("table","oa_fee");
				paramupdate1.put("status","state");
				paramupdate1.put("tabid","feeid");
				paramupdate1.put("nextnode", "'authed'");
				paramupdate1.put("id", "'"+id+"'");
				oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"pass","is");
			}
			else{
				
				paramadd2.put("oaflowid", gemid);
				paramadd2.put("flowtype", "fybx");
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
			paramupdate1.put("table","oa_fee");
			paramupdate1.put("status","state");
			paramupdate1.put("tabid","feeid");
			paramupdate1.put("nextnode", "'refuse'");
			paramupdate1.put("id", "'"+id+"'");
			oaHolidayapplyService.check(paramadd1,paramadd2,paramupdate1,paramadd11,"refuse","is");
		}
		addMessage(redirectAttributes, "审批费用申请成功");
		String feecat = oaFee.getFeecat();
		return "redirect:"+Global.getAdminPath()+"/oafee/oaFee/listforcheck/?repage&feecat="+feecat;
	}
	
	public List<OaOtherfee> getOtherfee(String feeid){
		
		OaOtherfee oaOtherfee = new OaOtherfee();
		oaOtherfee.setFeeid(feeid);
		List<OaOtherfee> entityList = oaOtherfeeDao.findList(oaOtherfee);
		return entityList;
	}

}