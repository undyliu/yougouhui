package com.seekon.yougouhui.func.profile.contact;

import android.content.Context;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class DeleteFriendTask extends AbstractFriendTask {

	public DeleteFriendTask(Context context, UserEntity friend, Object UIWedget) {
		super(context, friend, UIWedget);
	}

	@Override
	protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
		FriendProcessor processor = new FriendProcessor(context, friend);
		try {
			return processor.deleteFriend();
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage());
		}
		return null;
	}

	@Override
	protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
		if (result != null) {
			int status = result.getStatusCode();
			if (status == 200) {
				RunEnv.getInstance().getUser().removeFriend(friend);
				setUIWedgetEnable(false);
				return;
			}
		}
		ViewUtils.showToast("删除失败.");
	}
}
