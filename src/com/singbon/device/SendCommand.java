package com.singbon.device;

/**
 * 终端设备命令
 * 
 * @author 郝威
 * 
 */
public class SendCommand {

	private byte frame;
	private byte subFrame;
	private int commandCode;

	public byte getFrame() {
		return frame;
	}

	public void setFrame(byte frame) {
		this.frame = frame;
	}

	public byte getSubFrame() {
		return subFrame;
	}

	public void setSubFrame(byte subFrame) {
		this.subFrame = subFrame;
	}

	public int getCommandCode() {
		return commandCode;
	}

	public void setCommandCode(int commandCode) {
		this.commandCode = commandCode;
	}

}
