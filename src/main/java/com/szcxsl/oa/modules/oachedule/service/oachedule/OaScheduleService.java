/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oachedule.service.oachedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.persistence.Page;
import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.oachedule.entity.oachedule.OaSchedule;
import com.szcxsl.oa.modules.oachedule.dao.oachedule.OaScheduleDao;

/**
 * 日程管理Service
 * @author Shi Lei
 * @version 2015-06-04
 */
@Service
@Transactional(readOnly = true)
public class OaScheduleService extends CrudService<OaScheduleDao, OaSchedule> {
	
	@Autowired
	private OaScheduleDao oaScheduleDao;

	public OaSchedule get(String id) {
		return super.get(id);
	}
	
	public List<OaSchedule> findList(OaSchedule oaSchedule) {
		return super.findList(oaSchedule);
	}
	
	public Page<OaSchedule> findPage(Page<OaSchedule> page, OaSchedule oaSchedule) {
		return super.findPage(page, oaSchedule);
	}
	
	@Transactional(readOnly = false)
	public void save(OaSchedule oaSchedule) {
		super.save(oaSchedule);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaSchedule oaSchedule) {
		super.delete(oaSchedule);
	}
	
	public Page<OaSchedule> findListforSelect(Page<OaSchedule> page,OaSchedule oaSchedule) {
		oaSchedule.setPage(page);
		page.setList(oaScheduleDao.findListforSelect(oaSchedule));
		return page;
	}
	
}