package com.singbon.dao;

import java.util.Date;
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
	public SysUser selectByLoginInfo(SysUser user);

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
	public List<SysUser> selectList(@Param("companyId") Integer companyId);

	/**
	 * 获取出纳员列表
	 * 
	 * @param user
	 * @return
	 */
	public List<SysUser> selectCashierList(@Param("companyId") Integer companyId);

	/**
	 * 制出纳卡
	 * 
	 * @param user
	 * @return
	 */
	public void makeSpecailCard(SysUser user) throws Exception;

	/**
	 * 以物理卡号查询绑定数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByCardSN(@Param("companyId") Integer companyId, @Param("cardSN") String cardSN);

	/**
	 * 查询最大卡号+1
	 * 
	 * @param user
	 * @return
	 */
	public int selectMaxCardNO(@Param("companyId") Integer companyId) throws Exception;

	/**
	 * 改变卡状态
	 * 
	 * @param userId
	 * @param status
	 *            2挂失、1解挂
	 * @return
	 */
	public void changeStatus(@Param("operId") Integer operId, @Param("status") Integer status) throws Exception;

	/**
	 * 修改出纳卡有效期
	 * 
	 * @param userId
	 * @return
	 */
	public void changeCashierInvalidDate(@Param("operId") Integer operId, @Param("invalidDate") Date invalidDate) throws Exception;

}
