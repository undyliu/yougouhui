package com.seekon.yougouhui.func.shop;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface TradeConst extends DataConst {

	public static final String TABLE_NAME = "e_trade";

	public static final String AUTHORITY = "com.seekon.yougouhui.trades";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String DATA_TRADE_KEY = "trade";

}
