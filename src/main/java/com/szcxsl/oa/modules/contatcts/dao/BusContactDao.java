/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.contatcts.dao;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.contatcts.entity.BusContact;

/**
 * 名片/联系人信息管理DAO接口
 * @author Tin
 * @version 2015-10-19
 */
@MyBatisDao
public interface BusContactDao extends CrudDao<BusContact> {
	
}