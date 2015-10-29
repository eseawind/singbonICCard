package com.singbon.service.systemManager;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.SubsidyDAO;
import com.singbon.entity.Subsidy;
import com.singbon.service.BaseService;

/**
 * 补助管理业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class SubsidyService extends BaseService {

	@Autowired
	public SubsidyDAO subsidyDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return subsidyDAO;
	}

	/**
	 * 添加补助准备
	 * 
	 * @param list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public void addSubsidy(Integer companyId, List<Map> list) throws Exception {
		for (Map m : list) {
			Integer userId = Integer.valueOf(m.get("userId").toString());
			int count = this.subsidyDAO.selectCountByUserId(userId);
			if (count > 0)
				return;

			Subsidy subsidy = new Subsidy();
			subsidy.setUserId(userId);
			subsidy.setCompanyId(companyId);
			subsidy.setSubsidyFare(Integer.valueOf(m.get("subsidyFare").toString()));
			this.subsidyDAO.insert(subsidy);
		}
	}
}
