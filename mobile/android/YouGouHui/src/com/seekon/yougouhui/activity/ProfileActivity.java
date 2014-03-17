package com.seekon.yougouhui.activity;

import com.seekon.yougouhui.func.module.ModuleServiceHelper;

public class ProfileActivity extends ModuleListActivity{

	public ProfileActivity() {
		super(ModuleServiceHelper.PROFILE_REQUEST_RESULT, "me");
	}
	
}
