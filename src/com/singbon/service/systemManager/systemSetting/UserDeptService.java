package com.singbon.service.systemManager.systemSetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.UserDeptDAO;
import com.singbon.service.BaseService;

/**
 * 人员部门业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class UserDeptService extends BaseService {

	@Autowired
	public UserDeptDAO userDeptDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return userDeptDAO;
	}

	/**
	 * 人员部门列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByParentId(Integer companyId, Integer parentId) {
		if (parentId == null) {
			parentId = 0;
		}
		return this.userDeptDAO.selectByParentId(companyId, parentId);
	}

}
