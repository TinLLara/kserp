/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaproject.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 项目信息Entity
 * @author Shi Lei
 * @version 2015-05-28
 */
public class BusProject extends DataEntity<BusProject> {
	
	private static final long serialVersionUID = 1L;
	private String projectid;		// 项目id
	private String proname;		// 项目名称
	private Date createtime;		// 创建时间
	private String creator;		// 创建人
	private String procomm;		// 项目描述
	private String customerid;		// 客户ID
	private String customer;		// 客户
	private String customername;		// 客户名称
	private String dealperson;		// 审批人
	private String dealname;		// 审批人名称
	private String projectstate;		// projectstate
	private String pronum;		// pronum
	private Long belfield;		// belfield
	
	public BusProject() {
		super();
	}

	public BusProject(String id){
		super(id);
	}

	@Length(min=1, max=32, message="项目id长度必须介于 1 和 32 之间")
	public String getProjectid() {
		return projectid;
	}

	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}
	
	@Length(min=1, max=128, message="项目名称长度必须介于 1 和 128 之间")
	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@Length(min=0, max=32, message="创建人长度必须介于 0 和 32 之间")
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	@Length(min=0, max=5000, message="项目描述长度必须介于 0 和 5000 之间")
	public String getProcomm() {
		return procomm;
	}

	public void setProcomm(String procomm) {
		this.procomm = procomm;
	}
	
	@Length(min=0, max=32, message="客户ID长度必须介于 0 和 32 之间")
	public String getCustomerid() {
		return customerid;
	}

	public void setCustomerid(String customerid) {
		this.customerid = customerid;
	}
	
	@Length(min=0, max=64, message="客户长度必须介于 0 和 64 之间")
	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}
	
	@Length(min=0, max=128, message="客户名称长度必须介于 0 和 128 之间")
	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}
	
	@Length(min=0, max=32, message="审批人长度必须介于 0 和 32 之间")
	public String getDealperson() {
		return dealperson;
	}

	public void setDealperson(String dealperson) {
		this.dealperson = dealperson;
	}
	
	@Length(min=0, max=32, message="审批人名称长度必须介于 0 和 32 之间")
	public String getDealname() {
		return dealname;
	}

	public void setDealname(String dealname) {
		this.dealname = dealname;
	}
	
	@Length(min=0, max=20, message="projectstate长度必须介于 0 和 20 之间")
	public String getProjectstate() {
		return projectstate;
	}

	public void setProjectstate(String projectstate) {
		this.projectstate = projectstate;
	}
	
	@Length(min=0, max=16, message="pronum长度必须介于 0 和 16 之间")
	public String getPronum() {
		return pronum;
	}

	public void setPronum(String pronum) {
		this.pronum = pronum;
	}
	
	public Long getBelfield() {
		return belfield;
	}

	public void setBelfield(Long belfield) {
		this.belfield = belfield;
	}
	
}