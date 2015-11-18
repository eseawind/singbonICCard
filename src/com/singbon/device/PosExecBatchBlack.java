package com.singbon.device;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.singbon.entity.Device;
import com.singbon.util.JdbcUtil;
import com.singbon.util.StringUtil;

/**
 * 处理自动下载批次和黑名单
 * 
 * @author 郝威
 * 
 */
public class PosExecBatchBlack implements Runnable {

	private Integer lastBatchId;
	private Device device;

	public PosExecBatchBlack(Integer lastBatchId, Device device) {
		this.lastBatchId = lastBatchId;
		this.device = device;
	}

	@SuppressWarnings("rawtypes")
	public void run() {
		String sn = device.getSn();
		boolean batchAdded = false;
		synchronized (TerminalManager.sendCommandObject) {
			ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
			if (sendCommandList == null) {
				sendCommandList = new ArrayList<SendCommand>();
				TerminalManager.SNToSendCommandList.put(sn, sendCommandList);
			}
			for (SendCommand sc : sendCommandList) {
				if (sc.getFrame() == PosFrame.Black && sc.getSubFrame() == PosSubFrameBlack.BatchAppend) {
					batchAdded = true;
					break;
				}
			}
		}
		if (!batchAdded) {
			String sql = null;
			if (lastBatchId == 0) {
				sql = String.format("select b1.batchId,b2.batchName from batchBlack b1,batch b2 where b1.batchId=b2.id and b1.companyId=%s and b1.batchId>0 limit 20", device.getCompanyId());
			} else {
				sql = String.format(
						"select b1.batchId,b2.batchName from batchBlack b1,batch b2 where b1.batchId=b2.id and b1.companyId=%s and b1.id>(select id from batchBlack where companyId=%s and batchId=%s) limit 20",
						device.getCompanyId(), device.getCompanyId(), lastBatchId);
			}
			List<Map> list = JdbcUtil.baseDAO.selectBySql(sql);
			if (list == null || list.size() == 0)
				return;
			synchronized (TerminalManager.sendCommandObject) {
				ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
				String batchIds = "";
				String batchNames = "";
				for (Map map : list) {
					batchIds += StringUtil.hexLeftPad(StringUtil.objToInt(map.get("batchId")), 4);
					batchNames += map.get("batchName") + ",";
				}
				batchNames = batchNames.substring(0, batchNames.length() - 1);

				SendCommand sendCommand = new SendCommand();
				sendCommand.setFrame(PosFrame.Black);
				sendCommand.setSubFrame(PosSubFrameBlack.BatchAppend);
				sendCommand.setCommandCode(0);
				sendCommand.setBatchIds(batchIds);
				sendCommand.setBatchNames(batchNames);
				sendCommandList.add(sendCommand);
			}
		}
	}
}
