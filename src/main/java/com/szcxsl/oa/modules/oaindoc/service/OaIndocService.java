/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaindoc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.oaindoc.entity.OaIndoc;
import com.szcxsl.oa.modules.oaindoc.dao.OaIndocDao;

/**
 * 内部公函申请Service
 * @author Shi Lei
 * @version 2015-05-21
 */
@Service
@Transactional(readOnly = true)
public class OaIndocService extends CrudService<OaIndocDao, OaIndoc> {
	
	@Autowired
	private OaIndocDao oaIndocDao;

	public OaIndoc get(String id) {
		return super.get(id);
	}
	
	public List<OaIndoc> findList(OaIndoc oaIndoc) {
		return super.findList(oaIndoc);
	}
	
	public Page<OaIndoc> findPage(Page<OaIndoc> page, OaIndoc oaIndoc) {
		return super.findPage(page, oaIndoc);
	}
	
	@Transactional(readOnly = false)
	public void save(OaIndoc oaIndoc) {
		super.save(oaIndoc);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaIndoc oaIndoc) {
		super.delete(oaIndoc);
	}
	
	/*return the records for checking*/
	public Page<OaIndoc> findCheckIndocList(Page<OaIndoc> page,OaIndoc oaIndoc) {
		oaIndoc.setPage(page);
		page.setList(oaIndocDao.findCheckIndocList(oaIndoc));
		return page;
	}
	
}