package com.seekon.yougouhui.func.mess;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface MessageConst extends DataConst {

	public static final String TABLE_NAME = "e_activity";

	public static final String AUTHORITY = "com.seekon.yougouhui.messages";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_CHANNEL_ID = "channel_id";

	public static final String COL_NAME_PRICE = "price";

	public static final String COL_NAME_DISCOUNT = "discount";

	public static final String COL_NAME_VISIT_COUNT = "visit_count";

	public static final String MESSAGE_DATA_KEY = "message.data.key";

}
