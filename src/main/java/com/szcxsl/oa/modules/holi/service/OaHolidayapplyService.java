/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.holi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.holi.entity.OaHolidayapply;
import com.szcxsl.oa.modules.holi.dao.OaHolidayapplyDao;
import com.szcxsl.oa.modules.sys.entity.User;
import com.szcxsl.oa.modules.sys.dao.UserDao;


/**
 * 请休假申请Service
 * @author Tin Shi
 * @version 2015-04-28
 */
@Service
@Transactional(readOnly = true)
public class OaHolidayapplyService extends CrudService<OaHolidayapplyDao, OaHolidayapply> {
	
	@Autowired
	private OaHolidayapplyDao OaHolidayapplyDao;
	
	@Autowired
	private UserDao userDao;
	
	public OaHolidayapply get(String id) {
		return super.get(id);
	}
	
	public List<OaHolidayapply> findList(OaHolidayapply oaHolidayapply) {
		return super.findList(oaHolidayapply);
	}
	
	public Page<OaHolidayapply> findPage(Page<OaHolidayapply> page, OaHolidayapply oaHolidayapply) {
		return super.findPage(page, oaHolidayapply);
	}
	
	@Transactional(readOnly = false)
	public void save(OaHolidayapply oaHolidayapply) {
		super.save(oaHolidayapply);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaHolidayapply oaHolidayapply) {
		super.delete(oaHolidayapply);
	}
	
	@Transactional(readOnly = false)
	public void insertFlow(Map paramMap) {
		OaHolidayapplyDao.insertFlow(paramMap);
	}
	
	@Transactional(readOnly = false)
	public void checkToUpdate1(Map paramMap) {
		OaHolidayapplyDao.checkToUpdate1(paramMap);
	}
	
	/*return the records for checking*/
	public Page<OaHolidayapply> findCheckList(Page<OaHolidayapply> page,OaHolidayapply oaHolidayapply) {
		oaHolidayapply.setPage(page);
		page.setList(OaHolidayapplyDao.findCheckList(oaHolidayapply));
		return page;
	}
	
	/*return the records for selecting*/
	public Page<User> findListforSelect(Page<User> page,User user) {
		user.setPage(page);
		page.setList(userDao.findListforSelect(user));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void check(Map paramadd1,Map paramadd2,Map paramupdate1,Map paramadd11,String tag,String isfinished) {
		if("pass".equals(tag)){
			/**
			 * pass
			 */
			if("is".equals(isfinished)){
				/**
				 * finished
				 */
				OaHolidayapplyDao.checkToAdd1(paramadd1);
				OaHolidayapplyDao.checkToAdd2(paramadd2);
				OaHolidayapplyDao.checkToUpdate1(paramupdate1);
			}
			else{
				/**
				 * not
				 */
				OaHolidayapplyDao.checkToAdd1(paramadd1);
				OaHolidayapplyDao.checkToAdd2(paramadd2);
			}
		}
		else{
			/**
			 * refuse
			 */
			OaHolidayapplyDao.checkToAdd11(paramadd11);
			OaHolidayapplyDao.checkToUpdate1(paramupdate1);
		}
	}
	
}