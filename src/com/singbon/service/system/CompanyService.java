package com.singbon.service.system;

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
	
	public int getSection(Integer companyId){
		return 1;
	}
}
