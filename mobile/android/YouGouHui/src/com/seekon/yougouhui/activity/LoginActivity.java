package com.seekon.yougouhui.activity;

import static com.seekon.yougouhui.func.login.LoginConst.AUTH_ERROR_PASS;
import static com.seekon.yougouhui.func.login.LoginConst.AUTH_ERROR_USER;
import static com.seekon.yougouhui.func.login.LoginConst.LOGIN_SETTING_AUTO_LOGIN;
import static com.seekon.yougouhui.func.login.LoginConst.LOGIN_SETTING_KEY;
import static com.seekon.yougouhui.func.login.LoginConst.LOGIN_SETTING_REMEMBER_PWD;

import org.json.JSONObject;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.login.UserHelper;
import com.seekon.yougouhui.sercurity.AuthorizationManager;

public class LoginActivity extends Activity {

	/**
	 * Keep track of the login task to ensure we can cancel it if requested.
	 */
	private UserLoginTask mAuthTask = null;

	private String mPhone;
	private String mPassword;
	private boolean autoLogin = false;
	private boolean rememberPwd = false;

	// UI references.
	private EditText mPhoneView;
	private EditText mPasswordView;
	private Switch autoLoginView;
	private Switch rememberPwdView;
	private View mLoginFormView;
	private View mLoginStatusView;
	private TextView mLoginStatusMessageView;

