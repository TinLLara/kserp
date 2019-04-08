/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.otherfee.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 其他费用附表信息Entity
 * @author Shi Lei
 * @version 2015-06-04
 */
public class OaOtherfee extends DataEntity<OaOtherfee> {
	
	private static final long serialVersionUID = 1L;
	private String feeid;		// 费用id
	private Date haptime;		// 发生时间
	private String feetype;		// 费用类型
	private String atmtype;		// 币种
	private String oldcash;		// 原币金额
	private String checkcash;		// 核定金额
	private String reason;		// 备注
	
	public OaOtherfee() {
		super();
	}

	public OaOtherfee(String id){
		super(id);
	}

	@Length(min=1, max=32, message="费用id长度必须介于 1 和 32 之间")
	public String getFeeid() {
		return feeid;
	}

	public void setFeeid(String feeid) {
		this.feeid = feeid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="发生时间不能为空")
	public Date getHaptime() {
		return haptime;
	}

	public void setHaptime(Date haptime) {
		this.haptime = haptime;
	}
	
	@Length(min=1, max=16, message="费用类型长度必须介于 1 和 16 之间")
	public String getFeetype() {
		return feetype;
	}

	public void setFeetype(String feetype) {
		this.feetype = feetype;
	}
	
	@Length(min=0, max=255, message="币种长度必须介于 0 和 255 之间")
	public String getAtmtype() {
		return atmtype;
	}

	public void setAtmtype(String atmtype) {
		this.atmtype = atmtype;
	}
	
	public String getOldcash() {
		return oldcash;
	}

	public void setOldcash(String oldcash) {
		this.oldcash = oldcash;
	}
	
	public String getCheckcash() {
		return checkcash;
	}

	public void setCheckcash(String checkcash) {
		this.checkcash = checkcash;
	}
	
	@Length(min=1, max=128, message="备注长度必须介于 1 和 128 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
}