package com.seekon.yougouhui.fragment;

import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.discover.FriendShareActivity;
import com.seekon.yougouhui.activity.discover.RadarActivity;
import com.seekon.yougouhui.func.module.ModuleServiceHelper;

public class DiscoverFragment extends ModuleListFragment {

	public DiscoverFragment() {
		super(ModuleServiceHelper.DISCOVER_REQUEST_RESULT, "discover");
	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		Class<?> activity = null;
		switch (position) {
		case 0:
			activity = FriendShareActivity.class;
			break;
		case 1:
			activity = RadarActivity.class;
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
