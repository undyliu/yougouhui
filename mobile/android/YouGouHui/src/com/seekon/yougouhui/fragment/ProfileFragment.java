package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.profile.ContactListActivity;
import com.seekon.yougouhui.activity.profile.MyShareActivity;
import com.seekon.yougouhui.activity.profile.SettingActivity;
import com.seekon.yougouhui.activity.profile.shop.LoginShopActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.module.ModuleConst;
import com.seekon.yougouhui.func.module.ModuleServiceHelper;

public class ProfileFragment extends ModuleListFragment {

	public ProfileFragment() {
		super(ModuleServiceHelper.PROFILE_REQUEST_RESULT, "me");
	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		Intent intent = null;
		String moduleCode = getModuleCode(position);
		if (ModuleConst.CODE_SETTING.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, SettingActivity.class);
		} else if (ModuleConst.CODE_MY_SHARE.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, MyShareActivity.class);
			intent.putExtra(COL_NAME_UUID, RunEnv.getInstance().getUser().getUuid());
		} else if (ModuleConst.CODE_MY_SHOP.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, LoginShopActivity.class);
		} else if (ModuleConst.CODE_CONTACT_LIST.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, ContactListActivity.class);
		}

		if (intent != null) {
			attachedActivity.startActivity(intent);
		}
	}
}
