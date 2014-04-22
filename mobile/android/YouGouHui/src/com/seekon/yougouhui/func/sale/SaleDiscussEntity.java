package com.seekon.yougouhui.func.sale;

import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.func.user.UserEntity;

public class SaleDiscussEntity extends Entity {

	private static final long serialVersionUID = -8346656610562794526L;

	private SaleEntity sale;
	private String content;
	private UserEntity publisher;
	private long publishTime;

	public SaleEntity getSale() {
		return sale;
	}

	public void setSale(SaleEntity sale) {
		this.sale = sale;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public UserEntity getPublisher() {
		return publisher;
	}

	public void setPublisher(UserEntity publisher) {
		this.publisher = publisher;
	}

	public long getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(long publishTime) {
		this.publishTime = publishTime;
	}

}
