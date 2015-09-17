package com.singbon.device;

import com.singbon.entity.Cookbook;

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
	private int sendTime;
	private Cookbook cookbook;
	private int cookbookIndex;
	private int cookbookTotal;

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

	public int getSendTime() {
		return sendTime;
	}

	public void setSendTime(int sendTime) {
		this.sendTime = sendTime;
	}

	public Cookbook getCookbook() {
		return cookbook;
	}

	public void setCookbook(Cookbook cookbook) {
		this.cookbook = cookbook;
	}

	public int getCookbookIndex() {
		return cookbookIndex;
	}

	public void setCookbookIndex(int cookbookIndex) {
		this.cookbookIndex = cookbookIndex;
	}

	public int getCookbookTotal() {
		return cookbookTotal;
	}

	public void setCookbookTotal(int cookbookTotal) {
		this.cookbookTotal = cookbookTotal;
	}

}
