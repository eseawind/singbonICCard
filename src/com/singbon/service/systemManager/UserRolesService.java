package com.singbon.service.systemManager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.UserRolesDAO;
import com.singbon.entity.UserRoles;

/**
 * 人员权限业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class UserRolesService {

	@Autowired
	public UserRolesDAO userRolesDAO;

	/**
	 * 人员权限列表
	 * 
	 * @return
	 */
	public List<UserRoles> selectByUserId(Integer userId) {
		
		return this.userRolesDAO.selectByUserId(userId);
	}
}
