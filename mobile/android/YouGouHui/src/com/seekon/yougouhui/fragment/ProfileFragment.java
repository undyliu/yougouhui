package com.seekon.yougouhui.fragment;

import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.profile.SettingActivity;
import com.seekon.yougouhui.func.module.ModuleServiceHelper;

public class ProfileFragment extends ModuleListFragment{

	public ProfileFragment() {
		super(ModuleServiceHelper.PROFILE_REQUEST_RESULT, "me");
	}
	
	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		Intent intent = new Intent(attachedActivity, SettingActivity.class);
		attachedActivity.startActivity(intent);
		//super.onListItemClick(l, v, position, id);
	}
}
