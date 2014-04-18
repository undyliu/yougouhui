package com.seekon.yougouhui.func.sale;

import java.io.Serializable;

import com.seekon.yougouhui.func.user.UserEntity;

public class SaleDiscussEntity implements Serializable {

	private static final long serialVersionUID = -8346656610562794526L;

	private String uuid;
	private SaleEntity sale;
	private String content;
	private UserEntity publisher;
	private long publishTime;

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

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
