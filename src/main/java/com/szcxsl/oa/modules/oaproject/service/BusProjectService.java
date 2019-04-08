/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.oaproject.entity.BusProject;
import com.szcxsl.oa.modules.oaproject.dao.BusProjectDao;

/**
 * 项目信息Service
 * @author Shi Lei
 * @version 2015-05-28
 */
@Service
@Transactional(readOnly = true)
public class BusProjectService extends CrudService<BusProjectDao, BusProject> {
	
	@Autowired
	private BusProjectDao busProjectDao;

	public BusProject get(String id) {
		return super.get(id);
	}
	
	public List<BusProject> findList(BusProject busProject) {
		return super.findList(busProject);
	}
	
	public Page<BusProject> findPage(Page<BusProject> page, BusProject busProject) {
		return super.findPage(page, busProject);
	}
	
	@Transactional(readOnly = false)
	public void save(BusProject busProject) {
		super.save(busProject);
	}
	
	@Transactional(readOnly = false)
	public void delete(BusProject busProject) {
		super.delete(busProject);
	}
	
	/*return the records for selecting*/
	public Page<BusProject> findListforSelect(Page<BusProject> page,BusProject busProject) {
		busProject.setPage(page);
		page.setList(busProjectDao.findListforSelect(busProject));
		return page;
	}
	
}