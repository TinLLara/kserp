/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.gen.dao;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.gen.entity.GenTable;

/**
 * 业务表DAO接口
 * @author Shi Lei
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTableDao extends CrudDao<GenTable> {
	
}
