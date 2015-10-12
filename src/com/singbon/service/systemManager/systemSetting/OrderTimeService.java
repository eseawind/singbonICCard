package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.OrderTimeDAO;
import com.singbon.service.BaseService;

/**
 * 订餐时间段业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class OrderTimeService extends BaseService {

	@Autowired
	public OrderTimeDAO orderTimeDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return orderTimeDAO;
	}

	/**
	 * 添加
	 * 
	 * @param orderTime
	 */
	public void insert(Integer companyId) {
		this.orderTimeDAO.insert(companyId);
	}

}
