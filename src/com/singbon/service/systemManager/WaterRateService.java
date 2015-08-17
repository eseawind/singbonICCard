package com.singbon.service.systemManager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.WaterRateDAO;
import com.singbon.entity.WaterRate;

/**
 * 水控费率2、3、4业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class WaterRateService {

	@Autowired
	public WaterRateDAO waterRateDAO;

	/**
	 * 添加
	 * 
	 * @param WaterRate
	 */
	public void insert(Integer companyId) {
		this.waterRateDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param WaterRate
	 */
	public void update(WaterRate waterRate) {
		this.waterRateDAO.update(waterRate);
	}

	/**
	 * 列表
	 * 
	 * @return
	 */
	public List<WaterRate> selectList(Integer companyId) {

		return this.waterRateDAO.selectList(companyId);
	}
}
