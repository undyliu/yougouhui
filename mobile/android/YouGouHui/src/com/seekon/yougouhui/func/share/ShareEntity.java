package com.seekon.yougouhui.func.share;

import java.util.List;

import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.user.UserEntity;

public class ShareEntity extends Entity {

	private static final long serialVersionUID = -8373446115846393776L;

	private String content;

	private UserEntity publisher;

	private long publishTime;

	private ShopEntity shop;

	private List<FileEntity> images;

	private List<CommentEntity> comments;

	private ShopReplyEntity shopReply;

	public ShareEntity() {
		super();
	}

	public ShareEntity(String uuid, String content) {
		super(uuid);
		this.content = content;
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

	public ShopEntity getShop() {
		return shop;
	}

	public void setShop(ShopEntity shop) {
		this.shop = shop;
	}

	public List<FileEntity> getImages() {
		return images;
	}

	public void setImages(List<FileEntity> images) {
		this.images = images;
	}

	public List<CommentEntity> getComments() {
		return comments;
	}

	public void setComments(List<CommentEntity> comments) {
		this.comments = comments;
	}

	public ShopReplyEntity getShopReply() {
		return shopReply;
	}

	public void setShopReply(ShopReplyEntity shopReply) {
		this.shopReply = shopReply;
	}

	public String getShopId() {
		return shop != null ? shop.getUuid() : null;
	}
	
	public String getShopName(){
		return shop != null ? shop.getName() : null;
	}
}
