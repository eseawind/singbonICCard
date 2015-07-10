package com.singbon.service.mainCard;

import java.nio.channels.SocketChannel;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.mainCard.MainCardDAO;
import com.singbon.device.CRC16;
import com.singbon.device.CmdNumCardReader;
import com.singbon.device.TerminalManager;
import com.singbon.entity.CardAllInfo;
import com.singbon.entity.Device;
import com.singbon.entity.User;
import com.singbon.util.StringUtil;

/**
 * 制卡业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MainCardService {

	@Autowired
	public MainCardDAO mainCardDAO;

	/**
	 * 添加人员
	 * 
	 * @param user
	 * @throws Exception
	 */
	public Object save(User user) throws Exception {
		return this.mainCardDAO.insert(user);
	}

	/**
	 * 修改人员
	 * 
	 * @param user
	 */
	public void update(User user) throws Exception {
		this.mainCardDAO.update(user);
	}

	/**
	 * 删除未发卡人员
	 * 
	 * @param user
	 */
	public void delete(Integer deptId) throws Exception {
		this.mainCardDAO.delete(deptId);
	}

	/**
	 * 根据主键查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectById(Integer userId) {
		return this.mainCardDAO.selectById(userId);
	}

	/**
	 * 以物理卡号查询绑定数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByCardSN(Integer companyId, String cardSN) {
		return this.mainCardDAO.selectCountByCardSN(companyId, cardSN);
	}

	/**
	 * 以用户编号查询数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByUserNO(Integer companyId, String userNO) throws Exception {
		return this.mainCardDAO.selectCountByUserNO(companyId, userNO);
	}

	/**
	 * 以用户编号用户ID查询数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByUserNOUserId(Integer companyId, String userNO, Integer userId) throws Exception {
		return this.mainCardDAO.selectCountByUserNOUserId(companyId, userNO, userId);
	}

	/**
	 * 查询最大卡号+1
	 * 
	 * @param user
	 * @return
	 */
	public int selectMaxCardNO(Integer companyId) throws Exception {
		return this.mainCardDAO.selectMaxCardNO(companyId);
	}

	/**
	 * 人员列表
	 * 
	 * @return
	 */
	public List<User> selectByCondition(Integer deptId, String searchStr) throws Exception {
		return this.mainCardDAO.selectByCondition(deptId, searchStr);
	}

	/**
	 * 发卡
	 * 
	 * @param device
	 * @param socketChannel
	 * @param user
	 * @param cardAllInfo
	 * @throws Exception
	 */
	public void makeCard(Device device, SocketChannel socketChannel, User user, CardAllInfo cardAllInfo) throws Exception {
		int makeCardType = 1;
		if (user.getUserId() != null) {
			makeCardType = CmdNumCardReader.InfoCard;
		}
		if (user.getUserId() != null) {
			this.mainCardDAO.infoCard(user);
		} else {
			this.mainCardDAO.insert(user);
		}

		// SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();

		int allOpCash = (cardAllInfo.getOpCash() + cardAllInfo.getGiveCash()) * 100;
		String tmUserId = StringUtil.leftPad(user.getUserId(), 6);
		String tmCardNo = StringUtil.leftPad(Integer.valueOf(user.getCardNO()), 6);
		String tmConsumePwd = StringUtil.leftPad(Integer.valueOf(user.getConsumePwd()), 6);
		String tmIdentityPwd = StringUtil.leftPad(Integer.valueOf(user.getIdentityPwd()), 4);
		c.setTime(user.getInvalidDate());
		String tmInvalidDate = StringUtil.dateToHexString(c);
		String tmCardMark = StringUtil.leftPad(241, 2);
		String tmCardBatch = StringUtil.leftPad(cardAllInfo.getCardBatch(), 2);
		String tmCheck1 = "00"; // 异或校验，以后补充

		String tmCardDeposit = StringUtil.leftPad(cardAllInfo.getCardDeposit(), 2);
		String tmLimitDayFare = StringUtil.leftPad(cardAllInfo.getLimitDayFare(), 2);
		String tmLimitTimesFare = StringUtil.leftPad(cardAllInfo.getLimitTimesFare(), 4);
		// String tmCardSeq = StringUtil.leftPad(user.getCardSeq(), 2);
		String tmCardSeq = "01";
		String tmCardType = StringUtil.leftPad(user.getCardType(), 2);
		String tmDeptId = StringUtil.leftPad(user.getDeptId(), 8);
		String tmCardTotalFare = StringUtil.leftPad(allOpCash, 8);
		String tmStandby = "06"; // 备用字段
		String tmCheck2 = "00"; // 异或校验

		String baseData = tmUserId + tmCardNo + tmConsumePwd + tmIdentityPwd + tmInvalidDate + tmCardMark + tmCardBatch + tmCheck1 + tmCardDeposit + tmLimitDayFare + tmLimitTimesFare + tmCardSeq
				+ tmCardType + tmDeptId + tmCardTotalFare + tmStandby + tmCheck2;

		// 大钱包
		int cardOPCounter = 0;
		if (allOpCash > 0) {
			cardOPCounter = 1;
		}
		String tmCardOPCounter = StringUtil.leftPad(cardOPCounter, 4);
		String tmCardOddFare = "01" + StringUtil.leftPad(allOpCash, 6);
		String tmLastConsumeTime = "";
		// if (pCardConsumeInfo.LastConsumeTime.ToString().Length > 8)
		// { tmLastConsumeTime =
		// StringUtil.leftPadFromDate(pCardConsumeInfo.LastConsumeTime); }
		// else
		// {
		tmLastConsumeTime = "000000";
		// }
		String tmDaySumFare = StringUtil.leftPad(allOpCash, 6);
		String tmLimitPeriod1 = StringUtil.leftPad(cardAllInfo.getLimitPeriods()[0], 1);
		String tmLimitPeriod2 = StringUtil.leftPad(cardAllInfo.getLimitPeriods()[1], 1);
		String tmLimitPeriod3 = StringUtil.leftPad(cardAllInfo.getLimitPeriods()[2], 1);
		String tmLimitPeriod4 = StringUtil.leftPad(cardAllInfo.getLimitPeriods()[3], 1);
		String tmLimitPeriod5 = StringUtil.leftPad(cardAllInfo.getLimitPeriods()[4], 1);
		String tmLimitPeriod6 = StringUtil.leftPad(cardAllInfo.getLimitPeriods()[5], 1);
		String tmCheck = "00"; // 校验位，同或校验

		String consumeData = tmCardOPCounter + tmCardOddFare + tmLastConsumeTime + tmDaySumFare + tmLimitPeriod1 + tmLimitPeriod2 + tmLimitPeriod3 + tmLimitPeriod4 + tmLimitPeriod5 + tmLimitPeriod6
				+ tmCheck;
		consumeData = "020000" + consumeData;

		// 补助钱包
		String subsidyData = "030000" + "00000000000000000000000000000000";

		// 静态ID（16字节高字节在前）+设备机器号（4字节高字节在前）+数据长度（2字节高字节在前）+cd+01+是否校验卡号标志（1字节）+物理卡号（4字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+...+CRC校验（字节高字节在前）
		String baseBlock0 = "010000" + baseData.substring(0, 32);
		String baseBlock1 = "010100" + baseData.substring(0, 32);
		String baseBlock2 = "010200" + baseData.substring(32);

		String sendStr = baseBlock0 + baseBlock1 + baseBlock2 + consumeData + subsidyData + "0000";
		String bufLen = StringUtil.leftPad(11 + sendStr.length() / 2, 4);
		String cardMakeStr = StringUtil.leftPad(makeCardType, 4);
		sendStr = device.getSn() + StringUtil.leftPad(device.getDeviceNum(), 8) + bufLen + "cd01" + cardMakeStr + "0044444444" + sendStr;

		byte[] buf = StringUtil.strTobytes(sendStr);
		CRC16.generate(buf);
		System.out.print(StringUtil.leftPad(buf[buf.length - 2], 2) + " ");
		System.out.print(StringUtil.leftPad(buf[buf.length - 1], 2));
		System.out.println();
		TerminalManager.sendToCardReader(socketChannel, buf);
	}

	/**
	 * 更改状态
	 * 
	 * @param userId
	 * @param status
	 *            2挂失、1解挂
	 * @return
	 * @throws Exception
	 */
	public void changeStatus(Integer userId, Integer status) throws Exception {
		this.mainCardDAO.changeStatus(userId, status);
	}

	/**
	 * 解挂
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void unloss(Integer userId, SocketChannel socketChannel, Device device, String cardSN, String baseInfoStr) throws Exception {
		this.mainCardDAO.changeStatus(userId, 1);

		String cardMakeStr = StringUtil.leftPad(CmdNumCardReader.Unloss, 4);
		String sendBufStr = "cd01" + cardMakeStr + "01" + cardSN + baseInfoStr;
		String bufLen = StringUtil.leftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.leftPad(device.getDeviceNum(), 8) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		sendBuf[sendBuf.length-5]=(byte) 0xf1;
		CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}

	/**
	 * 变更卡
	 * 
	 * @param userId
	 * @param editType
	 *            0挂失，1解挂，2补卡，3换卡，4注销
	 * @param status
	 *            2挂失、1解挂
	 * @return
	 */
	public void changeCard(Integer userId, Integer editType, Integer status) {
	}
}
