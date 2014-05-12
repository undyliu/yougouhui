package com.seekon.yougouhui.func.message;

import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.func.user.UserEntity;

public class MessageEntity extends Entity{

	private static final long serialVersionUID = 8397237088802730477L;
	
	private UserEntity sender;
	
	private String content;
	
	private String receiver;
	
	private long sendTime;

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

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public long getSendTime() {
		return sendTime;
	}

	public void setSendTime(long sendTime) {
		this.sendTime = sendTime;
	}
	
}
