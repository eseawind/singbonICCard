package com.singbon.device;

import java.net.InetSocketAddress;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.singbon.entity.ConsumeRecord;
import com.singbon.entity.Device;
import com.singbon.entity.Meal;
import com.singbon.util.JdbcUtil;
import com.singbon.util.StringUtil;

/**
 * 处理消费记录
 * 
 * @author 郝威
 * 
 */
public class PosExecConsumeRecord implements Runnable {

	private byte[] b;
	private Device device;
	private InetSocketAddress inetSocketAddress;

	public PosExecConsumeRecord(Device device, byte[] b, InetSocketAddress inetSocketAddress) {
		this.device = device;
		this.b = b;
		this.inetSocketAddress = inetSocketAddress;
	}

	// 分解消费记录
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void run() {
		// 大帧：1为普通8为菜单
		int frame = b[30];
		ConsumeRecord record = new ConsumeRecord();
		int baseIndex = 30;
		// Integer userId = StringUtil.hexToInt(baseIndex + 6, baseIndex + 9,
		// b);
		record.setCompanyId(device.getCompanyId());
		record.setUserId(StringUtil.hexToInt(baseIndex + 6, baseIndex + 9, b));
		record.setCardNO(StringUtil.hexToInt(baseIndex + 10, baseIndex + 13, b));
		record.setCardSeq(StringUtil.hexToInt(baseIndex + 14, baseIndex + 14, b));
		record.setDeviceId(device.getId());
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
		c.set(Calendar.YEAR, 2000 + StringUtil.byteToBCDInt(b[baseIndex + 43]));
		c.set(Calendar.MONTH, StringUtil.byteToBCDInt(b[baseIndex + 44]));
		c.set(Calendar.DAY_OF_MONTH, StringUtil.byteToBCDInt(b[baseIndex + 45]));
		c.set(Calendar.HOUR_OF_DAY, StringUtil.byteToBCDInt(b[baseIndex + 46]));
		c.set(Calendar.MINUTE, StringUtil.byteToBCDInt(b[baseIndex + 47]));
		c.set(Calendar.SECOND, StringUtil.byteToBCDInt(b[baseIndex + 48]));
		c.add(Calendar.MONTH, -1);
		record.setOpTime(StringUtil.dateFormat(c.getTime(), "yyyy-MM-dd HH:mm:ss"));
		int recordNO = StringUtil.hexToInt(baseIndex + 49, baseIndex + 50, b);
		record.setRecordNO(recordNO);

		int consumeType = (int) b[31];
		if (device.getDeviceType() == 3) {
			consumeType += 100;
		}
		record.setConsumeType(consumeType);
		record.setConsumeTypeDes(ConsumeType.getTypeDes(consumeType));

		List<Meal> mealList = TerminalManager.CompanyIdToMealList.get(device.getCompanyId());
		int mealId = 0;
		String opTime = StringUtil.dateFormat(c.getTime(), "HH:mm:ss");
		for (Meal m : mealList) {
			if (m.getBeginTime().compareTo(opTime) <= 0 && m.getEndTime().compareTo(opTime) >= 0) {
				mealId = m.getId();
				record.setMealName(m.getMealName());
			}
		}
		record.setMealId(mealId);

		// 订餐消费记录
		if (frame == 8) {
			record.setCookbookCode(StringUtil.hexToInt(baseIndex + 52, baseIndex + 53, b));
			record.setCookbookNum(StringUtil.hexToInt(baseIndex + 60, baseIndex + 60, b));
		}

		try {
			JdbcUtil.consumeRecordDAO.insert(record);
			if (record.getResult() == 1) {
				// 回复记录号
				String buf = StringUtil.getHexStrFromBytes(0, 27, b) + "000d0101" + StringUtil.strLeftPad("", 8) + StringUtil.hexLeftPad(recordNO, 4) + "000000";
				b = StringUtil.strTobytes(buf);
				try {
					TerminalManager.sendToPos(inetSocketAddress, b);
				} catch (Exception e) {
					e.printStackTrace();
				}
				if (recordNO != device.getLastRecordNO()) {
					Map map = new HashMap();
					map.put("type", "consumeRecord");
					map.put("consumeRecord", record);
					// 向监控平台发送命令
					TerminalManager.sendToMonitor(map, device.getCompanyId());
					device.setLastRecordNO(recordNO);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
