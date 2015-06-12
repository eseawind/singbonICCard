package com.singbon.dao;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.SysUser;

/**
 * 系统用户dao层
 * 
 * @author 郝威
 * 
 */
public interface SysUserDAO extends BaseDAO {

	/**
	 * 获取登录信息
	 * 
	 * @param user
	 * @return
	 */
	public SysUser selectByLoginInfo(SysUser user);

	/**
	 * 获取登录信息
	 * 
	 * @param user
	 * @return
	 */
	public SysUser login(@Param("companyName") String compayName, @Param("loginName") String loginName, @Param("loginPwd") String loginPwd);
}
