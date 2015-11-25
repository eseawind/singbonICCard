package com.singbon.service;

import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.dao.BaseDAO;

/**
 * 公共通用基础业务层
 * 
 * @author 郝威
 * 
 */
@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
public abstract class BaseService implements IBaseService {

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public Object insert(Object obj) throws Exception {
		return getBaseDAO().insert(obj);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void update(Object obj) throws Exception {
		getBaseDAO().update(obj);
	}

	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void delete(Object obj) throws Exception {
		getBaseDAO().delete(obj);
	}

	public Object selectById(Integer id) {
		return getBaseDAO().selectById(id);
	}

	public Object selectByCompanyId(Integer companyId) {
		return getBaseDAO().selectByCompanyId(companyId);
	}

	public List<?> selectListByCompanyId(Integer companyId) {
		return getBaseDAO().selectListByCompanyId(companyId);
	}

	public abstract BaseDAO getBaseDAO();
}
