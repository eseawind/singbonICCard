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
public interface DeviceDAO extends BaseDAO{


	/**
	 * 通过operId查找
	 * 
	 * @return
	 */
	public Device selectByOperId(@Param("operId") Integer operId);
	
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
