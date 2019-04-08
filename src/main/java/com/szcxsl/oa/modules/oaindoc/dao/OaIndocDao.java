/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaindoc.dao;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oaindoc.entity.OaIndoc;

/**
 * 内部公函申请DAO接口
 * @author Shi Lei
 * @version 2015-05-21
 */
@MyBatisDao
public interface OaIndocDao extends CrudDao<OaIndoc> {
	/**
	 * 
	 * @param oaIndoc
	 * @return
	 */
	public List<OaIndoc> findCheckIndocList(OaIndoc oaIndoc);
}