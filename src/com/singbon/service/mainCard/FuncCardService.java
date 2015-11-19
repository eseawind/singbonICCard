package com.singbon.service.mainCard;

import java.nio.channels.SocketChannel;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.SysUserDAO;
import com.singbon.dao.systemManager.systemSetting.ConsumeParamDAO;
import com.singbon.dao.systemManager.systemSetting.DiscountDAO;
import com.singbon.dao.systemManager.systemSetting.MealDAO;
import com.singbon.device.CardReaderCommandCode;
import com.singbon.device.CardReaderFrame;
import com.singbon.device.CommandDevice;
import com.singbon.device.DeviceType;
import com.singbon.device.TerminalManager;
import com.singbon.entity.ConsumeParam;
import com.singbon.entity.Device;
import com.singbon.entity.Discount;
import com.singbon.entity.Meal;
import com.singbon.entity.WaterRateGroup;
import com.singbon.service.BaseService;
import com.singbon.util.StringUtil;

/**
 * 制功能卡业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class FuncCardService extends BaseService {

	@Autowired
	public SysUserDAO sysUserDAO;
	@Autowired
	public MealDAO mealDAO;
	@Autowired
	public DiscountDAO discountDAO;
	@Autowired
	public ConsumeParamDAO consumeParamDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return sysUserDAO;
	}

	/**
	 * 制功能卡
	 * 
	 * @param device
	 * @param socketChannel
	 * @param section
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void make(WaterRateGroup w, Device device, SocketChannel socketChannel, Integer baseSection) throws Exception {

		// 第2扇区 时间段费率2、3、4
		// 第0块 时间段费率2、3
		String rate2BeginTime = StringUtil.getWaterRateTime(w.getRate2BeginTime(), w.getRate2EndTime());// 4--0-3
		String rate2Fare = StringUtil.hexLeftPad(w.getRate2Fare(), 4);// 2--4-5
		String rate2Cycle = StringUtil.getWaterDeduceCycle(w, w.getRate2Cycle(), w.getRate2Water());// 2--6-7
		String rate3BeginTime = StringUtil.getWaterRateTime(w.getRate3BeginTime(), w.getRate3EndTime());// 4--8-11
		String rate3Fare = StringUtil.hexLeftPad(w.getRate3Fare(), 4);// 2--12-13
		String rate3Cycle = StringUtil.getWaterDeduceCycle(w, w.getRate3Cycle(), w.getRate3Water());// 2--14-15
		String section2Block0 = rate2BeginTime + rate2Fare + rate2Cycle + rate3BeginTime + rate3Fare + rate3Cycle;

		// 第1块 时间段费率2、3和2、3、4卡类型
		String rate4BeginTime = StringUtil.getWaterRateTime(w.getRate4BeginTime(), w.getRate4EndTime());// 4--0-3
		String rate4Fare = StringUtil.hexLeftPad(w.getRate4Fare(), 4);// 2--4-5
		String rate4Cycle = StringUtil.getWaterDeduceCycle(w, w.getRate4Cycle(), w.getRate4Water());// 2--6-7
		String rate2CardTypes = StringUtil.getWaterCardTypesHexStr(w.getRate2CardTypes());// 2--8-9
		String rate3CardTypes = StringUtil.getWaterCardTypesHexStr(w.getRate3CardTypes());// 2--10-11
		String rate4CardTypes = StringUtil.getWaterCardTypesHexStr(w.getRate4CardTypes());// 2--12-13
		String section2Block1 = rate4BeginTime + rate4Fare + rate4Cycle + rate2CardTypes + rate3CardTypes + rate4CardTypes + "0000";

		// 第2块 餐别限次后三
		List<Meal> mealList = (List<Meal>) this.mealDAO.selectListByCompanyId(device.getCompanyId());
		String section2Block2 = "";
		for (int i = 3; i < mealList.size(); i++) {
			String beginTimeHour = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getBeginTime().substring(0, 2)), 2);
			String beginTimeMin = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getBeginTime().substring(3, 5)), 2);
			String endTimeHour = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getEndTime().substring(0, 2)), 2);
			String endTimeMin = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getEndTime().substring(3, 5)), 2);
			String timeLimit = StringUtil.hexLeftPad(mealList.get(i).getTimeLimit(), 2);
			section2Block2 += (beginTimeHour + beginTimeMin + endTimeHour + endTimeMin + timeLimit);
		}
		section2Block2 += "00";

		// 第3扇区 餐别限次前三和优惠方案
		// 第0块 餐别限次前三
		String section3Block0 = "";
		for (int i = 0; i < mealList.size() - 3; i++) {
			String beginTimeHour = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getBeginTime().substring(0, 2)), 2);
			String beginTimeMin = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getBeginTime().substring(3, 5)), 2);
			String endTimeHour = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getEndTime().substring(0, 2)), 2);
			String endTimeMin = StringUtil.hexLeftPad(Integer.parseInt(mealList.get(i).getEndTime().substring(3, 5)), 2);
			String timeLimit = StringUtil.hexLeftPad(mealList.get(i).getTimeLimit(), 2);
			section3Block0 += (beginTimeHour + beginTimeMin + endTimeHour + endTimeMin + timeLimit);
		}
		section3Block0 += "00";

		// 第1块 优惠方案
		String section3Block1 = "";
		List<Discount> discountList = (List<Discount>) this.discountDAO.selectListByCompanyId(device.getCompanyId());
		for (Discount discount : discountList) {
			String rate = StringUtil.hexLeftPad(discount.getRate(), 2);
			section3Block1 += rate;
		}

		// 第2块 扣费速率
		String waterLimit = StringUtil.hexLeftPad(w.getWaterLimit(), 4);// 2--0-1
		String cycleLimit = StringUtil.hexLeftPad(w.getCycleLimit(), 4);// 2--2-3
		String waterPrecision = StringUtil.hexLeftPad(w.getWaterPrecision(), 4);// 2--4-5
		String enableAutoCalcRate = StringUtil.hexLeftPad(w.getEnableAutoCalcRate(), 2);// 1--6-6
		String section3Block2 = waterLimit + cycleLimit + waterPrecision + enableAutoCalcRate + "000000000000000000";

		// 第4扇区
		// 第0块
		String goWaterType = StringUtil.hexLeftPad(w.getGoWaterType(), 2);// 1--0-0
		String stopWaterType = StringUtil.hexLeftPad(w.getStopWaterType(), 2);// 1--1-1
		String rate5Fare = StringUtil.hexLeftPad(w.getRate5Fare(), 4);// 2--2-3
		String subsidyReset = StringUtil.hexLeftPad(w.getSubsidyReset(), 2);// 1--4-4
		String subsidyFirst = StringUtil.hexLeftPad(w.getSubsidyFirst(), 2);// 1--5-5
		String rate5Cycle = StringUtil.getWaterDeduceCycle(w, w.getRate5Cycle(), w.getRate5Water());// 2--6-7
		String pwd = StringUtil.hexLeftPad(w.getPwd(), 4);// 2--8-9
		String consumeType = StringUtil.hexLeftPad(w.getConsumeType(), 2);// 1--10-10
		String deviceNum = StringUtil.hexLeftPad(w.getDeviceNum(), 2);// 4--11-14
		String bound = StringUtil.hexLeftPad(w.getBound(), 2);// 1--15-15
		String section4Block0 = goWaterType + stopWaterType + rate5Fare + subsidyReset + subsidyFirst + rate5Cycle + pwd + consumeType + deviceNum + bound;

		// 第1块
		ConsumeParam p = (ConsumeParam) this.consumeParamDAO.selectByCompanyId(device.getCompanyId());
		String rate1Status = StringUtil.hexLeftPad(w.getRate1Status(), 2);// 1--0-0
		String rate1Fare = StringUtil.hexLeftPad(w.getRate1Fare(), 4);// 2--1-2
		String rate1Cycle = StringUtil.getWaterDeduceCycle(w, w.getRate1Cycle(), w.getRate1Water());// 2--3-4
		String dayLimitFare = StringUtil.hexLeftPad(p.getDayLimitFare(), 4);// 2--5-6
		String bit7 = "00";// 1--7-7
		String cardMinFare = StringUtil.hexLeftPad(p.getCardMinFare(), 2);// 2--9-9
		String rate1CardTypes = StringUtil.getWaterCardTypesHexStr(w.getRate1CardTypes());// 2--10-11
		String section4Block1 = rate1Status + rate1Fare + rate1Cycle + dayLimitFare + bit7 + cardMinFare + rate1CardTypes + "00000000";

		// 第2块
		String subsidyInvalidDate = "0000";// 2--0-1
		String timeLimitFare = StringUtil.hexLeftPad(p.getTimeLimitFare(), 4);// 2--2-3
		String checktime = "00000000";// 4--4-7
		String cardMinFareCardTypes = StringUtil.getPosCardTypesHexStr(p.getCardMinFareCardTypes());// 2--8-9
		String timeLimitFareCardTypes = StringUtil.getPosCardTypesHexStr(p.getTimeLimitFareCardTypes());// 2--10-11
		String dayLimitFareCardTypes = StringUtil.getPosCardTypesHexStr(p.getDayLimitFareCardTypes());// 2--12-13
		String enableFlag = StringUtil.binaryHexStr("" + w.getEnableMeal() + w.getEnableDiscount() + w.getEnableDayLimitFare() + w.getEnableTimeLimitFare() + w.getEnableCardMinFare());// 1--14-14
		String section4Block2 = subsidyInvalidDate + timeLimitFare + checktime + cardMinFareCardTypes + timeLimitFareCardTypes + dayLimitFareCardTypes + enableFlag + "00";

		section2Block0 = StringUtil.hexLeftPad(baseSection + 2, 2) + "0000" + section2Block0;
		section2Block1 = StringUtil.hexLeftPad(baseSection + 2, 2) + "0100" + section2Block1;
		section2Block2 = StringUtil.hexLeftPad(baseSection + 2, 2) + "0200" + section2Block2;

		section3Block0 = StringUtil.hexLeftPad(baseSection + 3, 2) + "0000" + section3Block0;
		section3Block1 = StringUtil.hexLeftPad(baseSection + 3, 2) + "0100" + section3Block1;
		section3Block2 = StringUtil.hexLeftPad(baseSection + 3, 2) + "0200" + section3Block2;

		section4Block0 = StringUtil.hexLeftPad(baseSection + 4, 2) + "0000" + section4Block0;
		section4Block1 = StringUtil.hexLeftPad(baseSection + 4, 2) + "0100" + section4Block1;
		section4Block2 = StringUtil.hexLeftPad(baseSection + 4, 2) + "0200" + section4Block2;

		String commandCodeStr = "0000" + StringUtil.hexLeftPad(CardReaderCommandCode.MakeFuncCard, 4);
		String sendStr = CardReaderFrame.WriteCard + commandCodeStr + CardReaderFrame.NoValidateCardSN + CardReaderFrame.NoCardSN + section2Block0 + section2Block1 + section2Block2 + section3Block0
				+ section3Block1 + section3Block2 + section4Block0 + section4Block1 + section4Block2 + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendStr.length() / 2, 4);
		sendStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + "0000" + DeviceType.CardReader + bufLen + sendStr;
		byte[] buf = StringUtil.strTobytes(sendStr);

		TerminalManager.sendToCardReader(socketChannel, buf);
	}
}
