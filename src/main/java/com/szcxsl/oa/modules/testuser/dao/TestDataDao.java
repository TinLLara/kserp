/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.testuser.dao;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.testuser.entity.TestData;

/**
 * 测试DAO接口
 * @author tin
 * @version 2015-03-17
 */
@MyBatisDao
public interface TestDataDao extends CrudDao<TestData> {
	
}