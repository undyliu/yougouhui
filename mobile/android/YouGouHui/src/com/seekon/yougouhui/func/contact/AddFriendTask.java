package com.seekon.yougouhui.func.contact;

import android.content.Context;
import android.widget.TextView;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.spi.IFriendProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class AddFriendTask extends AbstractFriendTask {

	public AddFriendTask(Context context, UserEntity friend, Object UIWedget) {
		super(context, friend, UIWedget);
	}

	@Override
	protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
		IFriendProcessor processor = FriendProcessor.getInstance(context);
		try {
			return processor.addFriend(friend);
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
				RunEnv.getInstance().getUser().addFriend(friend);
				setUIWedgetEnable(false);
				if (UIWedget instanceof TextView) {
					((TextView) UIWedget).setText("已添加");
				}
				return;
			}
		}
		ViewUtils.showToast("添加失败.");
	}
}
