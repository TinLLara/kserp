/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.contatcts.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 名片/联系人信息管理Entity
 * @author Tin
 * @version 2015-10-19
 */
public class BusContact extends DataEntity<BusContact> {
	
	private static final long serialVersionUID = 1L;
	private Long contactid;		// 联系人ID
	private String lastname;		// 姓
	private String fristname;		// 名
	private String nativename;		// 中文名
	private String engname;		// 英文名
	private String sex;		// 性别
	private String email;		// 邮箱
	private String commutel;		// 手机号码
	private String commuphone;		// 办公电话
	private String fax;		// 传真
	private String website;		// 网址
	private String position;		// 联系人职位
	private String city;		// 所在城市
	private String contacttype;		// 联系人类型
	private String addr;		// 公司名称
	private String companyaddr;		// 公司地址
	private String note;		// 备注
	private String country;		// 所属国家
	
	public BusContact() {
		super();
	}

	public BusContact(String id){
		super(id);
	}

	@NotNull(message="联系人ID不能为空")
	public Long getContactid() {
		return contactid;
	}

	public void setContactid(Long contactid) {
		this.contactid = contactid;
	}
	
	@Length(min=0, max=16, message="姓长度必须介于 0 和 16 之间")
	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	
	@Length(min=0, max=16, message="名长度必须介于 0 和 16 之间")
	public String getFristname() {
		return fristname;
	}

	public void setFristname(String fristname) {
		this.fristname = fristname;
	}
	
	@Length(min=0, max=16, message="中文名长度必须介于 0 和 16 之间")
	public String getNativename() {
		return nativename;
	}

	public void setNativename(String nativename) {
		this.nativename = nativename;
	}
	
	@Length(min=0, max=64, message="英文名长度必须介于 0 和 64 之间")
	public String getEngname() {
		return engname;
	}

	public void setEngname(String engname) {
		this.engname = engname;
	}
	
	@Length(min=0, max=1, message="性别长度必须介于 0 和 1 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Length(min=0, max=128, message="邮箱长度必须介于 0 和 128 之间")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	@Length(min=0, max=128, message="手机号码长度必须介于 0 和 128 之间")
	public String getCommutel() {
		return commutel;
	}

	public void setCommutel(String commutel) {
		this.commutel = commutel;
	}
	
	@Length(min=0, max=64, message="办公电话长度必须介于 0 和 64 之间")
	public String getCommuphone() {
		return commuphone;
	}

	public void setCommuphone(String commuphone) {
		this.commuphone = commuphone;
	}
	
	@Length(min=0, max=64, message="传真长度必须介于 0 和 64 之间")
	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}
	
	@Length(min=0, max=64, message="网址长度必须介于 0 和 64 之间")
	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}
	
	@Length(min=0, max=64, message="联系人职位长度必须介于 0 和 64 之间")
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
	@Length(min=0, max=32, message="所在城市长度必须介于 0 和 32 之间")
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	@Length(min=0, max=16, message="联系人类型长度必须介于 0 和 16 之间")
	public String getContacttype() {
		return contacttype;
	}

	public void setContacttype(String contacttype) {
		this.contacttype = contacttype;
	}
	
	@Length(min=0, max=64, message="公司名称长度必须介于 0 和 64 之间")
	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	@Length(min=0, max=128, message="公司地址长度必须介于 0 和 128 之间")
	public String getCompanyaddr() {
		return companyaddr;
	}

	public void setCompanyaddr(String companyaddr) {
		this.companyaddr = companyaddr;
	}
	
	@Length(min=0, max=500, message="备注长度必须介于 0 和 500 之间")
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	@Length(min=0, max=32, message="所属国家长度必须介于 0 和 32 之间")
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	
}