package com.singbon.service.monitor;

import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.dao.systemManager.systemSetting.BatchDAO;
import com.singbon.dao.systemManager.systemSetting.ConsumeParamDAO;
import com.singbon.dao.systemManager.systemSetting.CookbookDAO;
import com.singbon.dao.systemManager.systemSetting.DiscountDAO;
import com.singbon.dao.systemManager.systemSetting.MealDAO;
import com.singbon.dao.systemManager.systemSetting.OrderTimeDAO;
import com.singbon.dao.systemManager.systemSetting.PosParamGroupDAO;
import com.singbon.dao.systemManager.systemSetting.WaterRateGroupDAO;
import com.singbon.device.CommandDevice;
import com.singbon.device.DeviceCommunicateStr;
import com.singbon.device.DeviceType;
import com.singbon.device.PosFrame;
import com.singbon.device.PosSubFrameBlack;
import com.singbon.device.PosSubFrameCookbook;
import com.singbon.device.PosSubFrameStatus;
import com.singbon.device.PosSubFrameSys04;
import com.singbon.device.PosSubFrameSys07;
import com.singbon.device.SendCommand;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.ConsumeParam;
import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.entity.Discount;
import com.singbon.entity.Meal;
import com.singbon.entity.OrderTime;
import com.singbon.entity.PosParamGroup;
import com.singbon.entity.WaterRateGroup;
import com.singbon.util.DesUtil;
import com.singbon.util.StringUtil;

