/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.custormer.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.custormer.entity.BusCustomer;
import com.szcxsl.oa.modules.custormer.dao.BusCustomerDao;

/**
 * 客户信息管理Service
 * @author Tin
 * @version 2015-10-15
 */
@Service
@Transactional(readOnly = true)
public class BusCustomerService extends CrudService<BusCustomerDao, BusCustomer> {

	public BusCustomer get(String id) {
		return super.get(id);
	}
	
	public List<BusCustomer> findList(BusCustomer busCustomer) {
		return super.findList(busCustomer);
	}
	
	public Page<BusCustomer> findPage(Page<BusCustomer> page, BusCustomer busCustomer) {
		return super.findPage(page, busCustomer);
	}
	
	@Transactional(readOnly = false)
	public void save(BusCustomer busCustomer) {
		super.save(busCustomer);
	}
	
	@Transactional(readOnly = false)
	public void delete(BusCustomer busCustomer) {
		super.delete(busCustomer);
	}
	
}