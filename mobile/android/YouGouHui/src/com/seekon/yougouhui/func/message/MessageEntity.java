package com.seekon.yougouhui.func.message;

import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.user.UserEntity;

public class MessageEntity extends Entity{

	private static final long serialVersionUID = 8397237088802730477L;
	
	private ShopEntity sendShop;
	
	private UserEntity sender;
	
	private String content;
	
	private UserEntity receiver;
	
	private long sendTime;

	public ShopEntity getSendShop() {
		return sendShop;
	}

	public void setSendShop(ShopEntity sendShop) {
		this.sendShop = sendShop;
	}

	public UserEntity getSender() {
		return sender;
	}

	public void setSender(UserEntity sender) {
		this.sender = sender;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public UserEntity getReceiver() {
		return receiver;
	}

	public void setReceiver(UserEntity receiver) {
		this.receiver = receiver;
	}

	public long getSendTime() {
		return sendTime;
	}

	public void setSendTime(long sendTime) {
		this.sendTime = sendTime;
	}
	
}
