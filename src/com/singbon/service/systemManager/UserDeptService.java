package com.singbon.service.systemManager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.UserDeptDAO;
import com.singbon.entity.UserDept;

/**
 * 人员部门业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class UserDeptService {

	@Autowired
	public UserDeptDAO userDeptDAO;

	/**
	 * 添加人员部门
	 * 
	 * @param userDept
	 */
	public void save(UserDept userDept) {
		if (userDept.getParentId() == null) {
			userDept.setParentId(0);
		}
		this.userDeptDAO.insert(userDept);
	}

	/**
	 * 修改人员部门
	 * 
	 * @param userDept
	 */
	public void update(UserDept userDept) {
		this.userDeptDAO.update(userDept);
	}

	/**
	 * 删除人员部门
	 * 
	 * @param userDept
	 */
	public void delete(Integer id) {
		this.userDeptDAO.delete(id);
	}

	/**
	 * 人员部门列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByParentId(Integer parentId) {
		if (parentId == null) {
			parentId = 0;
		}
		return this.userDeptDAO.selectByParentId(parentId);
	}

	/**
	 * 人员部门树列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectTreeList(Integer companyId) {
		return this.userDeptDAO.selectTreeList(companyId);
	}

	/**
	 * 根据主键获取部门
	 * 
	 * @return
	 */
	public UserDept selectById(Integer id) {
		return this.userDeptDAO.selectById(id);
	}
}
