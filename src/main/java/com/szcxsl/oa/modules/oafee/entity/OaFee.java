/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oafee.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.validator.constraints.Length;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 费用申请增删改查Entity
 * @author Shilei
 * @version 2015-04-08
 */
public class OaFee extends DataEntity<OaFee> {
	
	private static final long serialVersionUID = 1L;
	private String feeid;		// 费用ID
	private String applyperson;		// 申请人
	private Date applytime;		// 申请时间
	private String belongdept;		// 申请人所属部门
	private String feebelongdept;		// 费用归属部门
	private String proname;		// 项目名称
	private String feecomment;		// 费用说明
	private Date sdate;		// 出差起始时间
	private Date edate;		// 出差结束时间
	private String saddr;		// 出差出发地点
	private String eaddr;		// 出差目的地
	private String tools;		// 交通工具
	private String currency;		// 币种类型
	private String planefee;		// 飞机费用
	private String cityfee;		// 市内交通费用
	private String livingfee;		// 住宿费用
	private String tripfee;		// 出差补助（200*days）
	private String otherfee;		// 其他费用
	private String checkedcu;		// 核定币种
	private String checkedfee;		// 核定金额
	private String filecount;		// 附件数
	private String triplist;		// 出差申请单
	private String files;		// 附件
	private String state;		// 审批状态
	private String noticetag;		// 回执标志
	private String joinedper;		// 参与人
	private String advancecash;		// 预支金额
	private String feetype;		// 费用类型
	private String happentime;		// 费用发生时间
	private String oldatm;		// 原币金额
	private String totalcash;		// 合计金额
	private String totalcashzh;		// 合计金额(大写)
	private String distancefee;		// 长途交通费
	private String feecat;		// 费用大类
	private String projectid;		// 相关项目
	private String comeon;		// 事由
	private String other;		// 其他
	private String details;		// 说明
	private String eventid;		// 相关事件
	private String nextnoder;		// 下一处理人
	private Date beginApplytime;		// 开始 申请时间
	private Date endApplytime;		// 结束 申请时间
	
	public OaFee() {
		super();
	}

	public OaFee(String id){
		super(id);
	}

	@Length(min=1, max=32, message="费用ID长度必须介于 1 和 32 之间")
	public String getFeeid() {
		return feeid;
	}

	public void setFeeid(String feeid) {
		this.feeid = feeid;
	}
	
	@Length(min=0, max=32, message="申请人长度必须介于 0 和 32 之间")
	public String getApplyperson() {
		return applyperson;
	}

	public void setApplyperson(String applyperson) {
		this.applyperson = applyperson;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getApplytime() {
		return applytime;
	}

	public void setApplytime(Date applytime) {
		this.applytime = applytime;
	}
	
	@Length(min=0, max=128, message="申请人所属部门长度必须介于 0 和 128 之间")
	public String getBelongdept() {
		return belongdept;
	}

	public void setBelongdept(String belongdept) {
		this.belongdept = belongdept;
	}
	
	@Length(min=0, max=128, message="费用归属部门长度必须介于 0 和 128 之间")
	public String getFeebelongdept() {
		return feebelongdept;
	}

	public void setFeebelongdept(String feebelongdept) {
		this.feebelongdept = feebelongdept;
	}
	
	@Length(min=0, max=128, message="项目名称长度必须介于 0 和 128 之间")
	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}
	
	@Length(min=0, max=128, message="费用说明长度必须介于 0 和 128 之间")
	public String getFeecomment() {
		return feecomment;
	}

