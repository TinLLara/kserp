/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.test.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.test.entity.Test;
import com.szcxsl.oa.modules.test.dao.TestDao;

/**
 * 测试Service
 * @author Shi Lei
 * @version 2013-10-17
 */
@Service
@Transactional(readOnly = true)
public class TestService extends CrudService<TestDao, Test> {

}
