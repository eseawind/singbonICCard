package com.singbon.service.systemManager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.MealDAO;
import com.singbon.entity.Meal;

/**
 * 餐别设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MealService {

	@Autowired
	public MealDAO mealDAO;

	/**
	 * 添加
	 * 
	 * @param meal
	 */
	public void insert(Integer companyId) {
		this.mealDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param meal
	 */
	public void update(Meal meal) {
		this.mealDAO.update(meal);
	}

	/**
	 * 列表
	 * 
	 * @return
	 */
	public List<Meal> selectList(Integer companyId) {

		return this.mealDAO.selectList(companyId);
	}
}
