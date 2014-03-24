package com.seekon.yougouhui.func.discover.share;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface CommentConst extends DataConst{

	public static final String TABLE_NAME = "e_comment";

	public static final String AUTHORITY = "com.seekon.yougouhui.shares.comment";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
	
	public static final String COL_NAME_COMMENT_ID = "comment_id";
}
