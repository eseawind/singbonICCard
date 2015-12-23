package com.singbon.device;

import java.net.InetSocketAddress;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import com.singbon.entity.CookbookRecord;
import com.singbon.entity.Device;
import com.singbon.entity.Meal;
import com.singbon.util.JdbcUtil;
import com.singbon.util.StringUtil;

/**
 * 处理订餐记录
 * 
 * @author 郝威
 * 
 */
public class PosExecCookbookRecord implements Runnable {

	private byte[] b;
	@SuppressWarnings("rawtypes")
	private Map map;
	private Device device;
	private InetSocketAddress inetSocketAddress;

	@SuppressWarnings("rawtypes")
	public PosExecCookbookRecord(Device device, byte[] b, Map map, InetSocketAddress inetSocketAddress) {
		this.device = device;
		this.b = b;
		this.map = map;
		this.inetSocketAddress = inetSocketAddress;
	}

	// 分解订餐取餐记录
	@SuppressWarnings({ "unchecked" })
	public void run() {
		// 大帧：1为普通8为菜单
		CookbookRecord record = new CookbookRecord();
		int baseIndex = 30;

		record.setCompanyId(device.getCompanyId());

		record.setUserId(Long.parseLong(StringUtil.getHexStrFromBytes(baseIndex + 6, baseIndex + 9, b), 16));
		record.setCardNO(Long.parseLong(StringUtil.getHexStrFromBytes(baseIndex + 10, baseIndex + 13, b), 16));
		record.setCardSeq(StringUtil.hexToInt(baseIndex + 14, baseIndex + 14, b));
		record.setDeviceId(device.getId());
		record.setDeviceName(device.getDeviceName());

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

		record.setCookbookCode(StringUtil.hexToInt(baseIndex + 52, baseIndex + 53, b));
		record.setCookbookNum(StringUtil.hexToInt(baseIndex + 60, baseIndex + 61, b));

		record.setRecordCount(StringUtil.hexToInt(baseIndex + 52, baseIndex + 53, b));
		record.setSubsidyAuth((b[baseIndex + 60] >> 1) & 0x1);
		record.setCardSN(StringUtil.getHexStrFromBytes(baseIndex + 67, baseIndex + 70, b).toUpperCase());

		List<Meal> mealList = TerminalManager.CompanyIdToMealList.get(device.getCompanyId());
		int mealId = 0;
		String opTime = StringUtil.dateFormat(c.getTime(), "HH:mm:ss");
		if (mealList != null) {
			for (Meal m : mealList) {
				if (m.getBeginTime().compareTo(opTime) <= 0 && m.getEndTime().compareTo(opTime) >= 0) {
					mealId = m.getId();
					record.setMealName(m.getMealName());
				}
			}
		}
		record.setMealId(mealId);

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
					map.put("type", "cbr");
					map.put("record", record);
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
