package com.seekon.yougouhui.func.profile.favorit;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.profile.favorit.SaleFavoritConst.COL_NAME_SALE_ID;
import static com.seekon.yougouhui.func.profile.favorit.SaleFavoritConst.COL_NAME_USER_ID;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class SaleFavoritData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
		COL_NAME_USER_ID, COL_NAME_SALE_ID };

	public SaleFavoritData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + SaleDiscussConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + SaleFavoritConst.TABLE_NAME
				+ " (" + COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_USER_ID
				+ " TEXT, " + COL_NAME_SALE_ID + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}
}
