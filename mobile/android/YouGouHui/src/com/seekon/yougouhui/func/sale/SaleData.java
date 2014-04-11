package com.seekon.yougouhui.func.sale;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TITLE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_START_DATE;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_END_DATE;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_PUBLISH_TIME;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_SHOP_ID;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_TRADE_ID;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_STATUS;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_DISCUSS_COUNT;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_VISIT_COUNT;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class SaleData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_TITLE, COL_NAME_CONTENT, COL_NAME_IMG, COL_NAME_SHOP_ID,
			COL_NAME_START_DATE, COL_NAME_END_DATE, COL_NAME_PUBLISHER,
			COL_NAME_PUBLISH_TIME, COL_NAME_TRADE_ID, COL_NAME_STATUS,
			COL_NAME_DISCUSS_COUNT, COL_NAME_VISIT_COUNT };

	public SaleData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + MessageConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + SaleConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_TITLE + " TEXT, "
				+ COL_NAME_CONTENT + " TEXT, " + COL_NAME_IMG + " TEXT, "
				+ COL_NAME_SHOP_ID + " TEXT, " + COL_NAME_START_DATE + " TEXT, "
				+ COL_NAME_END_DATE + " TEXT, " + COL_NAME_PUBLISH_TIME + " TEXT, "
				+ COL_NAME_PUBLISHER + " TEXT, " + COL_NAME_TRADE_ID + " TEXT, "
				+ COL_NAME_STATUS + " TEXT, " + COL_NAME_DISCUSS_COUNT + " INTEGER, "
				+ COL_NAME_VISIT_COUNT + " INTEGER)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL(" drop table if EXISTS " + SaleConst.TABLE_NAME);
		onCreate(db);
	}

}
