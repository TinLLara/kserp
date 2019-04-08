/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oabustrip.dao;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oabustrip.entity.OaBusitrip;

/**
 * 出差申请增删改查DAO接口
 * @author Shilei
 * @version 2015-03-25
 */
@MyBatisDao
public interface OaBusitripDao extends CrudDao<OaBusitrip> {
	
	/**
	 * get the trip list's counts.
	 * @param year
	 * @return
	 */
	public long findTripCount(String year);
	
	public List<OaBusitrip> findCheckTripList(OaBusitrip oaBusitrip);
}