package com.seekon.yougouhui.func.sync;

import static com.seekon.yougouhui.func.sync.SyncConst.COL_NAME_TABLE_NAME;
import static com.seekon.yougouhui.func.sync.SyncConst.COL_NAME_UPDATE_TIME;
import static com.seekon.yougouhui.func.sync.SyncConst.TABLE_NAME;
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

	public static final String[] COL_NAMES = new String[] { COL_NAME_TABLE_NAME,
			COL_NAME_UPDATE_TIME };

	public SyncData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + TABLE_NAME + " ("
				+ COL_NAME_TABLE_NAME + " TEXT PRIMARY KEY, " + COL_NAME_UPDATE_TIME
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
	public void updateData(String tableName, String updateTime) {
		SQLiteDatabase db = this.getWritableDatabase();
		onCreate(db);

		ContentValues values = new ContentValues();
		values.put(COL_NAME_UPDATE_TIME, updateTime);

		int count = db.update(TABLE_NAME, values, COL_NAME_TABLE_NAME + " = ?",
				new String[] { tableName });
		if (count == 0) {
			values.put(COL_NAME_TABLE_NAME, tableName);
			//values.put(COL_NAME_UUID, UUID.randomUUID().toString());
			db.insert(TABLE_NAME, null, values);
		}
	}

	/**
	 * 获取最新的更新时间
	 * 
	 * @param tableName
	 * @return
	 */
	public String getUpdateTime(String tableName) {
		onCreate(this.getWritableDatabase());

		String updateTime = null;
		SQLiteDatabase db = this.getReadableDatabase();
		Cursor cursor = null;
		try {
			cursor = db.query(TABLE_NAME, new String[] { COL_NAME_UPDATE_TIME },
					COL_NAME_TABLE_NAME + " = ?", new String[] { tableName }, null, null,
					null);
			if (cursor.moveToNext()) {
				updateTime = cursor.getString(0);
			}
		} finally {
			cursor.close();
		}
		return updateTime;
	}
}
