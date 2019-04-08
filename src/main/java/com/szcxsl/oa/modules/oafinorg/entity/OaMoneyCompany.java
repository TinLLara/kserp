/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafinorg.entity;

import org.hibernate.validator.constraints.Length;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 财务组织维护Entity
 * @author Shi Lei
 * @version 2015-05-21
 */
public class OaMoneyCompany extends DataEntity<OaMoneyCompany> {
	
	private static final long serialVersionUID = 1L;
	private String companyid;		// 公司ID
	private String compname;		// 公司名称
	private String nativename;		// 简称
	private String region;		// 简介
	
	public OaMoneyCompany() {
		super();
	}

	public OaMoneyCompany(String id){
		super(id);
	}

	@Length(min=1, max=32, message="公司ID长度必须介于 1 和 32 之间")
	public String getCompanyid() {
		return companyid;
	}

	public void setCompanyid(String companyid) {
		this.companyid = companyid;
	}
	
	@Length(min=1, max=128, message="公司名称长度必须介于 1 和 128 之间")
	public String getCompname() {
		return compname;
	}

	public void setCompname(String compname) {
		this.compname = compname;
	}
	
	@Length(min=0, max=128, message="简称长度必须介于 0 和 128 之间")
	public String getNativename() {
		return nativename;
	}

	public void setNativename(String nativename) {
		this.nativename = nativename;
	}
	
	@Length(min=0, max=64, message="简介长度必须介于 0 和 64 之间")
	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}
	
}