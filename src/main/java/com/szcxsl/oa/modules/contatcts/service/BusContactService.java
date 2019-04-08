/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.contatcts.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.contatcts.entity.BusContact;
import com.szcxsl.oa.modules.contatcts.dao.BusContactDao;

/**
 * 名片/联系人信息管理Service
 * @author Tin
 * @version 2015-10-19
 */
@Service
@Transactional(readOnly = true)
public class BusContactService extends CrudService<BusContactDao, BusContact> {

	public BusContact get(String id) {
		return super.get(id);
	}
	
	public List<BusContact> findList(BusContact busContact) {
		return super.findList(busContact);
	}
	
	public Page<BusContact> findPage(Page<BusContact> page, BusContact busContact) {
		return super.findPage(page, busContact);
	}
	
	@Transactional(readOnly = false)
	public void save(BusContact busContact) {
		super.save(busContact);
	}
	
	@Transactional(readOnly = false)
	public void delete(BusContact busContact) {
		super.delete(busContact);
	}
	
}