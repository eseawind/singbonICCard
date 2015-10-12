package com.singbon.service.systemManager.systemSetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.DeptDAO;
import com.singbon.service.BaseService;

/**
 * 营业部门业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DeptService extends BaseService {

	@Autowired
	public DeptDAO deptDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return deptDAO;
	}

	/**
	 * 列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByParentId(Integer companyId, Integer parentId) {
		if (parentId == null) {
			parentId = 0;
		}
		return this.deptDAO.selectByParentId(companyId, parentId);
	}
}
