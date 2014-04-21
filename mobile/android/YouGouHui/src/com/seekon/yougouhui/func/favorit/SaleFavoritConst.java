package com.seekon.yougouhui.func.favorit;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface SaleFavoritConst extends DataConst {

	public static final String TABLE_NAME = "e_sale_favorit";

	public static final String AUTHORITY = "com.seekon.yougouhui.sale.favorites";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_SALE_ID = "sale_id";
	public static final String COL_NAME_USER_ID = "user_id";
}
