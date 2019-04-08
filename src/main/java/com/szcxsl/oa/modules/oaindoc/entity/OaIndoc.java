/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaindoc.entity;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.szcxsl.oa.common.persistence.DataEntity;

import java.util.Date;

import javax.validation.constraints.NotNull;

/**
 * 内部公函申请Entity
 * @author Shi Lei
 * @version 2015-05-21
 */
public class OaIndoc extends DataEntity<OaIndoc> {
	
	private static final long serialVersionUID = 1L;
	private String indocid;		// 主键
	private String indoccode;		// 部门名称
	private String indocname;		// 公函题目
	private String indocproject;		// 关联项目
	private String indocevent;		// 关联事件
	private Date indoccdate;		// 呈文日期
	private String indoccreator;		// 拟稿人
	private String indocmobile;		// 手机
	private String indocsec;		// 密级
	private String indocstate;		// 缓级
	private String indocattach;		// 附件
	private String indoccontent;		// 正文
	private String indocadvice;		// 意见
	private String indocnextop;		// 下一处理事件
	private String indocnextoper;		// 下一处理人
	private String indocmailcopier;		// 抄送人
	
	public OaIndoc() {
		super();
	}

	public OaIndoc(String id){
		super(id);
	}

	@Length(min=0, max=64, message="主键长度必须介于 0 和 64 之间")
	public String getIndocid() {
		return indocid;
	}

	public void setIndocid(String indocid) {
		this.indocid = indocid;
	}
	
	@Length(min=0, max=64, message="部门名称长度必须介于 0 和 64 之间")
	public String getIndoccode() {
		return indoccode;
	}

	public void setIndoccode(String indoccode) {
		this.indoccode = indoccode;
	}
	
	@Length(min=1, max=400, message="公函题目长度必须介于 1 和 400 之间")
	public String getIndocname() {
		return indocname;
	}

	public void setIndocname(String indocname) {
		this.indocname = indocname;
	}
	
	@Length(min=0, max=100, message="关联项目长度必须介于 0 和 100 之间")
	public String getIndocproject() {
		return indocproject;
	}

	public void setIndocproject(String indocproject) {
		this.indocproject = indocproject;
	}
	
	@Length(min=1, max=100, message="关联事件长度必须介于 1 和 100 之间")
	public String getIndocevent() {
		return indocevent;
	}

	public void setIndocevent(String indocevent) {
		this.indocevent = indocevent;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="申请时间不能为空")
	public Date getIndoccdate() {
		return indoccdate;
	}

	public void setIndoccdate(Date indoccdate) {
		this.indoccdate = indoccdate;
	}
	
	@Length(min=0, max=32, message="拟稿人长度必须介于 0 和 32 之间")
	public String getIndoccreator() {
		return indoccreator;
	}

	public void setIndoccreator(String indoccreator) {
		this.indoccreator = indoccreator;
	}
	
	@Length(min=0, max=32, message="手机长度必须介于 0 和 32 之间")
	public String getIndocmobile() {
		return indocmobile;
	}

	public void setIndocmobile(String indocmobile) {
		this.indocmobile = indocmobile;
	}
	
	@Length(min=1, max=32, message="密级长度必须介于 1 和 32 之间")
	public String getIndocsec() {
		return indocsec;
	}

	public void setIndocsec(String indocsec) {
		this.indocsec = indocsec;
	}
	
	@Length(min=1, max=32, message="缓级长度必须介于 1 和 32 之间")
	public String getIndocstate() {
		return indocstate;
	}

	public void setIndocstate(String indocstate) {
		this.indocstate = indocstate;
	}
	
	@Length(min=0, max=32, message="附件长度必须介于 0 和 32 之间")
	public String getIndocattach() {
		return indocattach;
	}

	public void setIndocattach(String indocattach) {
		this.indocattach = indocattach;
	}
	
	@Length(min=1, max=4000, message="正文长度必须介于 1 和 4000 之间")
	public String getIndoccontent() {
		return indoccontent;
	}

	public void setIndoccontent(String indoccontent) {
		this.indoccontent = indoccontent;
	}
	
	@Length(min=0, max=4000, message="意见长度必须介于 0 和 4000 之间")
	public String getIndocadvice() {
		return indocadvice;
	}

	public void setIndocadvice(String indocadvice) {
		this.indocadvice = indocadvice;
	}
	
	@Length(min=0, max=32, message="下一处理事件长度必须介于 0 和 32 之间")
	public String getIndocnextop() {
		return indocnextop;
	}

	public void setIndocnextop(String indocnextop) {
		this.indocnextop = indocnextop;
	}
	
	@Length(min=1, max=32, message="下一处理人长度必须介于 1 和 32 之间")
	public String getIndocnextoper() {
		return indocnextoper;
	}

	public void setIndocnextoper(String indocnextoper) {
		this.indocnextoper = indocnextoper;
	}
	
	@Length(min=0, max=4000, message="抄送人长度必须介于 0 和 4000 之间")
	public String getIndocmailcopier() {
		return indocmailcopier;
	}

	public void setIndocmailcopier(String indocmailcopier) {
		this.indocmailcopier = indocmailcopier;
	}
	
}