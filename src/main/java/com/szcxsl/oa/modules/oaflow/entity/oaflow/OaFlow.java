/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.oaflow.entity.oaflow;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.szcxsl.oa.common.persistence.DataEntity;

/**
 * 审批流程Entity
 * @author Shi Lei
 * @version 2015-06-02
 */
public class OaFlow extends DataEntity<OaFlow> {
	
	private static final long serialVersionUID = 1L;
	private String flowType;		// 流程类型：nbgh:内部公函，yzsq:印章申请，xjsq:休假申请，ccsq:出差申请，fybx费用报销
	private String relationId;		// 流程类型对应的ID，比如印章申请的ID
	private Date createTime;		// 流程发起时间
	private Date overTime;		// 处理时间
	private String operator;		// 当前处理人
	private String flowState;		// 当前节点状态：start:发起，unauth:待审批，refuse:拒绝，authed:已审批，end:结束
	private String remark;		// 审核意见
	private String copy;		// 抄送人，逗号隔开
	private String recall;		// 是否回执：yes，no
	
	public OaFlow() {
		super();
	}

	public OaFlow(String id){
		super(id);
	}

	@Length(min=0, max=10, message="流程类型：nbgh:内部公函，yzsq:印章申请，xjsq:休假申请，ccsq:出差申请，fybx费用报销长度必须介于 0 和 10 之间")
	public String getFlowType() {
		return flowType;
	}

	public void setFlowType(String flowType) {
		this.flowType = flowType;
	}
	
	@Length(min=0, max=32, message="流程类型对应的ID，比如印章申请的ID长度必须介于 0 和 32 之间")
	public String getRelationId() {
		return relationId;
	}

	public void setRelationId(String relationId) {
		this.relationId = relationId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOverTime() {
		return overTime;
	}

	public void setOverTime(Date overTime) {
		this.overTime = overTime;
	}
	
	@Length(min=0, max=256, message="当前处理人长度必须介于 0 和 256 之间")
	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}
	
	@Length(min=0, max=10, message="当前节点状态：start:发起，unauth:待审批，refuse:拒绝，authed:已审批，end:结束长度必须介于 0 和 10 之间")
	public String getFlowState() {
		return flowState;
	}

	public void setFlowState(String flowState) {
		this.flowState = flowState;
	}
	
	@Length(min=0, max=4000, message="审核意见长度必须介于 0 和 4000 之间")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Length(min=0, max=2000, message="抄送人，逗号隔开长度必须介于 0 和 2000 之间")
	public String getCopy() {
		return copy;
	}

	public void setCopy(String copy) {
		this.copy = copy;
	}
	
	@Length(min=0, max=20, message="是否回执：yes，no长度必须介于 0 和 20 之间")
	public String getRecall() {
		return recall;
	}

	public void setRecall(String recall) {
		this.recall = recall;
	}
	
}