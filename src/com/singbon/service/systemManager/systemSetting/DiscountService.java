package com.singbon.service.systemManager.systemSetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.DiscountDAO;
import com.singbon.entity.Discount;

/**
 * 优惠方案业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DiscountService {

	@Autowired
	public DiscountDAO discountDAO;

	/**
	 * 添加优惠方案
	 * 
	 * @param Discount
	 */
	public void insert(Integer companyId) {
		this.discountDAO.insert(companyId);
	}

	/**
	 * 修改优惠方案
	 * 
	 * @param Discount
	 */
	public void update(Discount discount) {
		this.discountDAO.update(discount);
	}

	/**
	 * 优惠方案列表
	 * 
	 * @return
	 */
	public List<Discount> selectList(Integer companyId) {

		return this.discountDAO.selectList(companyId);
	}
}
