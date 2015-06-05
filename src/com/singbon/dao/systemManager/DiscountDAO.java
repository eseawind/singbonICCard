package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.Discount;

/**
 * 优惠方案dao层
 * 
 * @author 郝威
 * 
 */
public interface DiscountDAO {

	/**
	 * 添加优惠方案
	 * 
	 * @param companyId
	 * @return
	 */
	public void insert(@Param("companyId") Integer companyId);

	/**
	 * 修改优惠方案
	 * 
	 * @param Discount
	 * @return
	 */
	public void update(Discount discount);

	/**
	 * 优惠方案列表
	 * 
	 * @return
	 */
	public List<Discount> selectList(@Param("companyId") Integer companyId);
}
