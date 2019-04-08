/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafinorg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.oafinorg.entity.OaMoneyCompany;
import com.szcxsl.oa.modules.oafinorg.dao.OaMoneyCompanyDao;

/**
 * 财务组织维护Service
 * @author Shi Lei
 * @version 2015-05-21
 */
@Service
@Transactional(readOnly = true)
public class OaMoneyCompanyService extends CrudService<OaMoneyCompanyDao, OaMoneyCompany> {

	
	@Autowired
	private OaMoneyCompanyDao oaMoneyCompanyDao;
	
	
	public OaMoneyCompany get(String id) {
		return super.get(id);
	}
	
	public List<OaMoneyCompany> findList(OaMoneyCompany oaMoneyCompany) {
		return super.findList(oaMoneyCompany);
	}
	
	public Page<OaMoneyCompany> findPage(Page<OaMoneyCompany> page, OaMoneyCompany oaMoneyCompany) {
		return super.findPage(page, oaMoneyCompany);
	}
	
	@Transactional(readOnly = false)
	public void save(OaMoneyCompany oaMoneyCompany) {
		super.save(oaMoneyCompany);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaMoneyCompany oaMoneyCompany) {
		super.delete(oaMoneyCompany);
	}
	
	public Page<OaMoneyCompany> findListforSelect(Page<OaMoneyCompany> page,OaMoneyCompany oaMoneyCompany) {
		oaMoneyCompany.setPage(page);
		page.setList(oaMoneyCompanyDao.findListforSelect(oaMoneyCompany));
		return page;
	}
	
}