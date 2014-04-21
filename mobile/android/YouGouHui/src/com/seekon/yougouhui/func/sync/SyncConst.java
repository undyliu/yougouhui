package com.seekon.yougouhui.func.sync;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface SyncConst extends DataConst {

	public static final String TABLE_NAME = "e_update";

	public static final String COL_NAME_UPDATE_TIME = "update_time";

	public static final String COL_NAME_TABLE_NAME = "table_name";

	public static final String COL_NAME_USER_ID = "user_id";

	public static final String AUTHORITY = "com.seekon.yougouhui.syncs";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
}
