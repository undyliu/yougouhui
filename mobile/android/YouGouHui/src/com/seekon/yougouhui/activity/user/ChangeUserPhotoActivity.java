package com.seekon.yougouhui.activity.user;

import android.content.Intent;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ChangeImageInfoActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.widget.ChangeTextInfoTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
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
		if(imageFile == null){
			ViewUtils.showToast("请选择头像.");
			return;
		}
		String oldImage = RunEnv.getInstance().getUser().getPhoto();
		if (imageFile.getAliasName().equals(oldImage)) {
			ViewUtils.showToast("头像未做修改，不需要保存更新.");
			return;
		}

		item.setEnabled(false);

		RestUtils.executeAsyncRestTask(this, new ChangeTextInfoTaskCallback(item) {

			@Override
			public void onSuccess(RestMethodResult<JSONObjResource> result) {
				UserEntity user = RunEnv.getInstance().getUser();
				user.setPhoto(imageFile.getAliasName());
				Intent intent = new Intent();
				setResult(RESULT_OK, intent);
				finish();
			}

			@Override
			public RestMethodResult<JSONObjResource> doInBackground() {
				return UserProcessor.getInstance(ChangeUserPhotoActivity.this)
						.updateUserPhoto(imageFile);
			}
		});
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
