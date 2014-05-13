package com.seekon.yougouhui.func.message;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface MessageConst extends DataConst{

	public static final String TABLE_NAME = "e_message";

	public static final String AUTHORITY = "com.seekon.yougouhui.messages";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
	
	public static final String COL_NAME_SENDER = "sender";
	public static final String COL_NAME_SEND_SHOP = "send_shop";
	public static final String COL_NAME_SEND_TIME = "send_time";
	public static final String COL_NAME_RECEIVER = "receiver";
	
	public static final String DATA_SHOP_KEY = "shop";
	public static final String DATA_SENDER_KEY = "user-sender";
}
