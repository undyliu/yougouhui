package com.seekon.yougouhui.activity;

import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_ICON;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_NAME;

import java.util.HashMap;
import java.util.Map;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 帐号注册
 * 
 * @author undyliu
 * 
 */
public class RegisterActivity extends Activity {

	private EditText phoneView = null;
	private EditText nameView = null;
	private EditText pwdView = null;
	private EditText pwdConfView = null;
	private ImageView userIcon = null;
	private String userIconUri = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.register);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		phoneView = (EditText) findViewById(R.id.user_phone);
		nameView = (EditText) findViewById(R.id.user_name);
		pwdView = (EditText) findViewById(R.id.password);
		pwdConfView = (EditText) findViewById(R.id.password_conf);

		userIcon = (ImageView) findViewById(R.id.user_icon);
		userIcon.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {

			}
		});

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		this.getMenuInflater().inflate(R.menu.register, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_register_user:
			registerUser();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void registerUser() {
		phoneView.setError(null);
		nameView.setError(null);
		pwdView.setError(null);
		pwdConfView.setError(null);

		boolean cancel = false;
		View focusView = null;

		String fieldRequired = getString(R.string.error_field_required);

		final String password = pwdView.getText().toString();

		final String passwordConf = pwdConfView.getText().toString();
		if (TextUtils.isEmpty(passwordConf)) {
			pwdConfView.setError(fieldRequired);
			focusView = pwdConfView;
			cancel = true;
		} else if (passwordConf.length() < 4) {
			pwdConfView.setError(getString(R.string.error_invalid_password));
			focusView = pwdConfView;
			cancel = true;
		}
		if (!password.equals(passwordConf)) {
			pwdConfView.setError(getString(R.string.error_password_inconfirmed));
			focusView = pwdConfView;
			cancel = true;
		}

		if (TextUtils.isEmpty(password)) {
			pwdView.setError(fieldRequired);
			focusView = pwdView;
			cancel = true;
		} else if (password.length() < 4) {
			pwdView.setError(getString(R.string.error_invalid_password));
			focusView = pwdView;
			cancel = true;
		}

		final String name = nameView.getText().toString();
		if (TextUtils.isEmpty(name)) {
			nameView.setError(fieldRequired);
			focusView = nameView;
			cancel = true;
		}

		final String phone = phoneView.getText().toString();
		if (TextUtils.isEmpty(phone)) {
			phoneView.setError(fieldRequired);
			focusView = phoneView;
			cancel = true;
		}

		if (cancel) {
			focusView.requestFocus();
			return;
		}

		final Map<String, String> user = new HashMap<String, String>();
		user.put(COL_NAME_PHONE, phone);
		user.put(COL_NAME_USER_NAME, name);
		user.put(COL_NAME_PWD, password);
		user.put(COL_NAME_USER_ICON, userIconUri);

		AsyncTask<Map<String, String>, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Map<String, String>, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(
					Map<String, String>... params) {
				return new UserProcessor(RegisterActivity.this).registerUser(params[0]);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				int status = result.getStatusCode();
				if (status == 200) {
					Intent intent = new Intent();
					intent.putExtra(UserConst.KEY_REGISTER_USER,
							ContentValuesUtils.fromMap(user, null));
					setResult(RESULT_OK, intent);
					finish();
				} else {
					ViewUtils.showToast("注册失败.");
				}
				super.onPostExecute(result);
			}

			@Override
			protected void onCancelled() {
				showProgress(false);
				super.onCancelled();
			}
		};

		showProgress(true);
		task.execute(user);
	}

	private void showProgress(final boolean show) {
		ViewUtils
				.showProgress(this, null, show, R.string.login_progress_signing_in);
	}
}