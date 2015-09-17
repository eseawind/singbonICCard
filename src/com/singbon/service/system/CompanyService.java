package com.singbon.service.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.system.CompanyDAO;
import com.singbon.entity.Company;

/**
 * 公司业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CompanyService {

	@Autowired
	public CompanyDAO companyDAO;

	/**
	 * 获取公司
	 * 
	 * @return
	 */
	public Company selectById(Integer id) {
		return (Company) this.companyDAO.selectById(id);
	}

	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Company> selectAllList() {
		return this.companyDAO.selectAllList();
	}

	/**
	 * 保存系统密码设置
	 * 
	 * @param obj
	 * @return
	 */
	public void updateSystemPwd(Company company) {
		this.companyDAO.updateSystemPwd(company);
	}

	public int getSection(Integer companyId) {
		return 1;
	}
}
