/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaproject.dao;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oaproject.entity.BusProject;

/**
 * 项目信息DAO接口
 * @author Shi Lei
 * @version 2015-05-28
 */
@MyBatisDao
public interface BusProjectDao extends CrudDao<BusProject> {
	
	/**
	 * 选取用户作为操作对象
	 * @param busProject
	 * @return
	 */
	public List<BusProject> findListforSelect(BusProject busProject);
	
}