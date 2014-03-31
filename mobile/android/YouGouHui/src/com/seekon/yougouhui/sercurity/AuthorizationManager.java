package com.seekon.yougouhui.sercurity;

import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;
import android.content.ContentValues;
import android.content.Context;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.EnvHelper;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.login.LoginProcessor;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.Logger;

public class AuthorizationManager implements RequestSigner {

	private static AuthorizationManager mInstance = null;

	private Context context = null;

	private UserData userHelper = null;

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

	public UserData getUserHelper() {
		if (userHelper == null) {
			userHelper = new UserData(context);
		}
		return userHelper;
	}

	public EnvHelper getEnvHelper() {
		if (envHelper == null) {
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
			String phone = loginData.getAsString(COL_NAME_PHONE);
			String pwd = loginData.getAsString(COL_NAME_PWD);
			ContentValues user = this.getUserHelper().auth(phone, pwd);// 本地数据库认证
			if (user == null && RunEnv.getInstance().isConnectedToInternet()) {
				LoginProcessor processor = new LoginProcessor(context);
				RestMethodResult<JSONObjResource> result = processor.login(phone, pwd);
				JSONObjResource resource = result.getResource();
				if (resource.getBoolean(LoginConst.LOGIN_RESULT_AUTHED)) {
					user = ContentValuesUtils.fromJSONObject(
							resource.getJSONObject(LoginConst.LOGIN_RESULT_USER), null);
				} else {
					errorType = resource.getString(LoginConst.LOGIN_RESULT_ERROR_TYPE);
				}
			}
			if (user != null) {
				errorType = LoginConst.AUTH_SUCCESS;
				RunEnv.getInstance().setUser(user);
			}
		} catch (Throwable e) {
			Logger.error("login", e.getMessage());
		}

		if (errorType == null) {
			errorType = LoginConst.AUTH_ERROR_UNKOWN;
		}

		if (errorType.equals(LoginConst.AUTH_SUCCESS)) {
			this.getEnvHelper().updateLoginSetting(loginData);// 认证成功记录登录设置信息
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
