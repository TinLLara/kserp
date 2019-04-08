/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafee.dao;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oafee.entity.OaFee;

/**
 * 费用申请增删改查DAO接口
 * @author Shilei
 * @version 2015-04-08
 */
@MyBatisDao
public interface OaFeeDao extends CrudDao<OaFee> {
	/**
	 * get the records for checking.
	 * @param oaFee
	 * @return
	 */
	public List<OaFee> findCheckOafeeList(OaFee oaFee);
	
}