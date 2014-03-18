package com.seekon.yougouhui.activity;

import com.seekon.yougouhui.func.module.ModuleServiceHelper;

/**
 * 个人信息主栏目
 * @author undyliu
 *
 */
public class ProfileActivity extends ModuleListActivity{

	public ProfileActivity() {
		super(ModuleServiceHelper.PROFILE_REQUEST_RESULT, "me");
	}
	
}