/**
 * 采集监控业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MonitorService implements Runnable {

	@Autowired
	public DeviceDAO deviceDAO;
	@Autowired
	public ConsumeParamDAO consumeParamDAO;
	@Autowired
	public PosParamGroupDAO posParamGroupDAO;
	@Autowired
	public WaterRateGroupDAO waterRateGroupDAO;
	@Autowired
	public MealDAO mealDAO;
	@Autowired
	public OrderTimeDAO orderTimeDAO;
	@Autowired
	public DiscountDAO discountDAO;
	@Autowired
	public CookbookDAO cookbookDAO;
	@Autowired
	public BatchDAO batchDAO;

	private List<Device> deviceList;

	public void setDeviceList(List<Device> deviceList) {
		this.deviceList = deviceList;
	}

	/**
	 * 校时
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void time(Device device, InetSocketAddress inetSocketAddress, Integer commandCode) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad((int) PosFrame.Sys07, 2) + StringUtil.hexLeftPad((int) PosSubFrameSys07.SysTime, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4)
				+ StringUtil.timeToHexStr() + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 补助授权
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void grantSubsidy(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		String date = sendCommand.getCompany().getSubsidyInvalidDate();
		if (StringUtils.isEmpty(date))
			return;
		String[] times = date.split("-");
		byte year = (byte) (Integer.valueOf(times[0]) - 2000);
		byte month = (byte) ((int) Integer.valueOf(times[1]));
		byte day = (byte) ((int) Integer.valueOf(times[2]));
		String d1 = Integer.toHexString((byte) (year << 1) | (month >> 3));
		String d2 = Integer.toHexString((byte) (month << 5 | day));
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys07, 2) + StringUtil.hexLeftPad(PosSubFrameSys07.GrantSubsidy, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ StringUtil.hexLeftPad(sendCommand.getCompany().getSubsidyVersion(), 4) + StringUtil.strLeftPadWithChar(d1, 2, "0") + StringUtil.strLeftPadWithChar(d2, 2, "0") + "00" + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 授权回收
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void disableSubsidy(Device device, InetSocketAddress inetSocketAddress, Integer commandCode) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys07, 2) + StringUtil.hexLeftPad(PosSubFrameSys07.DisableSubsidy, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 获取设备状态
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void getStatus(Device device, InetSocketAddress inetSocketAddress, Integer commandCode) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Status, 2) + StringUtil.hexLeftPad(PosSubFrameStatus.Ask, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + StringUtil.timeToHexStr()
				+ "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 消费参数
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void consumeParam(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws Exception {
		ConsumeParam p = command.getConsumeParam();
		if (p == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys04, 2) + StringUtil.hexLeftPad(PosSubFrameSys04.ConsumeParam, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4);
		// 消费机参数
		if (device.getDeviceType() == 2) {
			PosParamGroup pos = command.getPosParamGroup();
			if (pos == null)
				return;
			sendBufStr += "00000000000000" + StringUtil.hexLeftPad(p.getCardMinFare(), 2) + StringUtil.hexLeftPad(p.getDayLimitFare() * 100, 4) + StringUtil.hexLeftPad(p.getTimeLimitFare() * 100, 4)
					+ "00" + StringUtil.hexLeftPad(pos.getSubsidyReset(), 2) + StringUtil.hexLeftPad(pos.getSubsidyFirst(), 2) + "00000000" + StringUtil.hexLeftPad(pos.getBound(), 2)
					+ StringUtil.getPosCardTypesHexStr(p.getCardMinFareCardTypes()) + StringUtil.getPosCardTypesHexStr(p.getDayLimitFareCardTypes())
					+ StringUtil.getPosCardTypesHexStr(p.getTimeLimitFareCardTypes())
					+ StringUtil.binaryHexStr("" + pos.getEnableMeal() + pos.getEnableDiscount() + pos.getEnableDayLimitFare() + pos.getEnableTimeLimitFare() + pos.getEnableCardMinFare()) + "0000";
		} else {
			WaterRateGroup w = command.getWaterRateGroup();
			if (w == null)
				return;
			sendBufStr += StringUtil
					.binaryHexStr("" + w.getStopWaterType() + w.getSubsidyFirst() + w.getGoWaterType() + w.getRate1Status() + "0" + w.getSubsidyReset() + w.getRate1NextDayReset() + "0")
					+ StringUtil.hexLeftPad(w.getRate1Fare(), 4) + StringUtil.getWaterDeduceCycle(w, w.getRate1Cycle(), w.getRate1Water()) + "00" + StringUtil.hexLeftPad(p.getCardMinFare(), 2) + "00"
					+ StringUtil.hexLeftPad(w.getPwd(), 4) + StringUtil.hexLeftPad(w.getConsumeType(), 2) + StringUtil.hexLeftPad(w.getRate5Fare(), 4)
					+ StringUtil.getWaterDeduceCycle(w, w.getRate5Cycle(), w.getRate5Water()) + StringUtil.hexLeftPad(w.getBound(), 2) + "0000" + StringUtil.hexLeftPad(p.getDayLimitFare(), 4)
					+ StringUtil.getWaterCardTypesHexStr(w.getRate1CardTypes()) + StringUtil.hexLeftPad(p.getTimeLimitFare(), 4) + StringUtil.getPosCardTypesHexStr(p.getCardMinFareCardTypes())
					+ StringUtil.getPosCardTypesHexStr(p.getDayLimitFareCardTypes()) + StringUtil.getPosCardTypesHexStr(p.getTimeLimitFareCardTypes())
					+ StringUtil.binaryHexStr("" + w.getEnableMeal() + w.getEnableDiscount() + w.getEnableDayLimitFare() + w.getEnableTimeLimitFare() + w.getEnableCardMinFare())
					+ StringUtil.getWaterRateTime(w.getRate2BeginTime(), w.getRate2EndTime()) + StringUtil.hexLeftPad(w.getRate2Fare(), 4)
					+ StringUtil.getWaterDeduceCycle(w, w.getRate2Cycle(), w.getRate2Water()) + StringUtil.getWaterCardTypesHexStr(w.getRate2CardTypes())
					+ StringUtil.getWaterRateTime(w.getRate3BeginTime(), w.getRate3EndTime()) + StringUtil.hexLeftPad(w.getRate3Fare(), 4)
					+ StringUtil.getWaterDeduceCycle(w, w.getRate3Cycle(), w.getRate3Water()) + StringUtil.getWaterCardTypesHexStr(w.getRate3CardTypes())
					+ StringUtil.getWaterRateTime(w.getRate4BeginTime(), w.getRate4EndTime()) + StringUtil.hexLeftPad(w.getRate4Fare(), 4)
					+ StringUtil.getWaterDeduceCycle(w, w.getRate4Cycle(), w.getRate4Water()) + StringUtil.getWaterCardTypesHexStr(w.getRate4CardTypes()) + StringUtil.hexLeftPad(w.getWaterLimit(), 4)
					+ StringUtil.hexLeftPad(w.getCycleLimit(), 4) + StringUtil.hexLeftPad(w.getWaterPrecision(), 4) + StringUtil.hexLeftPad(w.getEnableAutoCalcRate(), 2) + "0000";
		}
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;

		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 参别限次
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void meal(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws Exception {
		List<Meal> mealList = command.getMealList();
		if (mealList == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys04, 2) + StringUtil.hexLeftPad(PosSubFrameSys04.Meal, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4);
		for (Meal meal : mealList) {
			String beginTimeHour = StringUtil.hexLeftPad(Integer.parseInt(meal.getBeginTime().substring(0, 2)), 2);
			String beginTimeMin = StringUtil.hexLeftPad(Integer.parseInt(meal.getBeginTime().substring(3, 5)), 2);
			String endTimeHour = StringUtil.hexLeftPad(Integer.parseInt(meal.getEndTime().substring(0, 2)), 2);
			String endTimeMin = StringUtil.hexLeftPad(Integer.parseInt(meal.getEndTime().substring(3, 5)), 2);
			String timeLimit = StringUtil.hexLeftPad(meal.getTimeLimit(), 2);
			sendBufStr += (beginTimeHour + beginTimeMin + endTimeHour + endTimeMin + timeLimit);
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 折扣费率及管理费
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void discount(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws Exception {
		List<Discount> discountList = command.getDiscountList();
		if (discountList == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys04, 2) + StringUtil.hexLeftPad(PosSubFrameSys04.Discount, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4);
		for (Discount discount : discountList) {
			String rate = StringUtil.hexLeftPad(discount.getRate(), 2);
			sendBufStr += ("00" + rate);
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 系统密码
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void sysPwd(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws Exception {
		Company company = command.getCompany();
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys04, 2) + StringUtil.hexLeftPad(PosSubFrameSys04.SysPwd, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4)
				+ StringUtil.getSysPwd(company) + StringUtil.hexLeftPad(company.getBaseSection(), 2) + StringUtil.hexLeftPad(company.getHeartInterval(), 4)
				+ StringUtil.hexLeftPad(company.getUploadInterval(), 4) + StringUtil.hexLeftPad(company.getUploadErrTime(), 2) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 单位名称
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void companyName(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys04, 2) + StringUtil.hexLeftPad(PosSubFrameSys04.SetCompanyName, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4)
				+ StringUtil.strRightPad(StringUtil.strToGB2312(command.getCompany().getCompanyName()), 64) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 订餐时间段
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void orderTime(Device device, InetSocketAddress inetSocketAddress, byte subFrame, SendCommand command, Integer beginIndex, Integer endIndex) throws Exception {
		List<OrderTime> orderTimeList = command.getOrderTimeList();
		if (orderTimeList == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(subFrame, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4);
		for (int i = beginIndex; i < endIndex; i++) {
			OrderTime orderTime = orderTimeList.get(i);
			String time = StringUtil.hexLeftPad(Integer.parseInt(orderTime.getBeginTime().substring(0, 2)), 2) + StringUtil.hexLeftPad(Integer.parseInt(orderTime.getBeginTime().substring(3, 5)), 2)
					+ StringUtil.hexLeftPad(Integer.parseInt(orderTime.getEndTime().substring(0, 2)), 2) + StringUtil.hexLeftPad(Integer.parseInt(orderTime.getEndTime().substring(3, 5)), 2);
			sendBufStr += time;
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 菜肴清单更新
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void updateCookbook(Device device, InetSocketAddress inetSocketAddress, Integer commandCode) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(PosSubFrameCookbook.Update, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 菜肴清单追加
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void appendCookbook(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		Cookbook cookbook = sendCommand.getCookbook();
		if (cookbook == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(PosSubFrameCookbook.Append, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ StringUtil.hexLeftPad(cookbook.getCookbookCode(), 4) + StringUtil.hexLeftPad(cookbook.getPrice() * 100, 8)
				+ StringUtil.strRightPad(StringUtil.strToGB2312(cookbook.getCookbookName()), 32) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 获取最后菜单编号
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void getLastNumCookbook(Device device, InetSocketAddress inetSocketAddress, Integer commandCode) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(PosSubFrameCookbook.GetLastNum, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 修改菜单
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void modifyCookbook(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		Cookbook cookbook = sendCommand.getCookbook();
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(PosSubFrameCookbook.Modify, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ StringUtil.hexLeftPad(cookbook.getCookbookCode(), 4) + StringUtil.hexLeftPad(cookbook.getPrice() * 100, 8)
				+ StringUtil.strRightPad(StringUtil.strToGB2312(cookbook.getCookbookName()), 32) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 批次更新
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void batchUpdate(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Black, 2) + StringUtil.hexLeftPad(PosSubFrameBlack.BatchUpdate, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 批次追加
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void batchAppend(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Black, 2) + StringUtil.hexLeftPad(PosSubFrameBlack.BatchAppend, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ sendCommand.getBatchIds() + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 黑名单更新
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void blackUpdate(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Black, 2) + StringUtil.hexLeftPad(PosSubFrameBlack.AllUpdate, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 黑名单追加
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void blackAppend(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Black, 2) + StringUtil.hexLeftPad(PosSubFrameBlack.IncAppend, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ sendCommand.getBlackNums() + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 初始化
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 * @throws Exception
	 */
	public void sysInit(Device device, InetSocketAddress inetSocketAddress, Integer commandCode) throws Exception {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.SysInit, 2) + StringUtil.hexLeftPad(PosSubFrameSys07.SysInit, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/*
	 * 监控线程
	 */
	public void run() {
		boolean stop = false;
		while (!stop) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				stop = true;
				// e1.printStackTrace();
			}
			for (Device d : this.deviceList) {
				String sn = d.getSn();
				InetSocketAddress inetSocketAddress = TerminalManager.SNToInetSocketAddressList.get(sn);
				if (inetSocketAddress == null) {
					continue;
				}

				// 当前设备命令列表
				List<SendCommand> sendCommandList = null;
				// 当前命令
				SendCommand sendCommand = null;
				// 同步执行当前命令
				synchronized (TerminalManager.sendCommandObject) {
					sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
					if (sendCommandList != null && sendCommandList.size() > 0) {
						StringUtil.println("命令个数：" + sendCommandList.size());
						sendCommand = sendCommandList.get(0);
						// 访问次数
						int sendTime = sendCommand.getSendTime();
						if (sendTime >= 5) {
							sendCommandList.clear();
							continue;
						}
						try {
							excuteCommand(d, inetSocketAddress, sendCommand);
							sendCommand.setSendTime(++sendTime);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}

				// 如果没有命令，继续询问下个设备
				if (sendCommandList == null || sendCommandList.size() == 0) {
					continue;
				}

				// 检测命令是否执行，比较命令列表里的第0命令和当前执行的命令是否一致
				try {
					// 等待消除网络延时
					Thread.sleep(1000);

					for (int i = 0; i < 5; i++) {
						synchronized (TerminalManager.sendCommandObject) {
							List<SendCommand> sendCommandList2 = TerminalManager.SNToSendCommandList.get(sn);
							if (sendCommandList2.size() > 0) {
								SendCommand tempSendCommand = sendCommandList2.get(0);
								if (sendCommand != tempSendCommand) {
									System.out.println("f" + sendCommand.getSendTime());
									break;
								}
							} else {
								// 列表为空说明执行完毕
								break;
							}
						}
						System.out.println("nf" + sendCommand.getSendTime());
						Thread.sleep(200);
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
					stop = true;
					break;
				}
			}
		}
	}

	/**
	 * 执行处理命令
	 * 
	 * @param d
	 * @param datagramChannel
	 * @param socketAddress
	 * @param sendCommand
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void excuteCommand(Device d, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws Exception {
		byte frame = sendCommand.getFrame();
		Map map = new HashMap();
		map.put("type", "log");
		map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
		map.put("from", d.getDeviceName());
		switch (frame) {
		// 系统07
		case PosFrame.Sys07:
			if (sendCommand.getSubFrame() == PosSubFrameSys07.SysTime) {
				time(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendSysTime));
				// 补助授权
			} else if (sendCommand.getSubFrame() == PosSubFrameSys07.GrantSubsidy) {
				grantSubsidy(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendGrantSubsidy));
				// 补助回收
			} else if (sendCommand.getSubFrame() == PosSubFrameSys07.DisableSubsidy) {
				disableSubsidy(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendDisableSubsidy));
			}
			break;
		// 系统状态
		case PosFrame.Status:
			if (sendCommand.getSubFrame() == PosSubFrameStatus.Ask) {
				getStatus(d, inetSocketAddress, sendCommand.getCommandCode());
			}
			break;
		// 系统04
		case PosFrame.Sys04:
			if (sendCommand.getSubFrame() == PosSubFrameSys04.ConsumeParam) {
				consumeParam(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendConsumeParam));
			} else if (sendCommand.getSubFrame() == PosSubFrameSys04.Meal) {
				meal(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendMeal));
			} else if (sendCommand.getSubFrame() == PosSubFrameSys04.Discount) {
				discount(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendDiscount));
			} else if (sendCommand.getSubFrame() == PosSubFrameSys04.SetCompanyName) {
				companyName(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendCompanyName));
			} else if (sendCommand.getSubFrame() == PosSubFrameSys04.SysPwd) {
				sysPwd(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendSysPwd));
			}
			break;
		// 菜单
		case PosFrame.Cookbook:
			if (sendCommand.getSubFrame() == PosSubFrameCookbook.Update) {
				updateCookbook(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendUpdate));
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.Append) {
				appendCookbook(d, inetSocketAddress, sendCommand);
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.SendAppend), sendCommand.getCookbookIndex(), sendCommand.getCookbookTotal(), cookbook.getCookbookCode(),
						cookbook.getPrice(), cookbook.getCookbookName());
				map.put("des", log);
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.GetLastNum) {
				getLastNumCookbook(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendGetLastNumCookbook));
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.Modify) {
				modifyCookbook(d, inetSocketAddress, sendCommand);
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.SendModifyCookbook), cookbook.getCookbookCode(), cookbook.getPrice(), cookbook.getCookbookName());
				map.put("des", log);
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.OrderTime1) {
				orderTime(d, inetSocketAddress, PosSubFrameCookbook.OrderTime1, sendCommand, 0, 6);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendOrderTime1));
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.OrderTime2) {
				orderTime(d, inetSocketAddress, PosSubFrameCookbook.OrderTime2, sendCommand, 6, 12);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendOrderTime2));
			} else
				break;
			// 黑名单
		case PosFrame.Black:
			if (sendCommand.getSubFrame() == PosSubFrameBlack.BatchUpdate) {
				batchUpdate(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendBatchUpdate));
			} else if (sendCommand.getSubFrame() == PosSubFrameBlack.BatchAppend) {
				batchAppend(d, inetSocketAddress, sendCommand);
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.SendBatchAppend), sendCommand.getBatchNames());
				map.put("des", log);
			} else if (sendCommand.getSubFrame() == PosSubFrameBlack.AllUpdate) {
				blackUpdate(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendBlackUpdate));
			} else if (sendCommand.getSubFrame() == PosSubFrameBlack.IncAppend) {
				blackAppend(d, inetSocketAddress, sendCommand);
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.SendBlackAppend), sendCommand.getBlackNumsDes());
				map.put("des", log);
			}
			break;
		// 初始化
		case PosFrame.SysInit:
			if (sendCommand.getSubFrame() == PosSubFrameSys07.SysInit) {
				sysInit(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendSysInit));
			}
			break;

		default:
			break;
		}
		if (map.size() > 3) {
			TerminalManager.sendToMonitor(map, d.getCompanyId());
		}
	}

	/**
	 * 添加命令
	 * 
	 * @param device
	 * @param cmd
	 * @param commandIndex
	 * @param sendCommandList
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void addCommand(Company company, Device device, String cmd, Integer cookbookCode, Integer commandIndex, ArrayList<SendCommand> sendCommandList) {
		// 校时
		if ("sysTime".equals(cmd)) {
			if (sendCommandList.size() > 0) {
				SendCommand firstSendCommand = sendCommandList.get(0);
				if (firstSendCommand.getCommandCode() == 0) {
					return;
				}
			}
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Sys07);
			sendCommand.setSubFrame(PosSubFrameSys07.SysTime);
			sendCommand.setCommandCode(0);
			sendCommandList.add(0, sendCommand);
			// 获取设备状态
		} else if ("getStatus".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Status);
			sendCommand.setSubFrame(PosSubFrameStatus.Ask);
			sendCommand.setCommandCode(1);
			sendCommandList.add(sendCommand);
			// 消费类参数
		} else if ("baseConsumeParam".equals(cmd)) {
			// 设置消费参数
			ConsumeParam consumeParam = (ConsumeParam) consumeParamDAO.selectByCompanyId(company.getId());
			// 设置餐别限次
			List<Meal> mealList = (List<Meal>) mealDAO.selectListByCompanyId(company.getId());
			// 折扣费率及管理费
			List<Discount> discountList = (List<Discount>) discountDAO.selectListByCompanyId(company.getId());

			// 消费参数
			SendCommand sendCommand1 = new SendCommand();
			sendCommand1.setFrame(PosFrame.Sys04);
			sendCommand1.setSubFrame(PosSubFrameSys04.ConsumeParam);
			sendCommand1.setCommandCode(commandIndex++);
			sendCommand1.setConsumeParam(consumeParam);
			if (device.getDeviceType() == 2) {
				// 消费机参数组
				PosParamGroup posParamGroup = (PosParamGroup) posParamGroupDAO.selectById(device.getParamGroupId());
				sendCommand1.setPosParamGroup(posParamGroup);
			} else {
				// 水控参数组
				WaterRateGroup waterRateGroup = (WaterRateGroup) waterRateGroupDAO.selectById(3);
				sendCommand1.setWaterRateGroup(waterRateGroup);
			}

			// 参别限次
			SendCommand sendCommand2 = new SendCommand();
			sendCommand2.setFrame(PosFrame.Sys04);
			sendCommand2.setSubFrame(PosSubFrameSys04.Meal);
			sendCommand2.setCommandCode(commandIndex++);
			sendCommand2.setMealList(mealList);

			// 优惠方案
			SendCommand sendCommand3 = new SendCommand();
			sendCommand3.setFrame(PosFrame.Sys04);
			sendCommand3.setSubFrame(PosSubFrameSys04.Discount);
			sendCommand3.setCommandCode(commandIndex++);
			sendCommand3.setDiscountList(discountList);

			sendCommandList.add(sendCommand1);
			sendCommandList.add(sendCommand2);
			sendCommandList.add(sendCommand3);

			// 如果是水控不添加订餐时间段
			if (device.getDeviceType() == 3)
				return;
			// 设置订餐时间段
			List<OrderTime> orderTimeList = (List<OrderTime>) orderTimeDAO.selectListByCompanyId(company.getId());
			SendCommand sendCommand4 = new SendCommand();
			sendCommand4.setFrame(PosFrame.Cookbook);
			sendCommand4.setSubFrame(PosSubFrameCookbook.OrderTime1);
			sendCommand4.setCommandCode(commandIndex++);
			sendCommand4.setOrderTimeList(orderTimeList);

			SendCommand sendCommand5 = new SendCommand();
			sendCommand5.setFrame(PosFrame.Cookbook);
			sendCommand5.setSubFrame(PosSubFrameCookbook.OrderTime2);
			sendCommand5.setCommandCode(commandIndex++);
			sendCommand5.setOrderTimeList(orderTimeList);
			sendCommandList.add(sendCommand4);
			sendCommandList.add(sendCommand5);
			// 设备参数
		} else if ("deviceParam".equals(cmd)) {
			// 单位名称
			SendCommand sendCommand1 = new SendCommand();
			sendCommand1.setFrame(PosFrame.Sys04);
			sendCommand1.setSubFrame(PosSubFrameSys04.SetCompanyName);
			sendCommand1.setCompany(company);
			sendCommand1.setCommandCode(commandIndex++);

			// 系统密码
			SendCommand sendCommand2 = new SendCommand();
			sendCommand2.setFrame(PosFrame.Sys04);
			sendCommand2.setSubFrame(PosSubFrameSys04.SysPwd);
			sendCommand2.setCompany(company);
			sendCommand2.setCommandCode(commandIndex++);

			sendCommandList.add(sendCommand1);
			sendCommandList.add(sendCommand2);
			// 补助授权
		} else if ("grantSubsidy".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Sys07);
			sendCommand.setSubFrame(PosSubFrameSys07.GrantSubsidy);
			sendCommand.setCompany(company);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);
			// 补助回收
		} else if ("disableSubsidy".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Sys07);
			sendCommand.setSubFrame(PosSubFrameSys07.DisableSubsidy);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);
			// 全部菜肴清单
		} else if ("allCookbook".equals(cmd)) {
			for (SendCommand sc : sendCommandList) {
				if (sc.getFrame() == PosFrame.Cookbook
						&& (sc.getSubFrame() == PosSubFrameCookbook.Update || sc.getSubFrame() == PosSubFrameCookbook.Append || sc.getSubFrame() == PosSubFrameCookbook.GetLastNum)) {
					Map map = new HashMap();
					map.put("type", "log");
					map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
					map.put("from", device.getDeviceName());
					map.put("des", DesUtil.decrypt(DeviceCommunicateStr.CookbookAdded));
					TerminalManager.sendToMonitor(map, company.getId());
					return;
				}
			}
			List<Cookbook> cookbookList = (List<Cookbook>) cookbookDAO.selectListByCompanyId(company.getId());

			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Cookbook);
			sendCommand.setSubFrame(PosSubFrameCookbook.Update);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);

			int index = 0;
			for (Cookbook cookbook : cookbookList) {
				SendCommand sendCommand2 = new SendCommand();
				sendCommand2.setFrame(PosFrame.Cookbook);
				sendCommand2.setSubFrame(PosSubFrameCookbook.Append);
				sendCommand2.setCookbook(cookbook);
				sendCommand2.setCommandCode(commandIndex++);
				sendCommand2.setCookbookIndex(++index);
				sendCommand2.setCookbookTotal(cookbookList.size());
				sendCommandList.add(sendCommand2);
			}
			// 追加菜肴清单
		} else if ("appendCookbook".equals(cmd)) {
			for (SendCommand sc : sendCommandList) {
				if (sc.getSubFrame() == PosSubFrameCookbook.Update || sc.getSubFrame() == PosSubFrameCookbook.Append || sc.getSubFrame() == PosSubFrameCookbook.GetLastNum) {
					Map map = new HashMap();
					map.put("type", "log");
					map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
					map.put("from", device.getDeviceName());
					map.put("des", DesUtil.decrypt(DeviceCommunicateStr.CookbookAdded));
					TerminalManager.sendToMonitor(map, company.getId());
					return;
				}
			}

			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Cookbook);
			sendCommand.setSubFrame(PosSubFrameCookbook.GetLastNum);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);

			List<Cookbook> cookbookList = (List<Cookbook>) cookbookDAO.selectListByCompanyId(company.getId());

			int index = 0;
			for (Cookbook cookbook : cookbookList) {
				SendCommand sendCommand2 = new SendCommand();
				sendCommand2.setFrame(PosFrame.Cookbook);
				sendCommand2.setSubFrame(PosSubFrameCookbook.Append);
				sendCommand2.setCookbook(cookbook);
				sendCommand2.setCommandCode(commandIndex++);
				sendCommand2.setCookbookIndex(++index);
				sendCommand2.setCookbookTotal(cookbookList.size());
				sendCommandList.add(sendCommand2);
			}
			// 修改菜肴清单
		} else if ("modifyCookbook".equals(cmd)) {
			Cookbook cookbook = (Cookbook) this.cookbookDAO.selectById(cookbookCode);
			if (cookbook == null) {
				Map map = new HashMap();
				map.put("type", "log");
				map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
				map.put("from", device.getDeviceName());
				String des = String.format(DesUtil.decrypt(DeviceCommunicateStr.NotExsitCookbook), cookbookCode);
				map.put("des", des);
				TerminalManager.sendToMonitor(map, company.getId());
				return;
			}
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Cookbook);
			sendCommand.setSubFrame(PosSubFrameCookbook.Modify);
			sendCommand.setCookbook(cookbook);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);
			// 批次更新
		} else if ("batchUpdate".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Black);
			sendCommand.setSubFrame(PosSubFrameBlack.BatchUpdate);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);
			// 黑名单更新
		} else if ("blackUpdate".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Black);
			sendCommand.setSubFrame(PosSubFrameBlack.AllUpdate);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);
			// 初始化
		} else if ("sysInit".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.SysInit);
			sendCommand.setSubFrame(PosSubFrameSys07.SysInit);
			sendCommand.setCommandCode(0);
			sendCommandList.clear();
			sendCommandList.add(sendCommand);
			// 清空命令
		} else if ("clear".equals(cmd)) {
			sendCommandList.clear();
		}
	}
}
