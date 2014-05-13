package com.seekon.yougouhui.func;

import android.content.ContentValues;

import com.seekon.yougouhui.func.user.UserEntity;

public class RunEnv {

	private static RunEnv instance = null;

	private static Object lock = new Object();

	private UserEntity user = null;

	private ContentValues loginSetting = null;

	private String sessionId = null;// 键值对格式:key=value

	private LocationEntity locationEntity;
	
	private boolean shopLogined = false;
	
	private RunEnv() {
	}

	public static RunEnv getInstance() {
		synchronized (lock) {
			if (instance == null) {
				instance = new RunEnv();
			}
		}
		return instance;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public ContentValues getLoginSetting() {
		return loginSetting;
	}

	public void setLoginSetting(ContentValues loginSetting) {
		this.loginSetting = loginSetting;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public LocationEntity getLocationEntity() {
		return locationEntity;
	}

	public void setLocationEntity(LocationEntity locationEntity) {
		this.locationEntity = locationEntity;
	}

	public boolean isShopLogined() {
		return shopLogined;
	}

	public void setShopLogined(boolean shopLogined) {
		this.shopLogined = shopLogined;
	}

	public void clean() {
		this.user = null;
		this.sessionId = null;
		this.locationEntity = null;
		this.loginSetting = null;
		this.shopLogined = false;
		instance = null;
	}
}
