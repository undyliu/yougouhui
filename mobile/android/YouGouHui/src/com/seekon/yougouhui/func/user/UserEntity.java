package com.seekon.yougouhui.func.user;

import java.io.Serializable;

/**
 * 用户对象
 * 
 * @author undyliu
 * 
 */
public class UserEntity implements Serializable {

	private static final long serialVersionUID = -4052088250779917423L;

	private String uuid;
	private String phone;
	private String name;
	private String pwd;
	private String photo;

	public UserEntity() {
		super();
	}

	public UserEntity(String uuid, String phone, String name, String pwd,
			String photo) {
		super();
		this.uuid = uuid;
		this.phone = phone;
		this.name = name;
		this.pwd = pwd;
		this.photo = photo;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
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
		UserEntity other = (UserEntity) obj;
		if (uuid == null) {
			if (other.uuid != null)
				return false;
		} else if (!uuid.equals(other.uuid))
			return false;
		return true;
	}

}
