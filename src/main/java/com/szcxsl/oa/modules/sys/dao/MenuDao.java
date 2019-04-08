/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.sys.dao;

import java.util.List;

import com.szcxsl.oa.common.persistence.CrudDao;
import com.szcxsl.oa.common.persistence.annotation.MyBatisDao;
import com.szcxsl.oa.modules.sys.entity.Menu;

/**
 * 菜单DAO接口
 * @author Shi Lei
 * @version 2014-05-16
 */
@MyBatisDao
public interface MenuDao extends CrudDao<Menu> {

	public List<Menu> findByParentIdsLike(Menu menu);

	public List<Menu> findByUserId(Menu menu);
	
	public int updateParentIds(Menu menu);
	
	public int updateSort(Menu menu);
	
}
