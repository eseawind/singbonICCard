package com.singbon.service.systemManager.systemSetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.OrderTimeDAO;
import com.singbon.entity.OrderTime;

/**
 * 订餐时间段业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class OrderTimeService {

	@Autowired
	public OrderTimeDAO orderTimeDAO;

	/**
	 * 添加
	 * 
	 * @param orderTime
	 */
	public void insert(Integer companyId) {
		this.orderTimeDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param orderTime
	 */
	public void update(OrderTime orderTime) {
		this.orderTimeDAO.update(orderTime);
	}

	/**
	 * 根据公司id查询
	 * 
	 * @return
	 */
	public List<OrderTime> selectByCompanyId(Integer companyId) {
		return this.orderTimeDAO.selectByCompanyId(companyId);
	}
}
