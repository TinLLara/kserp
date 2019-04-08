/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.holi.dao;

import java.util.List;
import java.util.Map;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.holi.entity.OaHolidayapply;

/**
 * 请休假申请DAO接口
 * @author Tin Shi
 * @version 2015-04-28
 */
@MyBatisDao
public interface OaHolidayapplyDao extends CrudDao<OaHolidayapply> {
	
	/**
	 * get the list for checking.
	 * @param oaHolidayapply
	 * @return
	 */
	public List<OaHolidayapply> findCheckList(OaHolidayapply oaHolidayapply);
	
	/**
	 * when users added or updated a new application, just insert data into oa_flow. 
	 * @param paramMap
	 */
	public void insertFlow(Map paramMap);
	
	/**
	 * check the selected record.
	 * @param Map paramMap
	 */
	public void checkToAdd1(Map paramMap);
	public void checkToAdd2(Map paramMap);
	public void checkToUpdate1(Map paramMap);
	public void checkToAdd11(Map paramMap);
	public void check(Map paramMap);
}