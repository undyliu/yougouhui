package com.seekon.yougouhui.func.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_STATUS;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_GRADE;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_REPLIER;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_REPLY_TIME;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_SHARE_ID;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_SHOP_ID;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class ShopReplyData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_CONTENT, COL_NAME_STATUS, COL_NAME_SHARE_ID, COL_NAME_SHOP_ID,
			COL_NAME_GRADE, COL_NAME_REPLIER, COL_NAME_REPLY_TIME };

	public ShopReplyData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + ShopReplyConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ShopReplyConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_CONTENT + " TEXT, "
				+ COL_NAME_STATUS + " TEXT, " + COL_NAME_SHARE_ID + " TEXT, "
				+ COL_NAME_SHOP_ID + " TEXT, " + COL_NAME_GRADE + " integer, "
				+ COL_NAME_REPLIER + " TEXT, " + COL_NAME_REPLY_TIME + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}
}