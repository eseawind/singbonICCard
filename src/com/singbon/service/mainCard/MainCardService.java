package com.singbon.service.mainCard;

import java.io.IOException;
import java.nio.channels.SocketChannel;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.mainCard.MainCardDAO;
import com.singbon.device.CRC16;
import com.singbon.device.TerminalManager;
import com.singbon.entity.CardAllInfo;
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
	 */
	public void save(User user) {
		this.mainCardDAO.insert(user);
	}

	/**
	 * 修改人员
	 * 
	 * @param user
	 */
	public void update(User user) {
		this.mainCardDAO.update(user);
	}

	/**
	 * 删除未发卡人员
	 * 
	 * @param user
	 */
	public void delete(Integer deptId) {
		this.mainCardDAO.delete(deptId);
	}

	/**
	 * 根据主键查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectById(Integer id) {
		return this.mainCardDAO.selectById(id);
	}

	/**
	 * 人员列表
	 * 
	 * @return
	 */
	public List<User> selectByCondition(Integer deptId, String searchStr) {
		return this.mainCardDAO.selectByCondition(deptId, searchStr);
	}

	/**
	 * 信息发卡
	 * 
	 * @return
	 * @throws IOException
	 */
	public void infoCard(String sn, SocketChannel socketChannel, User user, CardAllInfo cardAllInfo) throws Exception {
		SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();

		String tmUserId = StringUtil.leftPad(user.getUserId(), 6);
		String tmCardNo = StringUtil.leftPad(Integer.valueOf(user.getCardNO()), 6);
		String tmConsumePwd = StringUtil.leftPad(Integer.valueOf(user.getConsumePwd()), 6);
		String tmIdentityPwd = StringUtil.leftPad(Integer.valueOf(user.getIdentityPwd()), 4);
		Date invalidDate = myFormatter.parse(user.getInvalidDate());
		c.setTime(invalidDate);
		String tmInvalidDate = StringUtil.dateToHexString(c);
		String tmCardMark = StringUtil.leftPad(240, 2);
		String tmCardBatch = StringUtil.leftPad(cardAllInfo.getCardBatch(), 2);
		String tmCheck1 = "00"; // 异或校验，以后补充

		String tmCardDeposit = StringUtil.leftPad(cardAllInfo.getCardDeposit(), 2);
		String tmLimitDayFare = StringUtil.leftPad(cardAllInfo.getLimitDayFare(), 2);
		String tmLimitTimesFare = StringUtil.leftPad(cardAllInfo.getLimitTimesFare(), 4);
		String tmCardSeq = StringUtil.leftPad(user.getCardSeq(), 2);
		String tmCardType = StringUtil.leftPad(user.getCardType(), 2);
		String tmDeptId = StringUtil.leftPad(user.getDeptId(), 8);
		String tmCardTotalFare = StringUtil.leftPad(user.getCardTotalFare(), 8);
		String tmStandby = "06"; // 备用字段
		String tmCheck2 = "00"; // 异或校验

		String baseData = tmUserId + tmCardNo + tmConsumePwd + tmIdentityPwd + tmInvalidDate + tmCardMark + tmCardBatch + tmCheck1 + tmCardDeposit + tmLimitDayFare + tmLimitTimesFare + tmCardSeq
				+ tmCardType + tmDeptId + tmCardTotalFare + tmStandby + tmCheck2;

		int len = 11 + 19 * 2;
		String bufLen = StringUtil.leftPad(len, 4);
		String sendStr = sn + "00000000" + len + "cd010044444444";
		String baseBlock0 = "010000" + baseData.substring(0, 32);
		String baseBlock1 = "010100" + baseData.substring(32);

		byte[] buf = StringUtil.strTobytes(sendStr + baseBlock0 + baseBlock1 + "0000");
		CRC16.generate(buf);

		TerminalManager.sendToCardReader(socketChannel, buf);
	}
}
