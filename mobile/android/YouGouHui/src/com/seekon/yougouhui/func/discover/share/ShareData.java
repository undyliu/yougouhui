package com.seekon.yougouhui.func.discover.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_ACTIVITY_ID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_TIME;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.func.AbstractDBHelper;

public class ShareData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID, COL_NAME_CONTENT,
		COL_NAME_PUBLISH_TIME, COL_NAME_PUBLISHER, COL_NAME_ACTIVITY_ID };
	
	public ShareData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL(" drop table if EXISTS " + ShareConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ShareConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " INTEGER PRIMARY KEY, " + COL_NAME_CONTENT
				+ " TEXT, " + COL_NAME_PUBLISHER + " TEXT, " + COL_NAME_PUBLISH_TIME
				+ " INTEGER, " + COL_NAME_ACTIVITY_ID + " INTEGER)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

}
