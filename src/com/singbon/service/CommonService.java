package com.singbon.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.entity.Company;

/**
 * 公共通用业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CommonService {

//	@Autowired
	//public CommonDAO commonDAO;

	@Transactional
	public void addUser() {
	}

	public List getUserDeptList(Company company) {
		return null;
	}
}
