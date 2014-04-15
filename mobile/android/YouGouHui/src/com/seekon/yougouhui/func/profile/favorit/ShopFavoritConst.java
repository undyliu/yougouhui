package com.seekon.yougouhui.func.profile.favorit;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface ShopFavoritConst extends DataConst{

	public static final String TABLE_NAME = "e_shop_favorit";

	public static final String AUTHORITY = "com.seekon.yougouhui.shop.favorites";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
	
	public static final String COL_NAME_SHOP_ID = "shop_id";
	
	public static final String COL_NAME_USER_ID = "user_id";
}
