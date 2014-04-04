package com.seekon.yougouhui.func.profile.shop;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface TradeConst extends DataConst{

	public static final String TABLE_NAME = "e_trade";

	public static final String AUTHORITY = "com.seekon.yougouhui.trades";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
	
}
