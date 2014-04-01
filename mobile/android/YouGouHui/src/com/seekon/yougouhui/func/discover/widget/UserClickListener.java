package com.seekon.yougouhui.func.discover.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import android.content.Context;
import android.content.Intent;
import android.view.View;

import com.seekon.yougouhui.activity.user.FriendProfileActivity;

public class UserClickListener implements View.OnClickListener {

	private String userId = null;
	
	private Context context;
	
	public UserClickListener(String userId, Context context) {
		super();
		this.userId = userId;
		this.context = context;
	}

	@Override
	public void onClick(View v) {
		Intent intent = new Intent(context, FriendProfileActivity.class);
		intent.putExtra(COL_NAME_UUID, userId);
		context.startActivity(intent);
	}

}