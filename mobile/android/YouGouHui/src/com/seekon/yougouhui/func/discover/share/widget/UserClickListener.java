package com.seekon.yougouhui.func.discover.share.widget;

import android.content.Context;
import android.content.Intent;
import android.view.View;

import com.seekon.yougouhui.activity.user.FriendProfileActivity;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;

public class UserClickListener implements View.OnClickListener {

	private UserEntity user = null;

	private Context context;

	public UserClickListener(UserEntity user, Context context) {
		super();
		this.user = user;
		this.context = context;
	}

	@Override
	public void onClick(View v) {
		Intent intent = new Intent(context, FriendProfileActivity.class);
		intent.putExtra(UserConst.DATA_KEY_USER, user);
		context.startActivity(intent);
	}

}