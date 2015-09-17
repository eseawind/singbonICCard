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
	 * 通过operId查找
	 * 
	 * @return
	 */
	public Device selectByOperId(@Param("operId") Integer operId);

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
	 * 消费机列表
	 * @param companyId
	 * @param onlyEnable 1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectPosList(@Param("companyId") Integer companyId, @Param("onlyEnable") Integer onlyEnable);

	/**
	 * 列表
	 * 
	 * @return
	 */
	public List<Device> selectList(@Param("companyId") Integer companyId);

	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList();

}
