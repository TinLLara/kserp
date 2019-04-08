/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.modules.cms.dao.ArticleDataDao;
import com.szcxsl.oa.modules.cms.entity.ArticleData;

/**
 * 站点Service
 * @author Shi Lei
 * @version 2013-01-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleDataService extends CrudService<ArticleDataDao, ArticleData> {

}
