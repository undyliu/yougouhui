package com.seekon.yougouhui.fragment;

import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.radar.RadarMainActivity;
import com.seekon.yougouhui.activity.share.FriendShareActivity;
import com.seekon.yougouhui.func.module.ModuleConst;
import com.seekon.yougouhui.activity.coupon.CouponMainAcitity;

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
			intent = new Intent(attachedActivity, RadarMainActivity.class);
		}else if (ModuleConst.CODE_COUPON.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, CouponMainAcitity.class);
		}
		
		if (intent != null) {
			attachedActivity.startActivity(intent);
		}
	}

}
