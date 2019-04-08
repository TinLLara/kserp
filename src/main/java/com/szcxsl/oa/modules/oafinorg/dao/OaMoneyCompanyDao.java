/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafinorg.dao;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oafinorg.entity.OaMoneyCompany;

/**
 * 财务组织维护DAO接口
 * @author Shi Lei
 * @version 2015-05-21
 */
@MyBatisDao
public interface OaMoneyCompanyDao extends CrudDao<OaMoneyCompany> {
	/**
	 * provide the finacial organization list.
	 * @param oaMoneyCompany
	 * @return
	 */
	public List<OaMoneyCompany> findListforSelect(OaMoneyCompany oaMoneyCompany);
	
}