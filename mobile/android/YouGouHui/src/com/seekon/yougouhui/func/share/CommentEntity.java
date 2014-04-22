package com.seekon.yougouhui.func.share;

import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.func.user.UserEntity;

public class CommentEntity extends Entity {

	private static final long serialVersionUID = -6389096177933115878L;

	private String content;

	private UserEntity publisher;

	private long publishTime;

	public CommentEntity() {
		super();
	}

	public CommentEntity(String uuid, String content) {
		super(uuid);
		this.content = content;
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
