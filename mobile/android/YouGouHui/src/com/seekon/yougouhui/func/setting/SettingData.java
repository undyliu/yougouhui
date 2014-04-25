package com.seekon.yougouhui.func.setting;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_VALUE;
import static com.seekon.yougouhui.func.setting.SettingConst.COL_NAME_USER_ID;
import android.content.ContentValues;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class SettingData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_CODE, COL_NAME_NAME, COL_NAME_IMG, COL_NAME_VALUE,
			COL_NAME_ORD_INDEX, COL_NAME_USER_ID };

	public SettingData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL("CREATE TABLE IF NOT EXISTS " + SettingConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_CODE + " TEXT, "
				+ COL_NAME_NAME + " TEXT, " + COL_NAME_ORD_INDEX + " INTEGER, "
				+ COL_NAME_USER_ID + " TEXT, " + COL_NAME_IMG + " TEXT, "
				+ COL_NAME_VALUE + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	public int saveSettingValue(String uuid, String value) {
		SQLiteDatabase db = this.getWritableDatabase();
		ContentValues values = new ContentValues();
		values.put(COL_NAME_VALUE, value);
		return db.update(SettingConst.TABLE_NAME, values, COL_NAME_UUID + "=?",
				new String[] { uuid });
	}
}
