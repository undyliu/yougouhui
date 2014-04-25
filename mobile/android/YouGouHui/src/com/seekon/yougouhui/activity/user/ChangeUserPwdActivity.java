package com.seekon.yougouhui.activity.user;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ChangePasswordActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.widget.ChangeTextInfoTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ChangeUserPwdActivity extends ChangePasswordActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		TextView nameView = (TextView) findViewById(R.id.name);
		nameView.setText(RunEnv.getInstance().getUser().getName());
	}

	protected void doSavePassword(final MenuItem item) {
		item.setEnabled(false);

		RestUtils.executeAsyncRestTask(this, new ChangeTextInfoTaskCallback(item) {

			@Override
			public void onSuccess(RestMethodResult<JSONObjResource> result) {
				Intent intent = new Intent();
				setResult(RESULT_OK, intent);
				finish();
			}

			@Override
			public RestMethodResult<JSONObjResource> doInBackground() {
				return UserProcessor.getInstance(ChangeUserPwdActivity.this)
						.updateUserPwd(pwdNewView.getText().toString());
			}
		});
	}

	@Override
	protected boolean validateOldPassword() {
		return RunEnv.getInstance().getUser().getPwd()
				.equals(pwdOldView.getText().toString());
	}

}
