/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaflow.dao.oaflow;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.oaflow.entity.oaflow.OaFlow;

/**
 * 审批流程DAO接口
 * @author Shi Lei
 * @version 2015-06-02
 */
@MyBatisDao
public interface OaFlowDao extends CrudDao<OaFlow> {
	
}