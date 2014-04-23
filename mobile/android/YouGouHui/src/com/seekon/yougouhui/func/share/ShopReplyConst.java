package com.seekon.yougouhui.func.share;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface ShopReplyConst extends DataConst{

	public static final String TABLE_NAME = "e_share_shop_reply";

	public static final String AUTHORITY = "com.seekon.yougouhui.shares.shopReply";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_SHARE_ID = "share_id";
	public static final String COL_NAME_SHOP_ID = "shop_id";
	public static final String COL_NAME_REPLIER = "replier";
	public static final String COL_NAME_REPLY_TIME = "reply_time";
	public static final String COL_NAME_GRADE = "grade";
}
