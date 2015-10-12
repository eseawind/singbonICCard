package com.singbon.service.balanceCenter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.common.UserDAO;
import com.singbon.entity.Pagination;
import com.singbon.entity.User;
import com.singbon.service.BaseService;

/**
 * 用户信息查询业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class UserInfoService extends BaseService {

	@Autowired
	public UserDAO userDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return userDAO;
	}

	/**
	 * 分页查询
	 * 
	 * @param nameStr
	 * @param deptId
	 * @param cardTypeId
	 * @param sex
	 * @param beginDate
	 * @param endDate
	 * @param status
	 * @return
	 */
	public List<User> selectByPage(Integer companyId, Pagination pagination, String nameStr, Integer deptId, Integer cardTypeId, Integer sex, Integer status, Integer dateType, String beginDate,
			String endDate) {
		return this.userDAO.selectByPage(companyId, pagination.getOffset(), pagination.getNumPerPage(), nameStr, deptId, cardTypeId, sex, status, dateType, beginDate, endDate);
	}
}
