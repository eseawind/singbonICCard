package com.singbon.service;

import java.util.List;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Pagination;

/**
 * 公共通用基础业务层
 * 
 * @author 郝威
 * 
 */
public abstract class BaseService implements IBaseService {

	@Override
	public Object insert(Object obj) throws Exception {
		return getBaseDAO().insert(obj);
	}

	@Override
	public void update(Object obj) throws Exception {
		getBaseDAO().update(obj);
	}

	@Override
	public void delete(Object obj) throws Exception {
		getBaseDAO().delete(obj);
	}

	@Override
	public Object selectById(Integer id) {
		return getBaseDAO().selectById(id);
	}

	@Override
	public Object selectByCompanyId(Integer companyId) {
		return getBaseDAO().selectByCompanyId(companyId);
	}

	@Override
	public List<?> selectListByCompanyId(Integer companyId) {
		return getBaseDAO().selectListByCompanyId(companyId);
	}

	public abstract BaseDAO getBaseDAO();
}
