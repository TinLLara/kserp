/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oachedule.entity.oachedule;

import org.hibernate.validator.constraints.Length;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 日程管理Entity
 * @author Shi Lei
 * @version 2015-06-04
 */
public class OaSchedule extends DataEntity<OaSchedule> {
	
	private static final long serialVersionUID = 1L;
	private String scheduleId;		// 日程编号
	private String title;		// 日程主题
	private String notes;		// 日程内容
	private String strattime;		// 开始时间
	private String endtime;		// 结束时间
	private String attachmentid;		// 附件编号
	private String eventid;		// 关联事件类型
	private String companyId;		// 关联公司项目
	private String creator;		// 创建人
	private String updater;		// 修改人
	private String scheduleDate;		// 日程日期
	private String remindflag;		// 是否提醒
	private String remindtime;		// 提醒时间
	private String remindrate;		// 提醒频率
	private String remindnumeric;		// 提醒次数
	private String eventtype;		// eventtype
	private String finishstatus;		// finishstatus
	private String allactor;		// 全部参与人
	private String allactorname;		// allactorname
	private String beginStrattime;		// 开始 开始时间
	private String endStrattime;		// 结束 开始时间
	
	public OaSchedule() {
		super();
	}

	public OaSchedule(String id){
		super(id);
	}

	@Length(min=1, max=32, message="日程编号长度必须介于 1 和 32 之间")
	public String getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(String scheduleId) {
		this.scheduleId = scheduleId;
	}
	
	@Length(min=0, max=100, message="日程主题长度必须介于 0 和 100 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=500, message="日程内容长度必须介于 0 和 500 之间")
	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}
	
	@Length(min=0, max=30, message="开始时间长度必须介于 0 和 30 之间")
	public String getStrattime() {
		return strattime;
	}

	public void setStrattime(String strattime) {
		this.strattime = strattime;
	}
	
	@Length(min=0, max=30, message="结束时间长度必须介于 0 和 30 之间")
	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	
	@Length(min=0, max=32, message="附件编号长度必须介于 0 和 32 之间")
	public String getAttachmentid() {
		return attachmentid;
	}

	public void setAttachmentid(String attachmentid) {
		this.attachmentid = attachmentid;
	}
	
	@Length(min=0, max=32, message="关联事件类型长度必须介于 0 和 32 之间")
	public String getEventid() {
		return eventid;
	}

	public void setEventid(String eventid) {
		this.eventid = eventid;
	}
	
	@Length(min=0, max=32, message="关联公司项目长度必须介于 0 和 32 之间")
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	
	@Length(min=0, max=32, message="创建人长度必须介于 0 和 32 之间")
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	@Length(min=0, max=32, message="修改人长度必须介于 0 和 32 之间")
	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}
	
	@Length(min=0, max=30, message="日程日期长度必须介于 0 和 30 之间")
	public String getScheduleDate() {
		return scheduleDate;
	}

	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	
	@Length(min=0, max=1, message="是否提醒长度必须介于 0 和 1 之间")
	public String getRemindflag() {
		return remindflag;
	}

	public void setRemindflag(String remindflag) {
		this.remindflag = remindflag;
	}
	
	@Length(min=0, max=30, message="提醒时间长度必须介于 0 和 30 之间")
	public String getRemindtime() {
		return remindtime;
	}

	public void setRemindtime(String remindtime) {
		this.remindtime = remindtime;
	}
	
	@Length(min=0, max=10, message="提醒频率长度必须介于 0 和 10 之间")
	public String getRemindrate() {
		return remindrate;
	}

	public void setRemindrate(String remindrate) {
		this.remindrate = remindrate;
	}
	
	@Length(min=0, max=1, message="提醒次数长度必须介于 0 和 1 之间")
	public String getRemindnumeric() {
		return remindnumeric;
	}

	public void setRemindnumeric(String remindnumeric) {
		this.remindnumeric = remindnumeric;
	}
	
	@Length(min=0, max=20, message="eventtype长度必须介于 0 和 20 之间")
	public String getEventtype() {
		return eventtype;
	}

	public void setEventtype(String eventtype) {
		this.eventtype = eventtype;
	}
	
	@Length(min=0, max=10, message="finishstatus长度必须介于 0 和 10 之间")
	public String getFinishstatus() {
		return finishstatus;
	}

	public void setFinishstatus(String finishstatus) {
		this.finishstatus = finishstatus;
	}
	
	@Length(min=0, max=500, message="全部参与人长度必须介于 0 和 500 之间")
	public String getAllactor() {
		return allactor;
	}

	public void setAllactor(String allactor) {
		this.allactor = allactor;
	}
	
	@Length(min=0, max=500, message="allactorname长度必须介于 0 和 500 之间")
	public String getAllactorname() {
		return allactorname;
	}

	public void setAllactorname(String allactorname) {
		this.allactorname = allactorname;
	}
	
	public String getBeginStrattime() {
		return beginStrattime;
	}

	public void setBeginStrattime(String beginStrattime) {
		this.beginStrattime = beginStrattime;
	}
	
	public String getEndStrattime() {
		return endStrattime;
	}

	public void setEndStrattime(String endStrattime) {
		this.endStrattime = endStrattime;
	}
		
}