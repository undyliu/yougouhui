package com.seekon.yougouhui.func.sync;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.sync.SyncConst.COL_NAME_TABLE_NAME;
import static com.seekon.yougouhui.func.sync.SyncConst.COL_NAME_UPDATE_TIME;
import static com.seekon.yougouhui.func.sync.SyncConst.COL_NAME_ITEM_ID;
import static com.seekon.yougouhui.func.sync.SyncConst.TABLE_NAME;

import java.util.UUID;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

/**
 * 记录数据的更新
 * 
 * @author undyliu
 * 
 */
public class SyncData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_UPDATE_TIME, COL_NAME_TABLE_NAME, COL_NAME_ITEM_ID };

	private static SyncData instance;

	private static final Object lock = new Object();

	public static SyncData getInstance(Context context) {
		synchronized (lock) {
			if (instance == null) {
				instance = new SyncData(context);
			}
		}
		return instance;
	}

	private SyncData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_TABLE_NAME
				+ " TEXT," + COL_NAME_ITEM_ID + " TEXT," + COL_NAME_UPDATE_TIME
				+ " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
	}

	/**
	 * 更新数据
	 * 
	 * @param tableName
	 * @param updateTime
	 */
	public void updateData(String tableName, String itemId, String updateTime) {
		SQLiteDatabase db = this.getWritableDatabase();
		onCreate(db);

		ContentValues values = new ContentValues();
		values.put(COL_NAME_UPDATE_TIME, updateTime);

		String where = COL_NAME_TABLE_NAME + " = ? and " + COL_NAME_ITEM_ID + "=?";
		String[] args = new String[] { tableName, itemId };
		int count = db.update(TABLE_NAME, values, where, args);
		if (count == 0) {
			values.put(COL_NAME_ITEM_ID, itemId);
			values.put(COL_NAME_TABLE_NAME, tableName);
			values.put(COL_NAME_UUID, UUID.randomUUID().toString());
			db.insert(TABLE_NAME, null, values);
		}
	}

	/**
	 * 获取最新的更新时间
	 * 
	 * @param tableName
	 * @return
	 */
	public String getUpdateTime(String tableName, String itemId) {
		onCreate(this.getWritableDatabase());

		String updateTime = null;
		SQLiteDatabase db = this.getReadableDatabase();
		Cursor cursor = null;
		try {
			String where = COL_NAME_TABLE_NAME + " = ? and " + COL_NAME_ITEM_ID
					+ "=?";
			String[] args = new String[] { tableName, itemId };
			cursor = db.query(TABLE_NAME, new String[] { COL_NAME_UPDATE_TIME },
					where, args, null, null, null);
			if (cursor.moveToNext()) {
				updateTime = cursor.getString(0);
			}
		} finally {
			cursor.close();
		}
		return updateTime;
	}
}
