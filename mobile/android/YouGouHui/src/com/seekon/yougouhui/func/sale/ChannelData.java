package com.seekon.yougouhui.func.sale;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_PARENT_ID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class ChannelData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_CODE, COL_NAME_NAME, COL_NAME_PARENT_ID };

	public ChannelData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + ChannelConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ChannelConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_CODE + " TEXT, "
				+ COL_NAME_NAME + " TEXT, " + COL_NAME_ORD_INDEX + " INTEGER, "
				+ COL_NAME_PARENT_ID + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL(" drop table if EXISTS " + ChannelConst.TABLE_NAME);
		onCreate(db);
	}

}
