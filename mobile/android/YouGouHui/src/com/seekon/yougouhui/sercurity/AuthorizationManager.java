package com.seekon.yougouhui.sercurity;

import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.contact.GetFriendsTask;
import com.seekon.yougouhui.func.login.EnvHelper;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.login.LoginProcessor;
import com.seekon.yougouhui.func.spi.ILoginProcessor;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
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
			UserEntity user = this.getUserHelper().auth(phone, pwd);// 本地数据库认证
			if (user == null) {
				ILoginProcessor processor = LoginProcessor.getInstance(context);
				RestMethodResult<JSONObjResource> result = processor.login(phone, pwd);
				int status = result.getStatusCode();
				if (status != RestStatus.SC_OK) {
					return result.getStatusMsg();
				}
				JSONObjResource resource = result.getResource();
				if (resource.getBoolean(LoginConst.LOGIN_RESULT_AUTHED)) {
					user = UserUtils.createFromJSONObject(resource
							.getJSONObject(LoginConst.LOGIN_RESULT_USER));
				} else {
					errorType = resource.getString(LoginConst.LOGIN_RESULT_ERROR_TYPE);
				}
			}
			if (user != null) {
				List<UserEntity> friends = this.getUserHelper().getUserFriends(
						user.getUuid());
				if (friends == null || friends.isEmpty()) {
					new GetFriendsTask(context, user).execute((Void) null);
				} else {
					user.setFriends(friends);
				}

				errorType = LoginConst.AUTH_SUCCESS;
				RunEnv.getInstance().setUser(user);
				loginData.put(COL_NAME_PWD, user.getPwd());
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
		String phone = RunEnv.getInstance().getUser().getPhone();
		this.getEnvHelper().deleteLoginSetting(phone);
		RunEnv.getInstance().clean();
	}

	/**
	 * 请求添加认证信息token
	 */
	@Override
	public boolean authorize(Request request) {
		if (request.getMethod() == Method.GET && UserUtils.isAnonymousUser()) {
			return true;
		}

		String sessionId = RunEnv.getInstance().getSessionId();
		if (sessionId == null || sessionId.length() == 0) {
			// 尝试先登录
			UserEntity user = RunEnv.getInstance().getUser();
			LoginProcessor.getInstance(context).login(user.getPhone(), user.getPwd());
			sessionId = RunEnv.getInstance().getSessionId();
			if (sessionId == null || sessionId.length() == 0) {
				return false;
			}
		}
		List<String> cookies = new ArrayList<String>();
		cookies.add(sessionId);
		request.addHeader("cookie", cookies);
		return true;
	}

}
