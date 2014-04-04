package com.seekon.yougouhui.func.profile.contact;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface FriendConst extends DataConst {

	public static final String TABLE_NAME = "e_friend";

	public static final String AUTHORITY = "com.seekon.yougouhui.friends";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_FRIEND_ID = "friend_id";
	public static final String COL_NAME_USER_ID = "user_id";

	// public static final String ACTION_ID_FRIEND = "action.id.friend";
	// public static final String ACTION_TYPE_ADD_FRIEND = "action.add.friend";
	// public static final String ACTION_TYPE_DEL_FRIEND = "action.del.friend";

}
