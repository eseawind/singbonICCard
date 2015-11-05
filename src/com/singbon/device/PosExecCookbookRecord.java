package com.singbon.device;

import java.util.Calendar;
import java.util.Map;

import com.singbon.entity.ConsumeRecord;
import com.singbon.entity.Device;
import com.singbon.util.StringUtil;

/**
 * 处理订餐记录
 * 
 * @author 郝威
 * 
 */
public class PosExecCookbookRecord {

	// 分解订餐取餐记录
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static int cookbookRecord(Device device, Map map, byte[] b) {
		ConsumeRecord record = new ConsumeRecord();
		int baseIndex = 30;
		record.setUserId(StringUtil.hexToInt(baseIndex + 6, baseIndex + 9, b));
		record.setCardNO(StringUtil.hexToInt(baseIndex + 10, baseIndex + 13, b));
		record.setCardSeq(StringUtil.hexToInt(baseIndex + 14, baseIndex + 14, b));
		record.setDeviceName(device.getDeviceName());

		record.setSumFare(StringUtil.hexToInt(baseIndex + 15, baseIndex + 18, b));
		record.setOddFare(StringUtil.hexToInt(baseIndex + 19, baseIndex + 22, b));
		record.setDiscountFare(StringUtil.hexToInt(baseIndex + 23, baseIndex + 26, b));
		record.setSubsidyOddFare(StringUtil.hexToInt(baseIndex + 27, baseIndex + 30, b));
		record.setOpFare(StringUtil.hexToInt(baseIndex + 31, baseIndex + 34, b));
		record.setOpCount(StringUtil.hexToInt(baseIndex + 35, baseIndex + 36, b));
		record.setSubsidyOpCount(StringUtil.hexToInt(baseIndex + 37, baseIndex + 38, b));
		record.setSubsidyOpFare(StringUtil.hexToInt(baseIndex + 39, baseIndex + 42, b));
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, 2000 + StringUtil.byteToInt(b[43]));
		c.set(Calendar.MONTH, StringUtil.byteToInt(b[44]));
		c.set(Calendar.DAY_OF_MONTH, StringUtil.byteToInt(b[45]));
		c.set(Calendar.HOUR_OF_DAY, StringUtil.byteToInt(b[46]));
		c.set(Calendar.MINUTE, StringUtil.byteToInt(b[47]));
		c.set(Calendar.SECOND, StringUtil.byteToInt(b[48]));
		c.add(Calendar.MONTH, -1);
		record.setOpTime(StringUtil.dateFormat(c.getTime(), "yyyy-MM-dd HH:mm:ss"));
		int recordNO = StringUtil.hexToInt(baseIndex + 49, baseIndex + 50, b);
		record.setRecordNO(recordNO);
		record.setMealId(0);

		// 发送订餐记录到监控平台
		map.put("record", record);
		TerminalManager.sendToMonitor(map, device.getCompanyId());
		return recordNO;
	}

}
