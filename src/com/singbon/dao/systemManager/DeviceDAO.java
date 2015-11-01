package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Device;

/**
 * 终端设备dao层
 * 
 * @author 郝威
 * 
 */
public interface DeviceDAO extends BaseDAO {

	/**
	 * 根据分组查询列表
	 * 
	 * @param groupId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectPosListByGroupId(Integer groupId, Integer onlyEnable);
	
	/**
	 * 读卡机列表
	 * @param companyId
	 * @param onlyEnable 1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectCardReaderListByCompanyId(@Param("companyId") Integer companyId);
	
	/**
	 * 消费机列表
	 * @param companyId
	 * @param onlyEnable 1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectPosList(@Param("companyId") Integer companyId, @Param("onlyEnable") Integer onlyEnable);

	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList();

}
