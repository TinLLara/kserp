/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oachedule.dao.oachedule;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oachedule.entity.oachedule.OaSchedule;

/**
 * 日程管理DAO接口
 * @author Shi Lei
 * @version 2015-06-04
 */
@MyBatisDao
public interface OaScheduleDao extends CrudDao<OaSchedule> {
	/**
	 * 
	 * @param oaSchedule
	 * @return
	 */
	public List<OaSchedule> findListforSelect(OaSchedule oaSchedule);
	
}