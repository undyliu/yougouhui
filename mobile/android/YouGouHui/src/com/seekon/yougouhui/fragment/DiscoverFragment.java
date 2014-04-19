package com.seekon.yougouhui.fragment;

import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.discover.FriendShareActivity;
import com.seekon.yougouhui.activity.discover.RadarActivity;
import com.seekon.yougouhui.func.module.ModuleConst;

public class DiscoverFragment extends ModuleListFragment {

	public DiscoverFragment() {
		super();
		this.type = "discover";
	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		Intent intent = null;
		String moduleCode = getModuleCode(position);
		if (ModuleConst.CODE_FRIENDS.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, FriendShareActivity.class);
		} else if (ModuleConst.CODE_RADAR.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, RadarActivity.class);
		}

		if (intent != null) {
			attachedActivity.startActivity(intent);
		}
	}

}
