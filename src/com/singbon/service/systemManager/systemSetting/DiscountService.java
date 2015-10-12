package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.DiscountDAO;
import com.singbon.service.BaseService;

/**
 * 优惠方案业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DiscountService extends BaseService {

	@Autowired
	public DiscountDAO discountDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return discountDAO;
	}

	/**
	 * 添加优惠方案
	 * 
	 * @param Discount
	 */
	public void insert(Integer companyId) {
		this.discountDAO.insert(companyId);
	}
}
