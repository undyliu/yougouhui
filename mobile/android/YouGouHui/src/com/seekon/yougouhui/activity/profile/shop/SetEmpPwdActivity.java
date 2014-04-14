package com.seekon.yougouhui.activity.profile.shop;

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
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEmpProcessor;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public class SetEmpPwdActivity extends Activity {

	private String shopId;
	private UserEntity emp;

	protected EditText pwdNewView = null;
	protected EditText pwdNewConfView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_set_emp_pwd);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		emp = (UserEntity) this.getIntent().getSerializableExtra(
				UserConst.DATA_KEY_USER);
		shopId = this.getIntent().getStringExtra(ShopConst.COL_NAME_UUID);

		initViews();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.common_save, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_common_save:
			saveEmpPwd(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void initViews() {
		TextView nameView = (TextView) findViewById(R.id.user_name);
		nameView.setText(emp.getName());

		pwdNewView = (EditText) findViewById(R.id.password);
		pwdNewConfView = (EditText) findViewById(R.id.password_conf);
	}

	private void saveEmpPwd(final MenuItem item) {

		pwdNewView.setError(null);
		pwdNewConfView.setError(null);

		boolean cancel = false;
		View focusView = null;

		String fieldRequired = getString(R.string.error_field_required);

		final String password = pwdNewView.getText().toString();

		final String passwordConf = pwdNewConfView.getText().toString();
		if (TextUtils.isEmpty(passwordConf)) {
			pwdNewConfView.setError(fieldRequired);
			focusView = pwdNewConfView;
			cancel = true;
		} else if (passwordConf.length() < 4) {
			pwdNewConfView.setError(getString(R.string.error_invalid_password));
			focusView = pwdNewConfView;
			cancel = true;
		}
		if (!password.equals(passwordConf)) {
			pwdNewConfView.setError(getString(R.string.error_password_inconfirmed));
			focusView = pwdNewConfView;
			cancel = true;
		}

		if (TextUtils.isEmpty(password)) {
			pwdNewView.setError(fieldRequired);
			focusView = pwdNewView;
			cancel = true;
		} else if (password.length() < 4) {
			pwdNewView.setError(getString(R.string.error_invalid_password));
			focusView = pwdNewView;
			cancel = true;
		}

		if (cancel) {
			focusView.requestFocus();
			return;
		}

		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return ShopEmpProcessor.getInstance(SetEmpPwdActivity.this)
						.setShopEmpPwd(shopId, emp.getUuid(), password);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				if (result.getStatusCode() == 200) {
					emp.setPwd(password);
					Intent intent = new Intent();
					intent.putExtra(UserConst.DATA_KEY_USER, emp);
					setResult(RESULT_OK, intent);
					finish();
				} else {
					ViewUtils.showToast("设置密码失败.");
				}
			}

			@Override
			protected void onCancelled() {
				item.setEnabled(true);
				showProgress(false);
				super.onCancelled();
			}
		};

		item.setEnabled(false);
		showProgress(true);
		task.execute((Void) null);
	}

	protected void showProgress(final boolean show) {
		ViewUtils.showProgress(this, this.findViewById(R.id.set_password_view),
				show);
	}
}
