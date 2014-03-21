package com.seekon.yougouhui.func.mess;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TITLE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_CHANNEL_ID;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_DISCOUNT;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_PRICE;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_VISIT_COUNT;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.func.AbstractDBHelper;

public class MessageData extends AbstractDBHelper {

	public MessageData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		//db.execSQL(" drop table if EXISTS " + MessageConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + MessageConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " INTEGER PRIMARY KEY, " + COL_NAME_TITLE + " TEXT, "
				+ COL_NAME_CONTENT + " TEXT, " + COL_NAME_IMG + " TEXT, "
				+ COL_NAME_CHANNEL_ID + " INTEGER, " + COL_NAME_DISCOUNT + " INTEGER, "
				+ COL_NAME_PRICE + " INTEGER, " + COL_NAME_VISIT_COUNT + " INTEGER)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL(" drop table if EXISTS " + MessageConst.TABLE_NAME);
		onCreate(db);
	}

}
