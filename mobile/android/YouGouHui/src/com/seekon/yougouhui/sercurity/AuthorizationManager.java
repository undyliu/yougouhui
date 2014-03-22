package com.seekon.yougouhui.sercurity;

import android.content.ContentValues;
import android.content.Context;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.EnvHelper;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.login.LoginMethod;
import com.seekon.yougouhui.func.login.UserHelper;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.RestMethod;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;

public class AuthorizationManager implements RequestSigner {

	private static AuthorizationManager mInstance = null;

	private Context context = null;

	private UserHelper userHelper = null;
	
	private EnvHelper envHelper = null;
	
	public static AuthorizationManager getInstance(Context context) {
		if (mInstance == null) {
			mInstance = new AuthorizationManager(context);
		}
		return mInstance;
	}

	private AuthorizationManager(Context context) {
		this.context = context;
	}

	public UserHelper getUserHelper() {
		if (userHelper == null) {
			userHelper = new UserHelper(context);
		}
		return userHelper;
	}

	
	public EnvHelper getEnvHelper() {
		if(envHelper == null){
			envHelper = new EnvHelper(context);
		}
		return envHelper;
	}

	/**
	 * 检查是否已经登录
	 * 
	 * @return
	 */
	public boolean loggedIn() {
		return false;
	}

	/**
	 * 进行登录认证
	 * 
	 * @param loginData
	 */
	public String login(ContentValues loginData) {
		String errorType = null;
		try {
			String phone = loginData.getAsString(UserHelper.COL_NAME_PHONE);
			String pwd = loginData.getAsString(UserHelper.COL_NAME_PWD);
			ContentValues user = this.getUserHelper().auth(phone, pwd);// 本地数据库认证
			if (user == null && RunEnv.getInstance().isConnectedToInternet()) {
				RestMethod<JSONObjResource> loginmMethod = new LoginMethod(context, phone,
						pwd);
				RestMethodResult<JSONObjResource> result = loginmMethod.execute();
				Logger.debug("login", result.getResource().toString());
				if(result.getResource().getBoolean("authed")){
					user = new ContentValues();
					user.put(UserHelper.COL_NAME_PHONE, phone);
					user.put(UserHelper.COL_NAME_PWD, pwd);
					this.getUserHelper().updateUser(user);//登录成功，更新用户信息
					
				}else{
					errorType = result.getResource().getString("error-type");
				}
			}
			if(user != null){
				errorType = LoginConst.AUTH_SUCCESS;
				RunEnv.getInstance().setUser(user);
			}
		} catch (Throwable e) {
			Logger.error("login", e.getMessage());
		}
		
		if(errorType == null){
			errorType = LoginConst.AUTH_ERROR_UNKOWN;
		}
		
		if(errorType.equals(LoginConst.AUTH_SUCCESS)){
			this.getEnvHelper().updateLoginSetting(loginData);//认证成功记录登录设置信息
			RunEnv.getInstance().setLoginSetting(loginData);
		}
		
		return errorType;
	}

	public void logout() {

	}

	/**
	 * 请求添加认证信息token
	 */
	@Override
	public void authorize(Request request) {

	}

}
