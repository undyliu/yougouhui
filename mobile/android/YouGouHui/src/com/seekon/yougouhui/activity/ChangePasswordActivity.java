package com.seekon.yougouhui.activity;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.util.ViewUtils;

public abstract class ChangePasswordActivity extends Activity {

	protected EditText pwdOldView = null;
	protected EditText pwdNewView = null;
	protected EditText pwdNewConfView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.change_password);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		pwdOldView = (EditText) findViewById(R.id.password_old);
		pwdNewView = (EditText) findViewById(R.id.password);
		pwdNewConfView = (EditText) findViewById(R.id.password_conf);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		this.getMenuInflater().inflate(R.menu.common_save, menu);
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
			savePassword(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	protected void savePassword(final MenuItem item) {
		pwdOldView.setError(null);
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

		String oldPwd = pwdOldView.getText().toString();
		if (TextUtils.isEmpty(password)) {
			pwdOldView.setError(fieldRequired);
			focusView = pwdOldView;
			cancel = true;
		} else if (!oldPwd.equals(getOldPassword())) {
			pwdOldView.setError(getString(R.string.error_incorrect_password));
			focusView = pwdOldView;
			cancel = true;
		}

		if (cancel) {
			focusView.requestFocus();
			return;
		}

		if (password.equals(oldPwd)) {
			ViewUtils.showToast("密码未做修改，不需要保存更新.");
			return;
		}

		doSavePassword(item);
	}

	protected void showProgress(final boolean show) {
		ViewUtils.showProgress(this, this.findViewById(R.id.change_password_view),
				show);
	}

	protected abstract String getOldPassword();

	protected abstract void doSavePassword(final MenuItem item);
}
