package com.seekon.yougouhui.func.user;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface UserProfileConst extends DataConst {

	public static final String TABLE_NAME = "e_user_profile";

	public static final String AUTHORITY = "com.seekon.yougouhui.userProfiles";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_USER_ID = "user_id";
	public static final String COL_NAME_SHARE_COUNT = "share_count";
	public static final String COL_NAME_SALE_DIS_COUNT = "sale_discuss_count";
	public static final String COL_NAME_GRADE_AMOUNT = "grade_amount";
	public static final String COL_NAME_GRADE_USED = "grade_used";
}
