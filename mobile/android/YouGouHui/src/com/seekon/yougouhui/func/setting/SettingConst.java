package com.seekon.yougouhui.func.setting;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface SettingConst extends DataConst{

	public static final String TABLE_NAME = "e_setting";

	public static final String AUTHORITY = "com.seekon.yougouhui.settings";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
	
	public static final String COL_NAME_USER_ID = "user_id";
	
	public static final String SETTING_CODE_LOGIN = "login";
	public static final String SETTING_CODE_RADAR = "radar";
	public static final String SETTING_CODE_CACHE = "cache";
}
