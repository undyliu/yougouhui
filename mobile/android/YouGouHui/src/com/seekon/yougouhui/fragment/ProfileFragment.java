package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import android.app.Activity;
import android.content.Intent;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.activity.MainActivity;
import com.seekon.yougouhui.activity.contact.ContactListActivity;
import com.seekon.yougouhui.activity.favorit.FavoritMainActivity;
import com.seekon.yougouhui.activity.grade.MyGradeActivity;
import com.seekon.yougouhui.activity.message.MyMessageActivity;
import com.seekon.yougouhui.activity.setting.SettingMainActivity;
import com.seekon.yougouhui.activity.share.MyShareActivity;
import com.seekon.yougouhui.activity.shop.LoginShopActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.module.ModuleConst;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserUtils;

public class ProfileFragment extends ModuleListFragment {

	public ProfileFragment() {
		super();
		this.type = "me";
	}

	@Override
	protected void updateViews() {
		super.updateViews();

		if (UserUtils.isAnonymousUser()) {
			showRegisterUserConfirm("只有会员才能享受此模块内更好的服务，是否注册？");
		}
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case MainActivity.REGISTER_USER_REQUEST_CODE:
			if (resultCode == Activity.RESULT_OK && data != null) {
				UserEntity user = (UserEntity) data
						.getSerializableExtra(UserConst.KEY_REGISTER_USER);
				RunEnv.getInstance().setUser(user);

				// 更新UI
				moduleListAdapter.updateData(modules);
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	public void onListItemClick(ListView l, View v, int position, long id) {
		Intent intent = null;
		String moduleCode = getModuleCode(position);
		if (UserUtils.isAnonymousUser()
				&& !ModuleConst.anonymousAccessModelList.contains(moduleCode)) {
			showRegisterUserConfirm("只有会员才可使用此功能，是否注册?");
			return;
		}

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
		}else if (ModuleConst.CODE_MY_MESSAGE.equalsIgnoreCase(moduleCode)) {
			intent = new Intent(attachedActivity, MyMessageActivity.class);
		}

		if (intent != null) {
			attachedActivity.startActivity(intent);
		}
	}
}
