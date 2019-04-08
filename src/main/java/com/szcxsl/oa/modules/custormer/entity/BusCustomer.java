/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.custormer.entity;

import javax.validation.constraints.NotNull;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 客户信息管理Entity
 * @author Tin
 * @version 2015-10-15
 */
public class BusCustomer extends DataEntity<BusCustomer> {
	
	private static final long serialVersionUID = 1L;
	private Long customerid;		// 客户id
	private Date createtime;		// 创建时间
	private String creator;		// 创建人
	private String cname;		// 名称
	private String ctype;		// 类型
	private String carea;		// 所属地区
	private String address;		// 地址
	private String website;		// 主页
	private String ccomment;		// 客户简述
	private String belongto;		// 所属部门
	private String telphone;		// 联系电话
	
	public BusCustomer() {
		super();
	}

	public BusCustomer(String id){
		super(id);
	}

	//@NotNull(message="客户id不能为空")
	public Long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(Long customerid) {
		this.customerid = customerid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="创建时间不能为空")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	@Length(min=1, max=32, message="创建人长度必须介于 1 和 32 之间")
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	@Length(min=1, max=128, message="名称长度必须介于 1 和 128 之间")
	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}
	
	@Length(min=1, max=128, message="类型长度必须介于 1 和 128 之间")
	public String getCtype() {
		return ctype;
	}

	public void setCtype(String ctype) {
		this.ctype = ctype;
	}
	
	@Length(min=0, max=128, message="所属地区长度必须介于 0 和 128 之间")
	public String getCarea() {
		return carea;
	}

	public void setCarea(String carea) {
		this.carea = carea;
	}
	
	@Length(min=0, max=128, message="地址长度必须介于 0 和 128 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=128, message="主页长度必须介于 0 和 128 之间")
	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}
	
	@Length(min=0, max=5000, message="客户简述长度必须介于 0 和 5000 之间")
	public String getCcomment() {
		return ccomment;
	}

	public void setCcomment(String ccomment) {
		this.ccomment = ccomment;
	}
	
	@Length(min=1, max=64, message="所属部门长度必须介于 1 和 64 之间")
	public String getBelongto() {
		return belongto;
	}

	public void setBelongto(String belongto) {
		this.belongto = belongto;
	}
	
	@Length(min=0, max=32, message="联系电话长度必须介于 0 和 32 之间")
	public String getTelphone() {
		return telphone;
	}

	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	
}