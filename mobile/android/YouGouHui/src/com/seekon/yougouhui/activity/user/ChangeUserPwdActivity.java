package com.seekon.yougouhui.activity.user;

import android.content.Intent;
import android.view.MenuItem;

import com.seekon.yougouhui.activity.ChangePasswordActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.widget.AbstractChangeInfoTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ChangeUserPwdActivity extends ChangePasswordActivity {

	protected void doSavePassword(final MenuItem item) {

		AbstractChangeInfoTask task = new AbstractChangeInfoTask(item) {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return UserProcessor.getInstance(ChangeUserPwdActivity.this)
						.updateUserPwd(pwdNewView.getText().toString());
			}

			@Override
			protected void showProgressInner(boolean show) {
				showProgress(show);
			}

			@Override
			protected void doSuccess(RestMethodResult<JSONObjResource> result) {
				Intent intent = new Intent();
				setResult(RESULT_OK, intent);
				finish();
			}
		};
		showProgress(true);
		item.setEnabled(false);
		task.execute((Void) null);
	}

	@Override
	protected String getOldPassword() {
		return RunEnv.getInstance().getUser().getPwd();
	}

}
