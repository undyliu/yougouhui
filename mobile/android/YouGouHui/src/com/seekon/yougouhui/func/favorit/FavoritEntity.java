package com.seekon.yougouhui.func.favorit;

import java.io.Serializable;

import com.seekon.yougouhui.func.PinyinEntity;

public class FavoritEntity extends PinyinEntity {

	private static final long serialVersionUID = 8604255047717835125L;

	private String userId;
	private String code;
	private String image;

	public FavoritEntity(String uuid, String userId, String code, String name,
			String image) {
		super(uuid, name);
		this.userId = userId;
		this.code = code;
		this.image = image;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

}
