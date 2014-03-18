package com.seekon.yougouhui.activity;

import com.seekon.yougouhui.func.module.ModuleServiceHelper;

/**
 * 发现主栏目
 * @author undyliu
 *
 */
public class DiscoverActivity extends ModuleListActivity {
	
	public DiscoverActivity() {
		super(ModuleServiceHelper.DISCOVER_REQUEST_RESULT, "discover");
	}

}
