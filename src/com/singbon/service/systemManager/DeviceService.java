package com.singbon.service.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.entity.Device;

/**
 * 终端设备业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DeviceService {

	@Autowired
	public DeviceDAO deviceDAO;

	/**
	 * 添加
	 * 
	 * @param device
	 */
	public void insert(Device device) {
		this.deviceDAO.insert(device);
	}

	/**
	 * 修改
	 * 
	 * @param device
	 */
	public void update(Device device) {
		this.deviceDAO.update(device);
	}

	/**
	 * 通过userId查找
	 * 
	 * @return
	 */
	public Device selectByUserId(Integer userId) {
		return this.deviceDAO.selectByUserId(userId);
	}

	/**
	 * 列表
	 * 
	 * @return
	 */
	public List<Device> selectList(Integer companyId) {
		return this.deviceDAO.selectList(companyId);
	}

	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList() {
		return this.deviceDAO.selectAllList();
	}
}
