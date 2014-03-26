package com.seekon.yougouhui.func.mess;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface ChannelConst extends DataConst {

	public static final String TABLE_NAME = "e_channel";

	public static final String AUTHORITY = "com.seekon.yougouhui.channels";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String CHANNEL_DATA_KEY = "channels.key";
}
