package com.singbon.dao;

import java.util.List;

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
	 * 根据operId获取出纳员
	 * 
	 * @param user
	 * @return
	 */
	public SysUser selectByOperId(Integer operId);

	/**
	 * 获取登录信息
	 * 
	 * @param user
	 * @return
	 */
	public SysUser login(@Param("companyName") String companyName, @Param("loginName") String loginName, @Param("loginPwd") String loginPwd);

	/**
	 * 获取用户列表
	 * 
	 * @param user
	 * @return
	 */
	public List<SysUser> selecSysUsertList(@Param("companyId") Integer companyId);

	/**
	 * 获取出纳员列表
	 * 
	 * @param user
	 * @return
	 */
	public List<SysUser> selectCashierList(@Param("companyId") Integer companyId);
}
