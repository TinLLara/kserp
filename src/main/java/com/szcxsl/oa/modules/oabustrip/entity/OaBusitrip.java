/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oabustrip.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 出差申请增删改查Entity
 * @author Shilei
 * @version 2015-03-25
 */
public class OaBusitrip extends DataEntity<OaBusitrip> {
	
	private static final long serialVersionUID = 1L;
	private String tripnum;		// 出差申请单号
	private String busitripid;		// 出差申请ID
	private Date applytime;		// 申请时间
	private String applyperson;		// 申请人
	private String belongdept;		// 所属部门
	private String staffnum;		// 员工编号
	private String startaddr;		// 出发地点
	private String endaddr;		// 目的地
	private Date startdate;		// 开始时间
	private Date enddate;		// 结束时间
	private String tripdays;		// 出差天数
	private String tripreason;		// 出差原因
	private String currency;		// 币种
	private String cashadvance;		// 预支现金
	private String cashadvancech;		// 预支现金大写
	private String urgenttel;		// 联系电话
	private String tripfile;		// 附件
	private String relatedpro;		// 相关项目
	private String nextnode;		// 下一处理环节
	private String nextnoder;		// 下一处理人
	private String starthour;		// starthour
	private String endhour;		// endhour
	private String workhelper;		// workhelper
	private String contactstyle;		// contactstyle
	private Date beginApplytime;		// 开始 申请时间
	private Date endApplytime;		// 结束 申请时间
	
	public OaBusitrip() {
		super();
	}

	public OaBusitrip(String id){
		super(id);
	}

	@Length(min=1, max=16, message="出差申请单号长度必须介于 1 和 16 之间")
	public String getTripnum() {
		return tripnum;
	}

	public void setTripnum(String tripnum) {
		this.tripnum = tripnum;
	}
	
	@Length(min=1, max=32, message="出差申请ID长度必须介于 1 和 32 之间")
	public String getBusitripid() {
		return busitripid;
	}

	public void setBusitripid(String busitripid) {
		this.busitripid = busitripid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="申请时间不能为空")
	public Date getApplytime() {
		return applytime;
	}

	public void setApplytime(Date applytime) {
		this.applytime = applytime;
	}
	
	@Length(min=1, max=64, message="申请人长度必须介于 1 和 64 之间")
	public String getApplyperson() {
		return applyperson;
	}

	public void setApplyperson(String applyperson) {
		this.applyperson = applyperson;
	}
	
	@Length(min=1, max=256, message="所属部门长度必须介于 1 和 256 之间")
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
	
	@Length(min=1, max=64, message="出发地点长度必须介于 1 和 64 之间")
	public String getStartaddr() {
		return startaddr;
	}

	public void setStartaddr(String startaddr) {
		this.startaddr = startaddr;
	}
	
	@Length(min=1, max=64, message="目的地长度必须介于 1 和 64 之间")
	public String getEndaddr() {
		return endaddr;
	}

	public void setEndaddr(String endaddr) {
		this.endaddr = endaddr;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="开始时间不能为空")
	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="结束时间不能为空")
	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	
	@Length(min=1, max=11, message="出差天数长度必须介于 1 和 11 之间")
	public String getTripdays() {
		return tripdays;
	}

	public void setTripdays(String tripdays) {
		this.tripdays = tripdays;
	}
	
	@Length(min=0, max=2000, message="出差原因长度必须介于 0 和 2000 之间")
	public String getTripreason() {
		return tripreason;
	}

	public void setTripreason(String tripreason) {
		this.tripreason = tripreason;
	}
	
	@Length(min=0, max=16, message="币种长度必须介于 0 和 16 之间")
	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	@Length(min=0, max=16, message="预支现金长度必须介于 0 和 16 之间")
	public String getCashadvance() {
		return cashadvance;
	}

	public void setCashadvance(String cashadvance) {
		this.cashadvance = cashadvance;
	}
	
	@Length(min=0, max=32, message="预支现金大写长度必须介于 0 和 32 之间")
	public String getCashadvancech() {
		return cashadvancech;
	}

	public void setCashadvancech(String cashadvancech) {
		this.cashadvancech = cashadvancech;
	}
	
	@Length(min=0, max=32, message="联系电话长度必须介于 0 和 32 之间")
	public String getUrgenttel() {
		return urgenttel;
	}

	public void setUrgenttel(String urgenttel) {
		this.urgenttel = urgenttel;
	}
	
	//@Length(min=0, max=1000, message="附件长度必须介于 0 和 1000 之间")
	public String getTripfile() {
		return tripfile;
	}

	public void setTripfile(String tripfile) {
		this.tripfile = tripfile;
	}
	
	@Length(min=0, max=32, message="相关项目长度必须介于 0 和 32 之间")
	public String getRelatedpro() {
		return relatedpro;
	}

	public void setRelatedpro(String relatedpro) {
		this.relatedpro = relatedpro;
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
	
	@Length(min=0, max=64, message="workhelper长度必须介于 0 和 64 之间")
	public String getWorkhelper() {
		return workhelper;
	}

	public void setWorkhelper(String workhelper) {
		this.workhelper = workhelper;
	}
	
	@Length(min=0, max=64, message="contactstyle长度必须介于 0 和 64 之间")
	public String getContactstyle() {
		return contactstyle;
	}

	public void setContactstyle(String contactstyle) {
		this.contactstyle = contactstyle;
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