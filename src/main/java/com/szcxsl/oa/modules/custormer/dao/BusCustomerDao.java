/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.custormer.dao;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.custormer.entity.BusCustomer;

/**
 * 客户信息管理DAO接口
 * @author Tin
 * @version 2015-10-15
 */
@MyBatisDao
public interface BusCustomerDao extends CrudDao<BusCustomer> {
	
}