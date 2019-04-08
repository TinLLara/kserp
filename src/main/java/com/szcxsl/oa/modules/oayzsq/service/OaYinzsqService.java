/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oayzsq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.oayzsq.entity.OaYinzsq;
import com.szcxsl.oa.modules.oayzsq.dao.OaYinzsqDao;

/**
 * 印章申请Service
 * @author Shi Lei
 * @version 2015-05-21
 */
@Service
@Transactional(readOnly = true)
public class OaYinzsqService extends CrudService<OaYinzsqDao, OaYinzsq> {
	
	@Autowired
	private OaYinzsqDao oaYinzsqDao;

	public OaYinzsq get(String id) {
		return super.get(id);
	}
	
	public List<OaYinzsq> findList(OaYinzsq oaYinzsq) {
		return super.findList(oaYinzsq);
	}
	
	public Page<OaYinzsq> findPage(Page<OaYinzsq> page, OaYinzsq oaYinzsq) {
		return super.findPage(page, oaYinzsq);
	}
	
	@Transactional(readOnly = false)
	public void save(OaYinzsq oaYinzsq) {
		super.save(oaYinzsq);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaYinzsq oaYinzsq) {
		super.delete(oaYinzsq);
	}
	
	/*return the records for checking*/
	public Page<OaYinzsq> findCheckYinzList(Page<OaYinzsq> page,OaYinzsq oaYinzsq) {
		oaYinzsq.setPage(page);
		page.setList(oaYinzsqDao.findCheckYinzList(oaYinzsq));
		return page;
	}
	
}