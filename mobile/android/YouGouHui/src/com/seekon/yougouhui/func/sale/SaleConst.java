package com.seekon.yougouhui.func.sale;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface SaleConst extends DataConst {

	public static final String TABLE_NAME = "e_sale";

	public static final String AUTHORITY = "com.seekon.yougouhui.sales";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String COL_NAME_CHANNEL_ID = "channel_id";
	public static final String COL_NAME_TRADE_ID = "trade_id";
	public static final String COL_NAME_SHOP_ID = "shop_id";
	public static final String COL_NAME_SHOP_NAME = "shop_name";
	public static final String COL_NAME_PUBLISHER = "publisher";
	public static final String COL_NAME_START_DATE = "start_date";
	public static final String COL_NAME_END_DATE = "end_date";
	public static final String COL_NAME_PUBLISH_TIME = "publish_time";
	public static final String COL_NAME_PUBLISH_DATE = "publish_date";
	public static final String COL_NAME_STATUS = "status";

	// public static final String COL_NAME_PRICE = "price";
	// public static final String COL_NAME_DISCOUNT = "discount";

	public static final String COL_NAME_VISIT_COUNT = "visit_count";
	public static final String COL_NAME_DISCUSS_COUNT = "discuss_count";

	public static final String DATA_SALE_KEY = "sale";
	public static final String DATA_IMAGES_KEY = "images";

	public static final String DATA_REQUEST_PUBLISH_RESULT = "publish.result";
}
