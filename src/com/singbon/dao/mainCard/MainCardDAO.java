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
	public void insert(User user);

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
	public User selectById(@Param("id") Integer id);

	/**
	 * 人员列表
	 * 
	 * @param deptId
	 * @param searchStr
	 * @return
	 */
	public List<User> selectByCondition(@Param("deptId") Integer deptId, @Param("searchStr") String searchStr);

}
