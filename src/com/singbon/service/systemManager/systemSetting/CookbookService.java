package com.singbon.service.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.CookbookDAO;
import com.singbon.service.BaseService;

/**
 * 菜肴清单业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CookbookService extends BaseService {

	@Autowired
	public CookbookDAO cookbookDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return cookbookDAO;
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
