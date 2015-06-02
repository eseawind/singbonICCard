package com.singbon.dao;

import com.singbon.entity.SysUser;


/**
 * 系统用户dao层
 * 
 * @author 郝威
 * 
 */
public interface SysUserDAO extends BaseDAO{
	
	/**
	 * 获取登录信息
	 * @param user
	 * @return
	 */
	public SysUser selectByLoginInfo(SysUser user);
}
