package com.seekon.yougouhui.func.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.shop.ShopTradeConst.COL_NAME_SHOP_ID;
import static com.seekon.yougouhui.func.shop.ShopTradeConst.COL_NAME_TRADE_ID;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class ShopTradeData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_SHOP_ID, COL_NAME_TRADE_ID };

	public ShopTradeData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ShopTradeConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_SHOP_ID + " TEXT, "
				+ COL_NAME_TRADE_ID + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	public void deleteShopTradesByShopId(String shopId) {
		String whereClause = COL_NAME_SHOP_ID + "=?";
		String[] whereArgs = new String[] { shopId };
		this.getWritableDatabase().delete(ShopTradeConst.TABLE_NAME, whereClause,
				whereArgs);
	}
}
