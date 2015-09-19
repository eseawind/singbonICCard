package com.singbon.device;

import java.util.List;

import com.singbon.entity.ConsumeParam;
import com.singbon.entity.Cookbook;
import com.singbon.entity.Discount;
import com.singbon.entity.Meal;
import com.singbon.entity.OrderTime;

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
	private int cookbookIndex;
	private int cookbookTotal;
	private Cookbook cookbook;
	private ConsumeParam consumeParam;
	private List<Meal> mealList;
	private List<OrderTime> orderTimeList;
	private List<Discount> discountList;

	public ConsumeParam getConsumeParam() {
		return consumeParam;
	}

	public void setConsumeParam(ConsumeParam consumeParam) {
		this.consumeParam = consumeParam;
	}

	public List<Meal> getMealList() {
		return mealList;
	}

	public void setMealList(List<Meal> mealList) {
		this.mealList = mealList;
	}

	public List<OrderTime> getOrderTimeList() {
		return orderTimeList;
	}

	public void setOrderTimeList(List<OrderTime> orderTimeList) {
		this.orderTimeList = orderTimeList;
	}

	public List<Discount> getDiscountList() {
		return discountList;
	}

	public void setDiscountList(List<Discount> discountList) {
		this.discountList = discountList;
	}

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
