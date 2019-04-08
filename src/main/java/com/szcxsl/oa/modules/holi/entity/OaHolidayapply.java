/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.holi.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 请休假申请Entity
 * @author Tin Shi
 * @version 2015-04-28
 */
public class OaHolidayapply extends DataEntity<OaHolidayapply> {
	
	private static final long serialVersionUID = 1L;
	private String happlyid;		// 申请ID
	private String applyperson;		// 申请人
	private Date applytime;		// 申请时间
	private String belongdept;		// 所属部门
	private String staffnum;		// 员工编号
	private String staffphone;		// 联系电话
	private String stafftel;		// 邮箱地址
	private String holidaytpye;		// 休假类型
	private Date starttime;		// 起始时间
	private Date endtime;		// 结束时间
	private String starthour;		// starthour
	private String endhour;		// endhour
	private String days;		// 天数
	private String reason;		// 请休假原因
	private String holidayfile;		// 附件
	private String nextnode;		// 下一处理环节
	private String nextnoder;		// 下一处理人
	private String sendto;		// sendto
	private String yholiday;		// 年假总天数
	private String yused;		// yused
	private String iholiday;		// iholiday
	private String iused;		// iused
	private String oused;		// 已休其他假
	private Date beginApplytime;		// 开始 申请时间
	private Date endApplytime;		// 结束 申请时间
	
	public OaHolidayapply() {
		super();
	}

	public OaHolidayapply(String id){
		super(id);
	}

	@Length(min=1, max=32, message="申请ID长度必须介于 1 和 32 之间")
	public String getHapplyid() {
		return happlyid;
	}

	public void setHapplyid(String happlyid) {
		this.happlyid = happlyid;
	}
	
	@Length(min=1, max=16, message="申请人长度必须介于 1 和 16 之间")
	public String getApplyperson() {
		return applyperson;
	}

	public void setApplyperson(String applyperson) {
		this.applyperson = applyperson;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="申请时间不能为空")
	public Date getApplytime() {
		return applytime;
	}

	public void setApplytime(Date applytime) {
		this.applytime = applytime;
	}
	
	@Length(min=1, max=64, message="所属部门长度必须介于 1 和 64 之间")
	public String getBelongdept() {
		return belongdept;
	}

	public void setBelongdept(String belongdept) {
		this.belongdept = belongdept;
	}
	
	@Length(min=0, max=32, message="员工编号长度必须介于 0 和 32 之间")
	public String getStaffnum() {
		return staffnum;
	}

	public void setStaffnum(String staffnum) {
		this.staffnum = staffnum;
	}
	
	@Length(min=0, max=16, message="联系电话长度必须介于 0 和 16 之间")
	public String getStaffphone() {
		return staffphone;
	}

	public void setStaffphone(String staffphone) {
		this.staffphone = staffphone;
	}
	
	@Length(min=0, max=64, message="邮箱地址长度必须介于 0 和 64 之间")
	public String getStafftel() {
		return stafftel;
	}

	public void setStafftel(String stafftel) {
		this.stafftel = stafftel;
	}
	
	@Length(min=0, max=16, message="休假类型长度必须介于 0 和 16 之间")
	public String getHolidaytpye() {
		return holidaytpye;
	}

	public void setHolidaytpye(String holidaytpye) {
		this.holidaytpye = holidaytpye;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="申请时间不能为空")
	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="申请时间不能为空")
	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	
	@Length(min=0, max=16, message="starthour长度必须介于 0 和 16 之间")
	public String getStarthour() {
		return starthour;
	}

	public void setStarthour(String starthour) {
		this.starthour = starthour;
	}
	
	@Length(min=0, max=16, message="endhour长度必须介于 0 和 16 之间")
	public String getEndhour() {
		return endhour;
	}

	public void setEndhour(String endhour) {
		this.endhour = endhour;
	}
	
	@Length(min=1, max=11, message="天数长度必须介于 1 和 11 之间")
	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}
	
	@Length(min=0, max=2000, message="请休假原因长度必须介于 0 和 2000 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	@Length(min=0, max=1000, message="附件长度必须介于 0 和 1000 之间")
	public String getHolidayfile() {
		return holidayfile;
	}

	public void setHolidayfile(String holidayfile) {
		this.holidayfile = holidayfile;
	}
	
	@Length(min=0, max=32, message="下一处理环节长度必须介于 0 和 32 之间")
	public String getNextnode() {
		return nextnode;
	}

	public void setNextnode(String nextnode) {
		this.nextnode = nextnode;
	}
	
	@Length(min=0, max=32, message="下一处理人长度必须介于 0 和 32 之间")
	public String getNextnoder() {
		return nextnoder;
	}

	public void setNextnoder(String nextnoder) {
		this.nextnoder = nextnoder;
	}
	
	@Length(min=0, max=128, message="sendto长度必须介于 0 和 128 之间")
	public String getSendto() {
		return sendto;
	}

	public void setSendto(String sendto) {
		this.sendto = sendto;
	}
	
	@Length(min=0, max=32, message="年假总天数长度必须介于 0 和 32 之间")
	public String getYholiday() {
		return yholiday;
	}

	public void setYholiday(String yholiday) {
		this.yholiday = yholiday;
	}
	
	@Length(min=1, max=32, message="yused长度必须介于 1 和 32 之间")
	public String getYused() {
		return yused;
	}

	public void setYused(String yused) {
		this.yused = yused;
	}
	
	@Length(min=1, max=32, message="iholiday长度必须介于 1 和 32 之间")
	public String getIholiday() {
		return iholiday;
	}

	public void setIholiday(String iholiday) {
		this.iholiday = iholiday;
	}
	
	@Length(min=1, max=32, message="iused长度必须介于 1 和 32 之间")
	public String getIused() {
		return iused;
	}

	public void setIused(String iused) {
		this.iused = iused;
	}
	
	@Length(min=1, max=32, message="已休其他假长度必须介于 1 和 32 之间")
	public String getOused() {
		return oused;
	}

	public void setOused(String oused) {
		this.oused = oused;
	}
	
	public Date getBeginApplytime() {
		return beginApplytime;
	}

	public void setBeginApplytime(Date beginApplytime) {
		this.beginApplytime = beginApplytime;
	}
	
	public Date getEndApplytime() {
		return endApplytime;
	}

	public void setEndApplytime(Date endApplytime) {
		this.endApplytime = endApplytime;
	}
		
}