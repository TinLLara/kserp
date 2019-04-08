/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oabustrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.oabustrip.entity.OaBusitrip;
import com.szcxsl.oa.modules.oabustrip.dao.OaBusitripDao;

/**
 * 出差申请增删改查Service
 * @author Shilei
 * @version 2015-03-25
 */
@Service
@Transactional(readOnly = true)
public class OaBusitripService extends CrudService<OaBusitripDao, OaBusitrip> {
	
	@Autowired
	private OaBusitripDao oaBusitripDao;
	
	public OaBusitrip get(String id) {
		return super.get(id);
	}
	
	public List<OaBusitrip> findList(OaBusitrip oaBusitrip) {
		return super.findList(oaBusitrip);
	}
	
	public Page<OaBusitrip> findPage(Page<OaBusitrip> page, OaBusitrip oaBusitrip) {
		return super.findPage(page, oaBusitrip);
	}
	
	public long findTripCount(String year) {
		return oaBusitripDao.findTripCount(year);
	}
	
	@Transactional(readOnly = false)
	public void save(OaBusitrip oaBusitrip) {
		super.save(oaBusitrip);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaBusitrip oaBusitrip) {
		super.delete(oaBusitrip);
	}
	
	/*return the records for checking*/
	public Page<OaBusitrip> findCheckTripList(Page<OaBusitrip> page,OaBusitrip oaBusitrip) {
		oaBusitrip.setPage(page);
		page.setList(oaBusitripDao.findCheckTripList(oaBusitrip));
		return page;
	}
	
}