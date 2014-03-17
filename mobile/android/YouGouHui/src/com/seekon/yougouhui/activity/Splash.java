package com.seekon.yougouhui.activity;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.db.EnvHelper;
import com.seekon.yougouhui.db.UserHelper;
import com.seekon.yougouhui.sercurity.AuthorizationManager;

/**
 * 启动界面splash
 * 
 * @author undyliu
 * 
 */
public class Splash extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.splash);

		boolean autoLogin = false;

		EnvHelper envHelper = AuthorizationManager.getInstance(this).getEnvHelper();
		JSONObject loginSetting = envHelper.getLoginSetting();
		if (loginSetting != null) {
			try {
				autoLogin = loginSetting.getBoolean(Const.LOGIN_SETTING_AUTO_LOGIN);
			} catch (JSONException e) {
				autoLogin = false;
			}
		}

		if (autoLogin) {
			autoLogin = auth(loginSetting);
		}

		if (autoLogin) {
			Intent main = new Intent(this, MainActivity.class);
			startActivity(main);
		} else {
			Intent login = new Intent(this, LoginActivity.class);
			if (loginSetting != null) {
				login.putExtra(Const.LOGIN_SETTING_KEY, loginSetting.toString());
			}
			startActivity(login);
		}
		finish();
	}

	/**
	 * 根据登录设置信息来验证用户，用于自动登录
	 * 
	 * @param loginSetting
	 * @return
	 */
	private boolean auth(JSONObject loginSetting) {
		boolean authed = false;
		UserHelper userHelper = AuthorizationManager.getInstance(this)
				.getUserHelper();
		try {
			ContentValues user = userHelper.auth(
					loginSetting.getString(UserHelper.COL_NAME_PHONE),
					loginSetting.getString(UserHelper.COL_NAME_PWD));
			authed = user != null;
		} catch (JSONException e) {
			Log.d("auth", e.getMessage());
		}
		return authed;
	}
}
