/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oayzsq.dao;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oayzsq.entity.OaYinzsq;

/**
 * 印章申请DAO接口
 * @author Shi Lei
 * @version 2015-05-21
 */
@MyBatisDao
public interface OaYinzsqDao extends CrudDao<OaYinzsq> {
	
	/**
	 * 
	 * @param oaIndoc
	 * @return
	 */
	public List<OaYinzsq> findCheckYinzList(OaYinzsq oaYinzsq);
	
}