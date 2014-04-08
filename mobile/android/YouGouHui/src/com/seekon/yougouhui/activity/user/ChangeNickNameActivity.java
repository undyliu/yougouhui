package com.seekon.yougouhui.activity.user;

import android.content.Intent;
import android.view.MenuItem;

import com.seekon.yougouhui.activity.ChangeTextInfoActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.widget.AbstractChangeInfoTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 修改用户昵称
 * 
 * @author undyliu
 * 
 */
public class ChangeNickNameActivity extends ChangeTextInfoActivity {

	@Override
	protected void doSaveTextInfo(final MenuItem item) {
		final String nickName = textView.getText().toString();
		if (nickName.equals(RunEnv.getInstance().getUser().getName())) {
			ViewUtils.showToast("昵称未做修改，不需要保存更新.");
			return;
		}

		AbstractChangeInfoTask task = new AbstractChangeInfoTask(item) {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return UserProcessor.getInstance(ChangeNickNameActivity.this)
						.updateUserName(nickName);
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
	protected void initViews() {
		textView.setText(RunEnv.getInstance().getUser().getName());
	}
}
