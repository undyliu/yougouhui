package com.seekon.yougouhui.func.profile.favorit;

import java.io.Serializable;

import com.seekon.yougouhui.func.PinyinEntity;

public class FavoritEntity extends PinyinEntity implements Serializable {

	private static final long serialVersionUID = 8604255047717835125L;

	private String uuid;
	private String userId;
	private String code;
	private String image;

	public FavoritEntity(String uuid, String userId, String code, String name,
			String image) {
		super(name);
		this.uuid = uuid;
		this.userId = userId;
		this.code = code;
		this.image = image;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((uuid == null) ? 0 : uuid.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		FavoritEntity other = (FavoritEntity) obj;
		if (uuid == null) {
			if (other.uuid != null)
				return false;
		} else if (!uuid.equals(other.uuid))
			return false;
		return true;
	}

}
