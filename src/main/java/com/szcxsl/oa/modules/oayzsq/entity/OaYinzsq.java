/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oayzsq.entity;

import org.hibernate.validator.constraints.Length;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 印章申请Entity
 * @author Shi Lei
 * @version 2015-05-21
 */
public class OaYinzsq extends DataEntity<OaYinzsq> {
	
	private static final long serialVersionUID = 1L;
	private String appname;		// 起草人
	private String appdate;		// 起草时间
	private String depart;		// 所在部门
	private String yynum;		// 用印份数
	private String type;		// 用章类型
	private String corpname;		// 公司名称
	private String fileormeno;		// 文件名或用途
	private String filename;		// 附件名称
	private String fileid;		// 附件id
	private String advice;		// 意见
	private String mailcopier;		// 抄送人
	private String creator;		// 创建人
	private String creatdate;		// 创建时间
	private String event;		// 关联事件
	private String project;		// 关联项目
	private String nextop;		// 下一处理环节
	private String nextoper;		// 下一处理人
	private String comeon;		// 是否回执
	private String appresult;		// 推送流程状态
	
	public OaYinzsq() {
		super();
	}

	public OaYinzsq(String id){
		super(id);
	}

	@Length(min=0, max=256, message="起草人长度必须介于 0 和 256 之间")
	public String getAppname() {
		return appname;
	}

	public void setAppname(String appname) {
		this.appname = appname;
	}
	
	@Length(min=0, max=32, message="起草时间长度必须介于 0 和 32 之间")
	public String getAppdate() {
		return appdate;
	}

	public void setAppdate(String appdate) {
		this.appdate = appdate;
	}
	
	@Length(min=0, max=100, message="所在部门长度必须介于 0 和 100 之间")
	public String getDepart() {
		return depart;
	}

	public void setDepart(String depart) {
		this.depart = depart;
	}
	
	@Length(min=0, max=40, message="用印份数长度必须介于 0 和 40 之间")
	public String getYynum() {
		return yynum;
	}

	public void setYynum(String yynum) {
		this.yynum = yynum;
	}
	
	@Length(min=1, max=40, message="用章类型长度必须介于 1 和 40 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=1, max=500, message="公司名称长度必须介于 1 和 500 之间")
	public String getCorpname() {
		return corpname;
	}

	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}
	
	@Length(min=1, max=4000, message="印章用途长度必须介于 1 和 4000 之间")
	public String getFileormeno() {
		return fileormeno;
	}

	public void setFileormeno(String fileormeno) {
		this.fileormeno = fileormeno;
	}
	
	@Length(min=0, max=500, message="附件名称长度必须介于 0 和 500 之间")
	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	@Length(min=0, max=40, message="附件id长度必须介于 0 和 40 之间")
	public String getFileid() {
		return fileid;
	}

	public void setFileid(String fileid) {
		this.fileid = fileid;
	}
	
	@Length(min=0, max=4000, message="意见长度必须介于 0 和 4000 之间")
	public String getAdvice() {
		return advice;
	}

	public void setAdvice(String advice) {
		this.advice = advice;
	}
	
	@Length(min=0, max=4000, message="抄送人长度必须介于 0 和 4000 之间")
	public String getMailcopier() {
		return mailcopier;
	}

	public void setMailcopier(String mailcopier) {
		this.mailcopier = mailcopier;
	}
	
	@Length(min=0, max=256, message="创建人长度必须介于 0 和 256 之间")
	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}
	
	@Length(min=0, max=32, message="创建时间长度必须介于 0 和 32 之间")
	public String getCreatdate() {
		return creatdate;
	}

	public void setCreatdate(String creatdate) {
		this.creatdate = creatdate;
	}
	
	@Length(min=1, max=100, message="关联事件长度必须介于 1 和 100 之间")
	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
	}
	
	@Length(min=0, max=100, message="关联项目长度必须介于 0 和 100 之间")
	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}
	
	@Length(min=0, max=32, message="下一处理环节长度必须介于 0 和 32 之间")
	public String getNextop() {
		return nextop;
	}

	public void setNextop(String nextop) {
		this.nextop = nextop;
	}
	
	@Length(min=0, max=32, message="下一处理人长度必须介于 0 和 32 之间")
	public String getNextoper() {
		return nextoper;
	}

	public void setNextoper(String nextoper) {
		this.nextoper = nextoper;
	}
	
	@Length(min=0, max=4, message="是否回执长度必须介于 0 和 4 之间")
	public String getComeon() {
		return comeon;
	}

	public void setComeon(String comeon) {
		this.comeon = comeon;
	}
	
	@Length(min=0, max=4, message="推送流程状态长度必须介于 0 和 4 之间")
	public String getAppresult() {
		return appresult;
	}

	public void setAppresult(String appresult) {
		this.appresult = appresult;
	}
	
}