package com.seekon.yougouhui.func.mess;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_PARENT_ID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.func.AbstractDBHelper;

public class ChannelData extends AbstractDBHelper {

	public ChannelData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		//db.execSQL(" drop table if EXISTS " + ChannelConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ChannelConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " INTEGER PRIMARY KEY, "
				+ COL_NAME_CODE + " TEXT, " + COL_NAME_NAME
				+ " TEXT, " + COL_NAME_ORD_INDEX + " INTEGER, "
				+ COL_NAME_PARENT_ID + " INTEGER)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL(" drop table if EXISTS " + ChannelConst.TABLE_NAME);
		onCreate(db);
	}

}
