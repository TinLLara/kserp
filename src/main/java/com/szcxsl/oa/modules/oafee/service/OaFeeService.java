/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.oafee.entity.OaFee;
import com.szcxsl.oa.modules.oafee.dao.OaFeeDao;

/**
 * 费用申请增删改查Service
 * @author Shilei
 * @version 2015-04-08
 */
@Service
@Transactional(readOnly = true)
public class OaFeeService extends CrudService<OaFeeDao, OaFee> {
	
	@Autowired
	private OaFeeDao oaFeeDao;

	public OaFee get(String id) {
		return super.get(id);
	}
	
	public List<OaFee> findList(OaFee oaFee) {
		return super.findList(oaFee);
	}
	
	public Page<OaFee> findPage(Page<OaFee> page, OaFee oaFee) {
		return super.findPage(page, oaFee);
	}
	
	@Transactional(readOnly = false)
	public void save(OaFee oaFee) {
		super.save(oaFee);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaFee oaFee) {
		super.delete(oaFee);
	}
	
	/*return the records for checking*/
	public Page<OaFee> findCheckOafeeList(Page<OaFee> page,OaFee oaFee) {
		oaFee.setPage(page);
		page.setList(oaFeeDao.findCheckOafeeList(oaFee));
		return page;
	}
	
}