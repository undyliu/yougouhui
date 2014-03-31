package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_ICON;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_NAME;
import static com.seekon.yougouhui.func.user.UserConst.TABLE_NAME;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.func.AbstractDBHelper;

public class UserData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_PHONE, COL_NAME_USER_NAME, COL_NAME_USER_ICON, COL_NAME_PWD };

	public UserData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		String sql = " create table IF NOT EXISTS " + TABLE_NAME + " ("
				+ COL_NAME_UUID + " text primary key, " + COL_NAME_PHONE
				+ " integer not null, " + COL_NAME_USER_NAME + " text, "
				+ COL_NAME_USER_ICON + " text, " + COL_NAME_PWD + " text " + ")";
		db.execSQL(sql);
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		// TODO
	}

	public ContentValues getUser(String phone) {
		onCreate(this.getWritableDatabase());
		Cursor cursor = this.getReadableDatabase().query(TABLE_NAME,
				new String[] { COL_NAME_UUID, COL_NAME_USER_NAME, COL_NAME_PWD, COL_NAME_USER_ICON },
				COL_NAME_PHONE + "= ? ", new String[] { phone }, null, null, null);
		if (cursor.getCount() > 0) {
			cursor.moveToNext();
			int i = 0;
			ContentValues user = new ContentValues();
			user.put(COL_NAME_UUID, cursor.getString(i++));
			user.put(COL_NAME_USER_NAME, cursor.getString(i++));
			user.put(COL_NAME_PWD, cursor.getString(i++));
			user.put(COL_NAME_USER_ICON, cursor.getString(i++));
			user.put(COL_NAME_PHONE, phone);
			return user;
		} else {
			return null;
		}
	}

	public void updateUser(ContentValues user) {
		SQLiteDatabase db = this.getWritableDatabase();

		int count = db.update(TABLE_NAME, user, COL_NAME_PHONE + "= ? ",
				new String[] { user.getAsString(COL_NAME_PHONE) });
		if (count == 0) {
			db.insert(TABLE_NAME, null, user);
		}
	}

	public ContentValues auth(String phone, String pwd) {
		ContentValues user = this.getUser(phone);
		if (user == null) {
			return null;
		}
		// TODO:
		String pwdInDb = user.getAsString(COL_NAME_PWD);
		if ((pwdInDb == null && pwd == null)
				|| (pwdInDb != null && pwdInDb.equals(pwd))) {
			return user;
		} else {
			return null;
		}
	}
}
