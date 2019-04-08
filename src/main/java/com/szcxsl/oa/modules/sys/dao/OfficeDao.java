/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.sys.dao;

import com.szcxsl.oa.common.persistence.TreeDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * @author Shi Lei
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {
	
}
