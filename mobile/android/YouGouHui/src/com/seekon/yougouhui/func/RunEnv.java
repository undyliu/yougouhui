package com.seekon.yougouhui.func;

import android.content.ContentValues;


public class RunEnv {
	
	private static RunEnv instance = null;
		
	private static Object lock = new Object();
	
	private boolean isConnectedToInternet = false;
	
	private ContentValues user = null;
	
	private RunEnv(){
	}
	
	public static RunEnv getInstance(){
		synchronized (lock) {
			if(instance == null){
				instance = new RunEnv();
			}
		}
		return instance;
	}
	
	public void setConnectedToInternet(boolean isConnectedToInternet) {
		this.isConnectedToInternet = isConnectedToInternet;
	}

	public boolean isConnectedToInternet(){
		return this.isConnectedToInternet;
	}

	public ContentValues getUser() {
		return user;
	}

	public void setUser(ContentValues user) {
		this.user = user;
	}
	
}
