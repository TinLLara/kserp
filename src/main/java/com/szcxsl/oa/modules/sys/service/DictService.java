/**
 * Copyright &copy; 2012-2014 <a href="http://www.kszhineng.cn">OA</a> All rights reserved.
 */
package com.szcxsl.oa.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.szcxsl.oa.common.service.CrudService;
import com.szcxsl.oa.common.utils.CacheUtils;
import com.szcxsl.oa.modules.sys.dao.DictDao;
import com.szcxsl.oa.modules.sys.entity.Dict;
import com.szcxsl.oa.modules.sys.utils.DictUtils;

/**
 * 字典Service
 * @author Shi Lei
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = false)
public class DictService extends CrudService<DictDao, Dict> {
	
	/**
	 * 查询字段类型列表
	 * @return
	 */
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Override
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}
	
	@Override
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

}