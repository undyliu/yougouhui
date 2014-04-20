package com.seekon.yougouhui.activity.user;

import android.content.Intent;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ChangeImageInfoActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.widget.AbstractChangeInfoTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 修改用户头像
 * 
 * @author undyliu
 * 
 */
public class ChangeUserPhotoActivity extends ChangeImageInfoActivity {

	@Override
	protected void doChangeImage(final MenuItem item) {
		if (imageFile.equals(RunEnv.getInstance().getUser().getPhoto())) {
			ViewUtils.showToast("头像未做修改，不需要保存更新.");
			return;
		}

		AbstractChangeInfoTask task = new AbstractChangeInfoTask(item) {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return UserProcessor.getInstance(ChangeUserPhotoActivity.this)
						.updateUserPhoto(imageFile);
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
	protected FileEntity getImageFile() {
		String aliasName = RunEnv.getInstance().getUser().getPhoto();
		return new FileEntity(null, aliasName);
	}

	@Override
	protected int getImageLabel() {
		return R.string.label_change_image;
	}
}
