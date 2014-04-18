package com.seekon.yougouhui.func.sale;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface SaleDiscussConst extends DataConst {

	public static final String TABLE_NAME = "e_sale_discuss";

	public static final String AUTHORITY = "com.seekon.yougouhui.sale.discusses";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_SALE_ID = "sale_id";

}
