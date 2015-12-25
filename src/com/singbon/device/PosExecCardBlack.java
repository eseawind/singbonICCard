package com.singbon.device;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.singbon.entity.Device;
import com.singbon.util.JdbcUtil;
import com.singbon.util.StringUtil;

/**
 * 处理自动下载黑名单
 * 
 * @author 郝威
 * 
 */
public class PosExecCardBlack implements Runnable {

	private Long lastBlackNum;
	private Device device;

	public PosExecCardBlack(Long lastBlackNum, Device device) {
		this.lastBlackNum = lastBlackNum;
		this.device = device;
	}

	@SuppressWarnings("rawtypes")
	public void run() {
		String sn = device.getSn();
		boolean blackAdded = false;
		synchronized (TerminalManager.sendCommandObject) {
			ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
			if (sendCommandList == null) {
				sendCommandList = new ArrayList<SendCommand>();
				TerminalManager.SNToSendCommandList.put(sn, sendCommandList);
			}
			for (SendCommand sc : sendCommandList) {
				if (sc.getFrame() == PosFrame.Black && sc.getSubFrame() == PosSubFrameBlack.IncAppend) {
					blackAdded = true;
					break;
				}
			}
		}
		if (!blackAdded) {
			String sql = null;
			if (lastBlackNum == 0) {
				sql = String.format("select cardNO,blackType from cardBlack where companyId=%s and cardNO>0 limit 8", device.getCompanyId());
			} else {
				sql = String.format("select cardNO,blackType from cardBlack where companyId=%s and id>(select id from cardBlack where companyId=%s and cardNO=%s) limit 8", device.getCompanyId(),
						device.getCompanyId(), lastBlackNum);
			}
			List<Map> list = JdbcUtil.baseDAO.selectBySql(sql);

			if (list == null || list.size() == 0)
				return;
			synchronized (TerminalManager.sendCommandObject) {
				ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
				String blackNums = "";
				String blackCardNums = "";
				String blackCardSNNums = "";
				for (Map map : list) {
					blackNums += StringUtil.hexLeftPad(StringUtil.objToLong(map.get("cardNO")), 8);
					int blackType = StringUtil.objToInt(map.get("blackType"));
					if (blackType == 0) {
						blackCardNums += StringUtil.objToLong(map.get("cardNO")) + ",";
					} else {
						blackCardSNNums += StringUtil.hexLeftPad(StringUtil.objToLong(map.get("cardNO")), 8) + ",";
					}
				}
				if (!"".equals(blackCardNums)) {
					blackCardNums = "卡号：" + blackCardNums;
				}
				if (!"".equals(blackCardSNNums)) {
					blackCardSNNums = "物理卡号：" + blackCardSNNums.substring(0, blackCardSNNums.length() - 1);
				}
				if (!"".equals(blackCardNums) && "".equals(blackCardSNNums)) {
					blackCardNums = blackCardNums.substring(0, blackCardNums.length() - 1);
				}
				String allBlackNums = blackCardNums + blackCardSNNums;
				SendCommand sendCommand = new SendCommand();
				sendCommand.setFrame(PosFrame.Black);
				sendCommand.setSubFrame(PosSubFrameBlack.IncAppend);
				sendCommand.setCommandCode(0);
				sendCommand.setBlackNums(blackNums);
				sendCommand.setBlackNumsDes(allBlackNums);
				sendCommandList.add(sendCommand);
			}
		}
	}
}
