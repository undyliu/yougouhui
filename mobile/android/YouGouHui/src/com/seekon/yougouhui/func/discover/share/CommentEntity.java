package com.seekon.yougouhui.func.discover.share;

import java.io.Serializable;

import com.seekon.yougouhui.func.user.UserEntity;

public class CommentEntity implements Serializable {

	private static final long serialVersionUID = -6389096177933115878L;

	private String uuid;

	private String content;

	private UserEntity publisher;

	private long publishTime;

	public CommentEntity() {
		super();
	}

	public CommentEntity(String uuid, String content) {
		super();
		this.uuid = uuid;
		this.content = content;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public long getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(long publishTime) {
		this.publishTime = publishTime;
	}

	public UserEntity getPublisher() {
		return publisher;
	}

	public void setPublisher(UserEntity publisher) {
		this.publisher = publisher;
	}

}
