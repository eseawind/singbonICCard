package com.singbon.service.systemManager.systemSetting;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.CookbookDAO;
import com.singbon.entity.Cookbook;

/**
 * 菜肴清单业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CookbookService {

	@Autowired
	public CookbookDAO cookbookDAO;

	/**
	 * 添加
	 * 
	 * @param cookbook
	 */
	public void insert(Cookbook cookbook) {
		this.cookbookDAO.insert(cookbook);
	}

	/**
	 * 修改
	 * 
	 * @param cookbook
	 */
	public void update(Cookbook cookbook) {
		this.cookbookDAO.update(cookbook);
	}

	/**
	 * 列表
	 * 
	 * @return
	 */
	public List<Cookbook> selectList(Integer companyId) {

		return this.cookbookDAO.selectList(companyId);
	}

	/**
	 * 编号最大值
	 * 
	 * @return
	 */
	public Integer selectMaxCode(@Param("companyId") Integer companyId) {
		return this.cookbookDAO.selectMaxCode(companyId);
	}
}