	public void setFeecomment(String feecomment) {
		this.feecomment = feecomment;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSdate() {
		return sdate;
	}

	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEdate() {
		return edate;
	}

	public void setEdate(Date edate) {
		this.edate = edate;
	}
	
	@Length(min=0, max=64, message="出差出发地点长度必须介于 0 和 64 之间")
	public String getSaddr() {
		return saddr;
	}

	public void setSaddr(String saddr) {
		this.saddr = saddr;
	}
	
	@Length(min=0, max=64, message="出差目的地长度必须介于 0 和 64 之间")
	public String getEaddr() {
		return eaddr;
	}

	public void setEaddr(String eaddr) {
		this.eaddr = eaddr;
	}
	
	@Length(min=0, max=32, message="交通工具长度必须介于 0 和 32 之间")
	public String getTools() {
		return tools;
	}

	public void setTools(String tools) {
		this.tools = tools;
	}
	
	@Length(min=0, max=16, message="币种类型长度必须介于 0 和 16 之间")
	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public String getPlanefee() {
		return planefee;
	}

	public void setPlanefee(String planefee) {
		this.planefee = planefee;
	}
	
	public String getCityfee() {
		return cityfee;
	}

	public void setCityfee(String cityfee) {
		this.cityfee = cityfee;
	}
	
	public String getLivingfee() {
		return livingfee;
	}

	public void setLivingfee(String livingfee) {
		this.livingfee = livingfee;
	}
	
	public String getTripfee() {
		return tripfee;
	}

	public void setTripfee(String tripfee) {
		this.tripfee = tripfee;
	}
	
	public String getOtherfee() {
		return otherfee;
	}

	public void setOtherfee(String otherfee) {
		this.otherfee = otherfee;
	}
	
	@Length(min=0, max=16, message="核定币种长度必须介于 0 和 16 之间")
	public String getCheckedcu() {
		return checkedcu;
	}

	public void setCheckedcu(String checkedcu) {
		this.checkedcu = checkedcu;
	}
	
	public String getCheckedfee() {
		return checkedfee;
	}

	public void setCheckedfee(String checkedfee) {
		this.checkedfee = checkedfee;
	}
	
	@Length(min=0, max=11, message="附件数长度必须介于 0 和 11 之间")
	public String getFilecount() {
		return filecount;
	}

	public void setFilecount(String filecount) {
		this.filecount = filecount;
	}
	
	@Length(min=0, max=32, message="出差申请单长度必须介于 0 和 32 之间")
	public String getTriplist() {
		return triplist;
	}

	public void setTriplist(String triplist) {
		this.triplist = triplist;
	}
	
	//@Length(min=0, max=1000, message="附件长度必须介于 0 和 1000 之间")
	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}
	
	@Length(min=0, max=16, message="审批状态长度必须介于 0 和 16 之间")
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	@Length(min=0, max=11, message="回执标志长度必须介于 0 和 11 之间")
	public String getNoticetag() {
		return noticetag;
	}

	public void setNoticetag(String noticetag) {
		this.noticetag = noticetag;
	}
	
	@Length(min=0, max=128, message="参与人长度必须介于 0 和 128 之间")
	public String getJoinedper() {
		return joinedper;
	}

	public void setJoinedper(String joinedper) {
		this.joinedper = joinedper;
	}
	
	public String getAdvancecash() {
		return advancecash;
	}

	public void setAdvancecash(String advancecash) {
		this.advancecash = advancecash;
	}
	
	@Length(min=0, max=16, message="费用类型长度必须介于 0 和 16 之间")
	public String getFeetype() {
		return feetype;
	}

	public void setFeetype(String feetype) {
		this.feetype = feetype;
	}
	
	@Length(min=0, max=30, message="费用发生时间长度必须介于 0 和 30 之间")
	public String getHappentime() {
		return happentime;
	}

	public void setHappentime(String happentime) {
		this.happentime = happentime;
	}
	
	public String getOldatm() {
		return oldatm;
	}

	public void setOldatm(String oldatm) {
		this.oldatm = oldatm;
	}
	
	@Length(min=0, max=32, message="合计金额长度必须介于 0 和 32 之间")
	public String getTotalcash() {
		return totalcash;
	}

	public void setTotalcash(String totalcash) {
		this.totalcash = totalcash;
	}
	
	@Length(min=0, max=32, message="合计金额(大写)长度必须介于 0 和 32 之间")
	public String getTotalcashzh() {
		return totalcashzh;
	}

	public void setTotalcashzh(String totalcashzh) {
		this.totalcashzh = totalcashzh;
	}
	
	public String getDistancefee() {
		return distancefee;
	}

	public void setDistancefee(String distancefee) {
		this.distancefee = distancefee;
	}
	
	@Length(min=0, max=16, message="费用大类长度必须介于 0 和 16 之间")
	public String getFeecat() {
		return feecat;
	}

	public void setFeecat(String feecat) {
		this.feecat = feecat;
	}
	
	@Length(min=0, max=40, message="相关项目长度必须介于 0 和 40 之间")
	public String getProjectid() {
		return projectid;
	}

	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}
	
	@Length(min=0, max=16, message="事由长度必须介于 0 和 16 之间")
	public String getComeon() {
		return comeon;
	}

	public void setComeon(String comeon) {
		this.comeon = comeon;
	}
	
	@Length(min=0, max=16, message="其他长度必须介于 0 和 16 之间")
	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}
	
	@Length(min=0, max=256, message="说明长度必须介于 0 和 256 之间")
	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}
	
	@Length(min=0, max=32, message="相关事件长度必须介于 0 和 32 之间")
	public String getEventid() {
		return eventid;
	}

	public void setEventid(String eventid) {
		this.eventid = eventid;
	}
	
	@Length(min=0, max=32, message="下一处理人长度必须介于 0 和 32 之间")
	public String getNextnoder() {
		return nextnoder;
	}

	public void setNextnoder(String nextnoder) {
		this.nextnoder = nextnoder;
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