package com.singbon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.SysUserDAO;
import com.singbon.entity.SysUser;

/**
 * 系统用户业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class SysUserService {

	@Autowired
	public SysUserDAO sysUserDAO;

	/**
	 * 根据operId获取出纳员
	 * 
	 * @param user
	 * @return
	 */
	public SysUser selectByOperId(Integer operId) {
		return this.sysUserDAO.selectByOperId(operId);
	}

	public SysUser login(SysUser user) {

		return (SysUser) this.sysUserDAO.selectByLoginInfo(user);
	}

	public SysUser login(String compayName, String loginName, String loginPwd) {

		return (SysUser) this.sysUserDAO.login(compayName, loginName, loginPwd);
	}

	/**
	 * 获取用户列表
	 * 
	 * @param user
	 * @return
	 */
	public List<SysUser> selectList(Integer companyId) {
		return this.sysUserDAO.selectList(companyId);
	}

	/**
	 * 获取出纳员列表
	 * 
	 * @param user
	 * @return
	 */
	public List<SysUser> selectCashierList(Integer companyId) {
		return this.sysUserDAO.selectCashierList(companyId);
	}

}