	private AuthorizationManager mAuthManager;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.login);
		
		mAuthManager = AuthorizationManager.getInstance(this);
		
		JSONObject loginSetting = null;
		try {
			String loginSettingStr = getIntent().getStringExtra(
					LOGIN_SETTING_KEY);
			if (loginSettingStr != null && loginSettingStr.length() > 0) {
				loginSetting = new JSONObject(loginSettingStr);
			}

			if (loginSetting != null && loginSetting.getBoolean(LOGIN_SETTING_REMEMBER_PWD)) {
				mPhone = loginSetting.getString(UserHelper.COL_NAME_PHONE);
				mPassword = loginSetting.getString(UserHelper.COL_NAME_PWD);
				autoLogin = loginSetting.getBoolean(LOGIN_SETTING_AUTO_LOGIN);
				rememberPwd = loginSetting.getBoolean(LOGIN_SETTING_REMEMBER_PWD);
			}
		} catch (Exception e) {
			Log.d("get loginSetting from intent", e.getMessage());
		}

		mPhoneView = (EditText) findViewById(R.id.phone);
		mPhoneView.setText(mPhone);

		mPasswordView = (EditText) findViewById(R.id.password);
		mPasswordView.setText(mPassword);
		mPasswordView
				.setOnEditorActionListener(new TextView.OnEditorActionListener() {
					@Override
					public boolean onEditorAction(TextView textView, int id,
							KeyEvent keyEvent) {
						if (id == R.id.login || id == EditorInfo.IME_NULL) {
							attemptLogin();
							return true;
						}
						return false;
					}
				});

		autoLoginView = (Switch) findViewById(R.id.auto_login);
		autoLoginView.setChecked(autoLogin);
		autoLoginView
				.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {

					@Override
					public void onCheckedChanged(CompoundButton buttonView,
							boolean isChecked) {
						if (isChecked) {
							rememberPwdView.setChecked(isChecked);
						}
					}
				});

		rememberPwdView = (Switch) findViewById(R.id.remember_pwd);
		rememberPwdView.setChecked(rememberPwd);

		mLoginFormView = findViewById(R.id.login_form);
		mLoginStatusView = findViewById(R.id.login_status);
		mLoginStatusMessageView = (TextView) findViewById(R.id.login_status_message);

		findViewById(R.id.sign_in_button).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View view) {
						attemptLogin();
					}
				});
	}

	@Override
	protected void onResume() {
		super.onResume();
		
		if (getIntent().getData() != null) {
			//TODO 设置用户登录信息
		}
		
		if(mAuthManager.loggedIn()){
			startHomeActivity();
		}else{
			
		}
	}
	
	private void startHomeActivity() {
		showProgress(false);
		Intent startHomeActivity = new Intent(this, MainActivity.class);
		startActivity(startHomeActivity);
		finish();
	}
	
	/**
	 * Attempts to sign in or register the account specified by the login form. If
	 * there are form errors (invalid email, missing fields, etc.), the errors are
	 * presented and no actual login attempt is made.
	 */
	public void attemptLogin() {
		if (mAuthTask != null) {
			return;
		}

		// Reset errors.
		mPhoneView.setError(null);
		mPasswordView.setError(null);

		// Store values at the time of the login attempt.
		mPhone = mPhoneView.getText().toString();
		mPassword = mPasswordView.getText().toString();

		boolean cancel = false;
		View focusView = null;

		// Check for a valid password.
		if (TextUtils.isEmpty(mPassword)) {
			mPasswordView.setError(getString(R.string.error_field_required));
			focusView = mPasswordView;
			cancel = true;
		} else if (mPassword.length() < 4) {
			mPasswordView.setError(getString(R.string.error_invalid_password));
			focusView = mPasswordView;
			cancel = true;
		}

		// Check for a valid email address.
		if (TextUtils.isEmpty(mPhone)) {
			mPhoneView.setError(getString(R.string.error_field_required));
			focusView = mPhoneView;
			cancel = true;
		} 
		
		autoLogin = autoLoginView.isChecked();
		rememberPwd = rememberPwdView.isChecked();
		
		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user login attempt.
			mLoginStatusMessageView.setText(R.string.login_progress_signing_in);
			showProgress(true);
			mAuthTask = new UserLoginTask();
			mAuthTask.execute((Void) null);
		}
	}

	/**
	 * Shows the progress UI and hides the login form.
	 */
	@TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
	private void showProgress(final boolean show) {
		// On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
		// for very easy animations. If available, use these APIs to fade-in
		// the progress spinner.
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
			int shortAnimTime = getResources().getInteger(
					android.R.integer.config_shortAnimTime);

			mLoginStatusView.setVisibility(View.VISIBLE);
			mLoginStatusView.animate().setDuration(shortAnimTime).alpha(show ? 1 : 0)
					.setListener(new AnimatorListenerAdapter() {
						@Override
						public void onAnimationEnd(Animator animation) {
							mLoginStatusView.setVisibility(show ? View.VISIBLE : View.GONE);
						}
					});

			mLoginFormView.setVisibility(View.VISIBLE);
			mLoginFormView.animate().setDuration(shortAnimTime).alpha(show ? 0 : 1)
					.setListener(new AnimatorListenerAdapter() {
						@Override
						public void onAnimationEnd(Animator animation) {
							mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
						}
					});
		} else {
			// The ViewPropertyAnimator APIs are not available, so simply show
			// and hide the relevant UI components.
			mLoginStatusView.setVisibility(show ? View.VISIBLE : View.GONE);
			mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
		}
	}

	/**
	 * Represents an asynchronous login/registration task used to authenticate the
	 * user.
	 */
	public class UserLoginTask extends AsyncTask<Void, Void, String> {
		@Override
		protected String doInBackground(Void... params) {
			
			ContentValues loginData = new ContentValues();
			loginData.put(UserHelper.COL_NAME_PHONE, mPhone);
			loginData.put(UserHelper.COL_NAME_PWD, mPassword);
			loginData.put(LOGIN_SETTING_AUTO_LOGIN, autoLogin);
			loginData.put(LOGIN_SETTING_REMEMBER_PWD, rememberPwd);
			return mAuthManager.login(loginData);
		}

		@Override
		protected void onPostExecute(final String errorType) {
			mAuthTask = null;
			showProgress(false);
			boolean success = errorType == null;
			
			if (success) {
				startHomeActivity();
			} else {
				if(AUTH_ERROR_PASS.equals(errorType)){
					mPasswordView.setError(getString(R.string.error_incorrect_password));
					mPasswordView.requestFocus();
				}else if(AUTH_ERROR_USER.equals(errorType)){
					mPhoneView.setError(getString(R.string.error_incorrect_phone));
					mPhoneView.requestFocus();
				}else{
					mPasswordView.setError(getString(R.string.error_disconnect_server));
					mPasswordView.requestFocus();
				}
				
			}
		}

		@Override
		protected void onCancelled() {
			mAuthTask = null;
			showProgress(false);
		}
	}
}
