package com.seekon.yougouhui.func.discover.share;

import java.io.Serializable;
import java.util.List;

import com.seekon.yougouhui.func.user.UserEntity;

public class ShareEntity implements Serializable {

	private static final long serialVersionUID = -8373446115846393776L;

	private String uuid;

	private String content;

	private UserEntity publisher;

	private long publishTime;

	private List<String> images;

	private List<CommentEntity> comments;

	public ShareEntity() {
		super();
	}

	public ShareEntity(String uuid, String content) {
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

	public List<String> getImages() {
		return images;
	}

	public void setImages(List<String> images) {
		this.images = images;
	}

	public List<CommentEntity> getComments() {
		return comments;
	}

	public void setComments(List<CommentEntity> comments) {
		this.comments = comments;
	}

}
