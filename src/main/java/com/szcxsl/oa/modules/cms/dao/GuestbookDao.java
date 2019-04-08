/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.cms.dao;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.cms.entity.Guestbook;

/**
 * 留言DAO接口
 * @author Shi Lei
 * @version 2013-8-23
 */
@MyBatisDao
public interface GuestbookDao extends CrudDao<Guestbook> {

}
