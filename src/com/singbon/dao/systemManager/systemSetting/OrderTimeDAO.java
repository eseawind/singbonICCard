package com.singbon.dao.systemManager.systemSetting;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.OrderTime;

/**
 * 订餐时间段dao层
 * 
 * @author 郝威
 * 
 */
public interface OrderTimeDAO extends BaseDAO {

	/**
	 * 添加
	 * 
	 * @param companyId
	 * @return
	 */
	public void insert(@Param("companyId") Integer companyId);

	/**
	 * 根据公司id查询
	 * 
	 * @param companyId
	 * @return
	 */
	public List<OrderTime> selectByCompanyId(@Param("companyId") Integer companyId);
}
