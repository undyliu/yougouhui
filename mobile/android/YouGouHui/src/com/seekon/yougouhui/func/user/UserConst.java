package com.seekon.yougouhui.func.user;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface UserConst extends DataConst {

	public static final String TABLE_NAME = "e_user";

	public static final String AUTHORITY = "com.seekon.yougouhui.users";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String KEY_REGISTER_USER = "register.user";

	public static final String DATA_KEY_USER = "user";

	public static final String COL_NAME_PHONE = "phone";
	public static final String COL_NAME_PWD = "pwd";
	public static final String COL_NAME_USER_ICON = "photo";
	public static final String COL_NAME_REGISTER_TIME = "register_time";

	public static final String NAME_USER_NAME = "user_name";

	public static final String TYPE_USER_APP = "1";
	public static final String TYPE_USER_ANONYMOUS = "2";
	public static final String TYPE_USER_WEIBO = "3";
	public static final String TYPE_USER_QQ = "4";
	
}
