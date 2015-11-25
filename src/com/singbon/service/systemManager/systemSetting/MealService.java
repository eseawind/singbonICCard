package com.singbon.service.systemManager.systemSetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.MealDAO;
import com.singbon.entity.Meal;
import com.singbon.service.BaseService;

/**
 * 餐别设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MealService extends BaseService {

	@Autowired
	public MealDAO mealDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return mealDAO;
	}

	/**
	 * 添加
	 * 
	 * @param meal
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void insert(Integer companyId) {
		this.mealDAO.insert(companyId);
	}

	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Meal> selectAllList() {
		return this.mealDAO.selectAllList();
	}
}
