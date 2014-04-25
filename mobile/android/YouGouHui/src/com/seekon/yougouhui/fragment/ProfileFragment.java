package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.contact.ContactListActivity;
import com.seekon.yougouhui.activity.favorit.FavoritMainActivity;
import com.seekon.yougouhui.activity.grade.MyGradeActivity;
import com.seekon.yougouhui.activity.setting.SettingMainActivity;
import com.seekon.yougouhui.activity.share.MyShareActivity;
import com.seekon.yougouhui.activity.shop.LoginShopActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.module.ModuleConst;

public class ProfileFragment extends ModuleListFragment {

	public ProfileFragment() {
		super();
		this.type = "me";
	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		Intent intent = null;
		String moduleCode = getModuleCode(position);
		if (ModuleConst.CODE_SETTING.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, SettingMainActivity.class);
		} else if (ModuleConst.CODE_MY_SHARE.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, MyShareActivity.class);
			intent.putExtra(COL_NAME_UUID, RunEnv.getInstance().getUser().getUuid());
		} else if (ModuleConst.CODE_MY_SHOP.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, LoginShopActivity.class);
		} else if (ModuleConst.CODE_CONTACT_LIST.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, ContactListActivity.class);
		} else if (ModuleConst.CODE_MY_FAVORIT.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, FavoritMainActivity.class);
		} else if (ModuleConst.CODE_MY_GRADE.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, MyGradeActivity.class);
		}

		if (intent != null) {
			attachedActivity.startActivity(intent);
		}
	}
}
