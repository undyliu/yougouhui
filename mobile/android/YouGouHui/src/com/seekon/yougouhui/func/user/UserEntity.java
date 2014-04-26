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

	private String phone;
	private String pwd;
	private String photo;
	private String registerTime;
	private String type  = UserConst.TYPE_USER_ANONYMOUS;//默认为匿名的账户
	
	private List<UserEntity> friends = new ArrayList<UserEntity>();

	public UserEntity() {
		super();
	}

	public UserEntity(String uuid, String phone, String name, String pwd,
			String photo, String registerTime) {
		super(uuid, name);
		this.phone = phone;
		this.pwd = pwd;
		this.photo = photo;
		this.registerTime = registerTime;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

}
