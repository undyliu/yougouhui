package com.seekon.yougouhui.activity;

import static com.seekon.yougouhui.func.login.LoginConst.LOGIN_SETTING_AUTO_LOGIN;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.EnvHelper;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.sercurity.AuthorizationManager;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.Logger;

/**
 * 启动界面splash
 * 
 * @author undyliu
 * 
 */
public class Splash extends Activity {

	private static final String TAG = Splash.class.getSimpleName();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.splash);

		boolean autoLogin = false;

		EnvHelper envHelper = AuthorizationManager.getInstance(this).getEnvHelper();
		JSONObject loginSetting = envHelper.getLoginSetting();
		if (loginSetting != null) {
			try {
				autoLogin = loginSetting.getBoolean(LOGIN_SETTING_AUTO_LOGIN);
				// sso = !loginSetting.getBoolean(LOGIN_SETTING_REMEMBER_PWD);//
				// 不记住密码则进行sso的集成登录
			} catch (JSONException e) {
				autoLogin = false;
			}
		}

		boolean authed = false;
		if (autoLogin || RunEnv.getInstance().getUser() != null) {
			authed = auth(loginSetting);
		}

		if (!authed) {// 使用匿名用户访问
			RunEnv.getInstance().setUser(UserUtils.getAnonymousUser());
		}

		Intent main = new Intent(this, MainActivity.class);
		startActivity(main);

		// if (authed) {
		// Intent main = new Intent(this, MainActivity.class);
		// startActivity(main);
		// } else {
		// Intent login = new Intent(this, LoginActivity.class);
		// if (loginSetting != null) {
		// login.putExtra(LOGIN_SETTING_KEY, loginSetting.toString());
		// }
		// startActivity(login);
		// }
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
		try {
			String errorType = AuthorizationManager.getInstance(this).login(
					ContentValuesUtils.fromJSONObject(loginSetting, null));
			authed = LoginConst.AUTH_SUCCESS.equals(errorType);
		} catch (JSONException e) {
			Logger.debug(TAG, e.getMessage(), e);
			authed = false;
		}
		return authed;
	}
}
