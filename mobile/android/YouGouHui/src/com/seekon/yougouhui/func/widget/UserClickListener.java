package com.seekon.yougouhui.func.widget;

import android.app.Activity;
import android.content.Intent;
import android.view.View;

import com.seekon.yougouhui.activity.contact.FriendProfileActivity;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;

public class UserClickListener implements View.OnClickListener {

	private UserEntity user = null;

	private Activity context;

	private int requestCode = -1;

	public UserClickListener(UserEntity user, Activity context, int requestCode) {
		super();
		this.user = user;
		this.context = context;
		this.requestCode = requestCode;
	}

	@Override
	public void onClick(View v) {
		Intent intent = new Intent(context, FriendProfileActivity.class);
		intent.putExtra(UserConst.DATA_KEY_USER, user);
		if (requestCode > 0) {
			context.startActivityForResult(intent, requestCode);
		} else {
			context.startActivity(intent);
		}
	}

}