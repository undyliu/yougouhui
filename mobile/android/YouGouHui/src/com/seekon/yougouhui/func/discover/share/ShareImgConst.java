package com.seekon.yougouhui.func.discover.share;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface ShareImgConst extends DataConst{

	public static final String TABLE_NAME = "e_share_img";

	public static final String AUTHORITY = "com.seekon.yougouhui.shares.image";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
	
	public static final String COL_NAME_SHARE_ID = "share_id";
}
