package com.seekon.yougouhui.func.profile.shop;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface ShopTradeConst extends DataConst {

	public static final String TABLE_NAME = "e_shop_trade";

	public static final String AUTHORITY = "com.seekon.yougouhui.shopTrades";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_SHOP_ID = "shop_id";

	public static final String COL_NAME_TRADE_ID = "trade_id";
}
