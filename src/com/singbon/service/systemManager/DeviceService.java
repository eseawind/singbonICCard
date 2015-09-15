package com.singbon.service.systemManager;

import java.util.List;

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
	public Device selectByOperId(Integer operId) {
		return this.deviceDAO.selectByOperId(operId);
	}

	/**
	 * 消费机列表
	 * 
	 * @param companyId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectPosList(Integer companyId, Integer onlyEnable) {
		return this.deviceDAO.selectPosList(companyId, onlyEnable);
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
