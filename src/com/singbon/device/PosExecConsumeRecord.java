package com.singbon.device;

import java.net.InetSocketAddress;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void run() {
		// 大帧：1为普通8为菜单
		int frame = b[30];
		ConsumeRecord record = new ConsumeRecord();
		int baseIndex = 30;

		record.setCompanyId(device.getCompanyId());

		int consumeType = (int) b[31];
		if (device.getDeviceType() == 3) {
			consumeType += 100;
		}
		record.setConsumeType(consumeType);
		record.setConsumeTypeDes(ConsumeType.getTypeDes(consumeType));

		record.setUserId(Long.parseLong(StringUtil.getHexStrFromBytes(baseIndex + 6, baseIndex + 9, b), 16));
		record.setCardNO(Long.parseLong(StringUtil.getHexStrFromBytes(baseIndex + 10, baseIndex + 13, b), 16));

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

		int addIndex = 0;
		// 订餐消费记录
		if (frame == 8) {
			record.setCookbookCode(StringUtil.hexToInt(baseIndex + 52, baseIndex + 53, b));
			record.setCookbookNum(StringUtil.hexToInt(baseIndex + 60, baseIndex + 61, b));
			addIndex = 11;
		}

		record.setRecordCount(StringUtil.hexToInt(baseIndex + addIndex + 52, baseIndex + addIndex + 53, b));
		record.setSubsidyAuth((b[baseIndex + addIndex + 60] >> 1) & 0x1);
		record.setCardSN(StringUtil.getHexStrFromBytes(baseIndex + addIndex + 67, baseIndex + addIndex + 70, b).toUpperCase());

		// 相差半分钟校时
		Calendar c1 = Calendar.getInstance();
		c1.set(StringUtil.objToInt("20" + StringUtil.getHexStrFromBytes(baseIndex + addIndex + 61, baseIndex + addIndex + 61, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(baseIndex + addIndex + 62, baseIndex + addIndex + 62, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(baseIndex + addIndex + 63, baseIndex + addIndex + 63, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(baseIndex + addIndex + 64, baseIndex + addIndex + 64, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(baseIndex + addIndex + 65, baseIndex + addIndex + 65, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(baseIndex + addIndex + 66, baseIndex + addIndex + 66, b)));
		c1.add(Calendar.MONTH, -1);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(new Date());

		if (Math.abs(c1.getTimeInMillis() - c2.getTimeInMillis()) > 30000) {
			String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys07, 2) + StringUtil.hexLeftPad(PosSubFrameSys07.SysTime, 2) + "0000" + "0000" + StringUtil.timeToHexStr() + "0000";
			String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
			sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen
					+ sendBufStr;
			byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
			try {
				TerminalManager.sendToPos(inetSocketAddress, sendBuf);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		int lastBatchId = Integer.parseInt(StringUtil.getHexStrFromBytes(baseIndex + 54, baseIndex + 55, b), 16);
		long lastBlackNum = Long.parseLong(StringUtil.getHexStrFromBytes(baseIndex + 56, baseIndex + 59, b), 16);

		// 自动下载批次黑名单
		long sysLastBatchId = 0;
		if (TerminalManager.CompanyIdToLastBatchIdList.containsKey(device.getCompanyId())) {
			sysLastBatchId = TerminalManager.CompanyIdToLastBatchIdList.get(device.getCompanyId());
		}
		long sysLastBlackNum = 0;
		if (TerminalManager.CompanyIdToLastBlackNumList.containsKey(device.getCompanyId())) {
			sysLastBlackNum = TerminalManager.CompanyIdToLastBlackNumList.get(device.getCompanyId());
		}
		if (lastBatchId != sysLastBatchId) {
			PosExecBatchBlack black = new PosExecBatchBlack(lastBatchId, device);
			black.run();
		}

		// 自动下载黑名单
		if (lastBlackNum != sysLastBlackNum) {
			PosExecCardBlack black = new PosExecCardBlack(lastBlackNum, device);
			black.run();
		}

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
