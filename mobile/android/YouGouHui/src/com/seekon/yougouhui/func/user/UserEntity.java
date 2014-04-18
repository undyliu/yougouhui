package com.seekon.yougouhui.func.user;

import java.util.ArrayList;
import java.util.List;

import com.seekon.yougouhui.func.PinyinEntity;

/**
 * 用户对象
 * 
 * @author undyliu
 * 
 */
public class UserEntity extends PinyinEntity implements Cloneable {

	private static final long serialVersionUID = -4052088250779917423L;

	private String uuid;
	private String phone;
	private String pwd;
	private String photo;
	private String registerTime;

	private List<UserEntity> friends = new ArrayList<UserEntity>();

	public UserEntity() {
		super();
	}

	public UserEntity(String uuid, String phone, String name, String pwd,
			String photo, String registerTime) {
		super(name);
		this.uuid = uuid;
		this.phone = phone;
		this.pwd = pwd;
		this.photo = photo;
		this.registerTime = registerTime;
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

	public String getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
	}

	public List<UserEntity> getFriends() {
		return friends;
	}

	public void setFriends(List<UserEntity> friends) {
		this.friends = friends;
	}

	public void addFriend(UserEntity friend) {
		if (!this.friends.contains(friend)) {
			this.friends.add(friend);
		}
	}

	public void removeFriend(UserEntity friend) {
		this.friends.remove(friend);
	}

	@Override
	public UserEntity clone() {
		try {
			return (UserEntity) super.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return null;
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
