package com.singbon.service.systemManager;

import java.util.List;
import java.util.Map;

import org.comet4j.core.CometContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
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
	 * 添加设备
	 * 
	 * @param deviceGroup
	 * @return
	 * @throws Exception
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void insert(Device device) throws Exception {
		this.deviceDAO.insert(device);
		TerminalManager.SNToDeviceList.put(device.getSn(), device);
		if (device.getDeviceType() == 8) {
			TerminalManager.registChannel("c" + device.getSn());
		}
	}

	/**
	 * 修改设备
	 * 
	 * @param deviceGroup
	 * @return
	 * @throws Exception
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void update(Device device, String oldSn) throws Exception {
		this.deviceDAO.update(device);
		if (!device.getSn().equals(oldSn)) {
			TerminalManager.SNToDeviceList.remove(oldSn);
			if (device.getDeviceType() == 8) {
				TerminalManager.SNToSocketChannelList.remove(oldSn);
				CometContext.getInstance().getAppModules().remove("c" + oldSn);
				TerminalManager.registChannel("c" + device.getSn());
			} else {
				TerminalManager.SNToInetSocketAddressList.remove(oldSn);
			}
		}
		TerminalManager.SNToDeviceList.put(device.getSn(), device);
	}

	/**
	 * 删除设备
	 * 
	 * @param deviceGroup
	 * @return
	 * @throws Exception
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void deleteDevice(Integer id, boolean isCardReader, String sn) throws Exception {
		this.deviceDAO.delete(id);
		if (sn != null) {
			TerminalManager.SNToDeviceList.remove(sn);
			if (isCardReader) {
				TerminalManager.SNToSocketChannelList.remove(sn);
			} else {
				TerminalManager.SNToInetSocketAddressList.remove(sn);
			}
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
	 * 中转设备被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectPosCountByTransferId(Integer transferId) {
		return this.deviceDAO.selectPosCountByTransferId(transferId);
	}

	/**
	 * 设备列表
	 * 
	 * @param companyId
	 * @param deviceType
	 * @param onlyEnable
	 * @return
	 */
	public List<Device> selectDeviceListByCompanyId(Integer companyId, String deviceType, Integer onlyEnable) {
		return this.deviceDAO.selectDeviceListByCompanyId(companyId, deviceType, onlyEnable);
	}

	/**
	 * 设备列表根据营业部门
	 * 
	 * @param companyId
	 * @param deviceType
	 * @param onlyEnable
	 * @return
	 */
	public List<Device> selectPosListByDeptId(Integer deptId, Integer onlyEnable) {
		return this.deviceDAO.selectPosListByDeptId(deptId, onlyEnable);
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
