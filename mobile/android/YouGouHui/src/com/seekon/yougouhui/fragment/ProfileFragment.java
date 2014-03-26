package com.seekon.yougouhui.fragment;

import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.profile.SettingActivity;
import com.seekon.yougouhui.func.module.ModuleServiceHelper;

public class ProfileFragment extends ModuleListFragment {

	public ProfileFragment() {
		super(ModuleServiceHelper.PROFILE_REQUEST_RESULT, "me");
	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		Class<?> activity = null;
		switch (position) {
		case 0:
			activity = SettingActivity.class;
			break;

		default:
			break;
		}
		if (activity != null) {
			Intent intent = new Intent(attachedActivity, activity);
			attachedActivity.startActivity(intent);
		}
	}
}
