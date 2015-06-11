package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.UserRoles;

/**
 * 权限dao层
 * 
 * @author 郝威
 * 
 */
public interface UserRolesDAO {


	/**
	 * 人员权限列表
	 * 
	 * @return
	 */
	public List<UserRoles> selectByUserId(@Param("userId") Integer userId);

}
