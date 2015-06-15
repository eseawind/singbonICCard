package com.singbon.service.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.AuthorizationDAO;
import com.singbon.entity.AuthGroup;
import com.singbon.entity.AuthUserGroup;

/**
 * 人员权限业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class AuthorizationService {

	@Autowired
	public AuthorizationDAO authorizationDAO;

	/**
	 * 分组列表
	 * 
	 * @return
	 */
	public List<AuthGroup> selectGroup(@Param("companyId") Integer companyId) {
		return this.authorizationDAO.selectGroup(companyId);
	}

	/**
	 * 添加分组
	 * 
	 * @return
	 */
	public void insertGroup(AuthGroup authGroup) {
		this.authorizationDAO.insertGroup(authGroup);
	}

	/**
	 * 修改分组
	 * 
	 * @return
	 */
	public void updateGroup(AuthGroup authGroup) {
		this.authorizationDAO.updateGroup(authGroup);
	}

	/**
	 * 获取分组下用户个数
	 * 
	 * @return
	 */
	public Integer selectGroupUserCount(@Param("groupId") Integer groupId) {
		return this.authorizationDAO.selectGroupUserCount(groupId);
	}

	/**
	 * 删除分组
	 * 
	 * @return
	 */
	public void deleteGroup(@Param("id") Integer id) {
		this.authorizationDAO.deleteGroup(id);
	}


	/**
	 * 用户组列表
	 * 
	 * @return
	 */
	public List<AuthUserGroup> selectUserGroup(@Param("userId") Integer userId) {
		return this.authorizationDAO.selectUserGroup(userId);
	}

	/**
	 * 添加用户组
	 * 
	 * @return
	 */
	public void insertUserGroup(@Param("list") List<AuthUserGroup> list) {
		this.authorizationDAO.insertUserGroup(list);
	}

	/**
	 * 删除用户组
	 * 
	 * @return
	 */
	public void deleteUserGroup(@Param("userId") Integer userId) {
		this.authorizationDAO.deleteUserGroup(userId);
	}
}
