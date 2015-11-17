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
				sql = String.format("select cardNO from cardBlack where companyId=%s and cardNO>0 limit 20", device.getCompanyId());
			} else {
				sql = String.format("select cardNO from cardBlack where companyId=%s and id>(select id from cardBlack where companyId=%s and cardNO=%s) limit 20", device.getCompanyId(),
						device.getCompanyId(), lastBlackNum);
			}
			List<Map> list = JdbcUtil.baseDAO.selectBySql(sql);

			synchronized (TerminalManager.sendCommandObject) {
				ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
				String blackNums = "";
				for (Map map : list) {
					blackNums += StringUtil.hexLeftPad(StringUtil.objToInt(map.get("cardNO")), 4);
				}

				SendCommand sendCommand = new SendCommand();
				sendCommand.setFrame(PosFrame.Black);
				sendCommand.setSubFrame(PosSubFrameBlack.IncAppend);
				sendCommand.setCommandCode(0);
				sendCommand.setBlackNums(blackNums);
				sendCommandList.add(sendCommand);
			}
		}
	}
}
