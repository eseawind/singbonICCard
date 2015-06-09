package com.singbon.service.mainCard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.mainCard.MainCardDAO;
import com.singbon.entity.User;

/**
 * 制卡业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MainCardService {

	@Autowired
	public MainCardDAO mainCardDAO;

	/**
	 * 添加人员
	 * 
	 * @param user
	 */
	public void save(User user) {
		this.mainCardDAO.insert(user);
	}

	/**
	 * 修改人员
	 * 
	 * @param user
	 */
	public void update(User user) {
		this.mainCardDAO.update(user);
	}

	/**
	 * 删除未发卡人员
	 * 
	 * @param user
	 */
	public void delete(Integer deptId) {
		this.mainCardDAO.delete(deptId);
	}

	/**
	 * 根据主键查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectById(Integer id){
		return this.mainCardDAO.selectById(id);
	}
	
	/**
	 * 人员列表
	 * 
	 * @return
	 */
	public List<User> selectByCondition(Integer deptId, String searchStr) {
		return this.mainCardDAO.selectByCondition(deptId, searchStr);
	}
}
