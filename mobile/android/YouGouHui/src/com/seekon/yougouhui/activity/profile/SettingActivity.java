package com.seekon.yougouhui.activity.profile;

import android.app.ActionBar;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Switch;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.LoginActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.EnvHelper;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.sercurity.AuthorizationManager;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 系统设置：设置登录配置信息
 * 
 * @author undyliu
 * 
 */
public class SettingActivity extends Activity {

	private Switch autoLoginView;
	private Switch rememberPwdView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.profile_setting);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		ContentValues loginSetting = RunEnv.getInstance().getLoginSetting();
		autoLoginView = (Switch) findViewById(R.id.auto_login);
		autoLoginView.setChecked(loginSetting
				.getAsBoolean(LoginConst.LOGIN_SETTING_AUTO_LOGIN));

		rememberPwdView = (Switch) findViewById(R.id.remember_pwd);
		rememberPwdView.setChecked(loginSetting
				.getAsBoolean(LoginConst.LOGIN_SETTING_REMEMBER_PWD));

		Button logoutButton = (Button) findViewById(R.id.logout);
		logoutButton.setOnClickListener(new Button.OnClickListener() {

			@Override
			public void onClick(View v) {
				String phone = RunEnv.getInstance().getUser().getPhone();
				AuthorizationManager.getInstance(SettingActivity.this).getEnvHelper()
						.deleteLoginSetting(phone);
				RunEnv.getInstance().setUser(null);
				Intent intent = new Intent(SettingActivity.this, LoginActivity.class);
				startActivity(intent);
				finish();//TODO:获取activity堆栈销毁活动的activity
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.profile_setting, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_setting:
			saveSetting();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void showProgress(boolean show) {
		ViewUtils.showProgress(this, this.findViewById(R.id.view_login_setting),
				show, R.string.default_progress_status_message);
	}

	private void saveSetting() {
		showProgress(true);

		AsyncTask<Void, Void, Boolean> task = new AsyncTask<Void, Void, Boolean>() {
			@Override
			protected Boolean doInBackground(Void... params) {
				ContentValues loginSetting = RunEnv.getInstance().getLoginSetting();
				loginSetting.put(LoginConst.LOGIN_SETTING_AUTO_LOGIN,
						autoLoginView.isChecked());
				loginSetting.put(LoginConst.LOGIN_SETTING_REMEMBER_PWD,
						rememberPwdView.isChecked());
				EnvHelper envHelper = AuthorizationManager.getInstance(
						SettingActivity.this).getEnvHelper();
				envHelper.updateLoginSetting(loginSetting);
				return true;
			}

			@Override
			protected void onPostExecute(Boolean result) {
				if (result) {
					ViewUtils.showToast("修改成功.");
				}
				showProgress(false);
			}

			@Override
			protected void onCancelled() {
				showProgress(false);
				super.onCancelled();
			}
		};

		task.execute((Void) null);
	}

}
