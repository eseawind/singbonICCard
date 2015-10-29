package com.singbon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.singbon.entity.User;

/**
 * UserDao层(制卡、用户信息查询)
 * 
 * @author 郝威
 * 
 */
@Repository
public interface UserDAO extends BaseDAO {

	/**
	 * 删除未发卡人员
	 * 
	 * @param id
	 * @return
	 */
	public void delete(@Param("userIds") Integer[] userIds) throws Exception;

	/**
	 * 根据主键查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectByUserId(@Param("userId") Integer userId);

	/**
	 * 根据主键和物理卡号查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectByUserIdCardSN(@Param("companyId") Integer companyId, @Param("userId") Integer userId, @Param("cardSN") String cardSN);

	/**
	 * 根据部门查询未发卡人员
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectNoCardByDeptId(@Param("deptId") Integer deptId);

	/**
	 * 人员列表
	 * 
	 * @param deptId
	 * @param searchStr
	 * @return
	 */
	public List<User> selectByCondition(@Param("deptId") Integer deptId, @Param("searchStr") String searchStr);

	/**
	 * 信息发卡
	 * 
	 * @param user
	 * @return
	 */
	public void infoCard(User user) throws Exception;

	/**
	 * 补卡
	 * 
	 * @param user
	 * @return
	 */
	public void remakeCard(User user) throws Exception;

	/**
	 * 解挂
	 * 
	 * @param user
	 * @return
	 */
	public void unloss(User user) throws Exception;

	/**
	 * 以物理卡号查询绑定数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByCardSN(@Param("companyId") Integer companyId, @Param("cardSN") String cardSN);

	/**
	 * 以用户编号查询数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByUserNO(@Param("companyId") Integer companyId, @Param("userNO") String userNO) throws Exception;

	/**
	 * 以用户编号用户ID查询数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByUserNOUserId(@Param("companyId") Integer companyId, @Param("userNO") String userNO, @Param("userId") Integer userId) throws Exception;

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
	public void changeStatus(@Param("userId") Integer userId, @Param("status") Integer status) throws Exception;

	/**
	 * 换新卡
	 * 
	 * @param userId
	 * @param cardNO
	 * @param cardSN
	 */
	public void changeNewCard(@Param("userId") Integer userId, @Param("cardNO") Integer cardNO, @Param("cardSN") String cardSN) throws Exception;

	/**
	 * 按卡修正
	 * 
	 * @param userId
	 * @param cardNO
	 * @param cardSN
	 */
	public void updateByCard(User user) throws Exception;

	/**
	 * 指定人员调整到新部门
	 * 
	 * @param userId
	 * @param toDeptId
	 * @throws Exception
	 */
	public void changeToNewDept(@Param("userIds") Integer[] userIds, @Param("toDeptId") Integer toDeptId) throws Exception;

	/**
	 * 调整人员从原部门到新部门
	 * 
	 * @param fromDeptId
	 * @param toDeptId
	 * @throws Exception
	 */
	public void changeFromDeptToNew(@Param("fromDeptId") Integer fromDeptId, @Param("toDeptId") Integer toDeptId) throws Exception;

	/**
	 * 更改金额
	 * 
	 * @param userId
	 * @param cardNO
	 * @param cardSN
	 */
	public void changeFare(@Param("userId") Integer userId, @Param("opFare") Integer opFare) throws Exception;

}
