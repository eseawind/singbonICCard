package com.singbon.service.systemManager;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Device;
import com.singbon.service.BaseService;

/**
 * 终端设备业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DeviceService extends BaseService {

	@Autowired
	public DeviceDAO deviceDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return deviceDAO;
	}

	/**
	 * 添加消费机验证
	 * 
	 * @param groupId
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map selectCountByInfo(Device device) {
		return this.deviceDAO.selectCountByInfo(device);
	}

	/**
	 * 删除设备
	 * 
	 * @param deviceGroup
	 * @return
	 * @throws Exception
	 */
	public void deleteDevice(Integer id, String sn) throws Exception {
		this.deviceDAO.delete(id);
		if (sn != null) {
			TerminalManager.SNToDeviceList.remove(sn);
		}
	}

	/**
	 * 读卡机被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectSysUserCountByDeviceId(Integer deviceId) {
		return this.deviceDAO.selectSysUserCountByDeviceId(deviceId);
	}

	/**
	 * 设备列表
	 * 
	 * @param companyId
	 * @param isCardReader
	 *            是否为读卡机 1是 0消费机
	 * @param onlyEnable
	 * @return
	 */
	public List<Device> selectDeviceListByCompanyId(Integer companyId, Integer isCardReader, Integer onlyEnable) {
		return this.deviceDAO.selectDeviceListByCompanyId(companyId, isCardReader, onlyEnable);
	}

	/**
	 * 系统所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList() {
		return this.deviceDAO.selectAllList();
	}
}
