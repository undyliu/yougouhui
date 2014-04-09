package com.seekon.yougouhui.func.profile.shop;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface ShopConst extends DataConst{

	public static final String TABLE_NAME = "e_shop";

	public static final String AUTHORITY = "com.seekon.yougouhui.shops";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);
	
	public static final String COL_NAME_ADDRESS = "address";
	public static final String COL_NAME_SHOP_IMAGE = "shop_img";
	public static final String COL_NAME_BUSI_LICENSE = "busi_license";
	public static final String COL_NAME_REGISTER_TIME = "register_time";
	public static final String COL_NAME_OWNER = "owner";
	public static final String COL_NAME_STATUS = "status";
	public static final String COL_NAME_BARCODE = "barcode";
	
	public static final String NAME_REQUEST_PARAMETER_TRADES = "tradeList";
	//public static final String NAME_REQUEST_PARAMETER_EMPS = "empList";
	public static final String NAME_REQUEST_PARAMETER_USER_ID = "user_id";
	
	public static final String NAME_SHOP_LIST = "shopList";
	
	public static final String DATA_SHOP_KEY = "data.shop";
	
	public static final String MAP_SHOP_KEY = "map.shop";
}
