package com.singbon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.SysUserDAO;
import com.singbon.entity.SysUser;

/**
 * 系统用户业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class SysUserService extends BaseService{

	@Autowired
	public SysUserDAO sysUserDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return sysUserDAO;
	}
	
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

	public SysUser login(String companyName, String loginName, String loginPwd) {

		return (SysUser) this.sysUserDAO.login(companyName, loginName, loginPwd);
	}

	/**
	 * 获取用户列表
	 * 
	 * @param user
	 * @return
	 */
	public List<SysUser> selecSysUsertList(Integer companyId) {
		return this.sysUserDAO.selecSysUsertList(companyId);
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
