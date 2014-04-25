package com.seekon.yougouhui.activity.shop;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEmpProcessor;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

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

		item.setEnabled(false);

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>("设置密码失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopEmpProcessor.getInstance(SetEmpPwdActivity.this)
								.setShopEmpPwd(shopId, emp.getUuid(), password);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						emp.setPwd(password);
						Intent intent = new Intent();
						intent.putExtra(UserConst.DATA_KEY_USER, emp);
						setResult(RESULT_OK, intent);
						finish();
					}

					@Override
					public void onFailed(String errorMessage) {
						onCancelled();
						super.onFailed(errorMessage);
					}

					@Override
					public void onCancelled() {
						item.setEnabled(true);
						super.onCancelled();
					}
				});
	}

}
