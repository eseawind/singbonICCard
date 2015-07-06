package com.singbon.dao.mainCard;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.User;

/**
 * 制卡dao层
 * 
 * @author 郝威
 * 
 */
public interface MainCardDAO {

	/**
	 * 添加人员
	 * 
	 * @param user
	 * @return
	 */
	public Object insert(User user);

	/**
	 * 修改人员
	 * 
	 * @param user
	 * @return
	 */
	public void update(User user);

	/**
	 * 删除未发卡人员
	 * 
	 * @param id
	 * @return
	 */
	public void delete(@Param("deptId") Integer deptId);

	/**
	 * 根据主键查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectById(@Param("userId") Integer userId);

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
	public void infoCard(User user);
	
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
	public int selectCountByUserNO(@Param("companyId") Integer companyId, @Param("userNO") String userNO);
	
	/**
	 * 以用户编号用户ID查询数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByUserNOUserId(@Param("companyId") Integer companyId, @Param("userNO") String userNO, @Param("userId") Integer userId);
	
	/**
	 * 查询最大卡号+1
	 * 
	 * @param user
	 * @return
	 */
	public int selectMaxCardNO(@Param("companyId") Integer companyId);

}
