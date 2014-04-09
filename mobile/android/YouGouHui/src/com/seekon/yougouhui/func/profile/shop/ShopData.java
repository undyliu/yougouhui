package com.seekon.yougouhui.func.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_ADDRESS;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BUSI_LICENSE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_REGISTER_TIME;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_SHOP_IMAGE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_OWNER;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BARCODE;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class ShopData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_DESC, COL_NAME_NAME, COL_NAME_ADDRESS, COL_NAME_BUSI_LICENSE,
			COL_NAME_SHOP_IMAGE, COL_NAME_REGISTER_TIME, COL_NAME_OWNER,
			COL_NAME_BARCODE };

	public ShopData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ShopConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_DESC + " TEXT, "
				+ COL_NAME_NAME + " TEXT, " + COL_NAME_ADDRESS + " TEXT, "
				+ COL_NAME_BUSI_LICENSE + " TEXT, " + COL_NAME_SHOP_IMAGE + " TEXT, "
				+ COL_NAME_OWNER + " TEXT, " + COL_NAME_BARCODE + " TEXT, "
				+ COL_NAME_REGISTER_TIME + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}
}
