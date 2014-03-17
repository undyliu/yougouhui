package com.seekon.yougouhui.db;

import java.util.Iterator;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import com.seekon.yougouhui.util.Logger;

/**
 * 登录环境的数据库操作类
 * 
 * @author undyliu
 * 
 */
public class EnvHelper extends AbstractDBHelper {

	public static final String TABLE_NAME = "e_env";

	public static final String COL_NAME_PHONE = "phone";

	public static final String COL_NAME_LOGIN_SETTING = "login_setting";

	public static final String COL_NAME_LAST_MODIFY_TIME = "last_modify_time";

	public EnvHelper(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		String sql = " create table IF NOT EXISTS " + TABLE_NAME + " (" + COL_NAME_PHONE
				+ " integer primary key, " + COL_NAME_LOGIN_SETTING + " text, "
				+ COL_NAME_LAST_MODIFY_TIME + " integer " + ")";
		db.execSQL(sql);
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		// TODO
	}

	/**
	 * 获取登录设置信息
	 * 
	 * @return
	 */
	public JSONObject getLoginSetting() {
		onCreate(this.getWritableDatabase());
		
		Cursor cursor = this.getReadableDatabase().query(TABLE_NAME,
				new String[] { COL_NAME_LOGIN_SETTING }, null, null, null, null,
				COL_NAME_LAST_MODIFY_TIME + " desc ");
		int rows = cursor.getCount();
		if (rows > 0) {
			cursor.moveToNext();
			try {
				return new JSONObject(cursor.getString(0));
			} catch (JSONException e) {
				Log.e("getLoginSetting", e.getMessage());
			}
		}
		return null;
	}

	/**
	 * 更新用户登录设置
	 * @param loginObj
	 */
	public void updateLoginSetting(JSONObject loginObj) {
		String phone = null;
		try {
			phone = loginObj.getString(COL_NAME_PHONE);
		} catch (JSONException e) {
			Log.d("updateLoginSetting", e.getMessage());
		}
		if (phone == null) {
			Log.d("updateLoginSetting", " phone is null.");
			return;
		}
		ContentValues values = new ContentValues();
		values.put(COL_NAME_LOGIN_SETTING, loginObj.toString());
		SQLiteDatabase db = this.getWritableDatabase();
		int count = db.update(TABLE_NAME, values, COL_NAME_PHONE + " = ?",
				new String[] { phone });
		if (count == 0) {
			values.put(COL_NAME_PHONE, phone);
			values.put(COL_NAME_LAST_MODIFY_TIME, System.currentTimeMillis());
			db.insert(TABLE_NAME, null, values);
		}
	}
	
	public void updateLoginSetting(ContentValues loginSetting){
		JSONObject loginObj = new JSONObject();
		Iterator<String> iterator = loginSetting.keySet().iterator();
		while(iterator.hasNext()){
			String key = iterator.next();
			try {
				loginObj.put(key, loginSetting.get(key));
			} catch (JSONException e) {
				Logger.warn("updateLoginSetting", e.getMessage());
				return;
			}
		}
		this.updateLoginSetting(loginObj);
	}
}
