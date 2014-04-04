package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_REGISTER_TIME;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_ICON;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_NAME;
import static com.seekon.yougouhui.func.user.UserConst.TABLE_NAME;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

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
				+ COL_NAME_REGISTER_TIME + " text, " + COL_NAME_USER_ICON + " text, "
				+ COL_NAME_PWD + " text " + ")";
		db.execSQL(sql);
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		// TODO
	}

	public UserEntity getUser(String phone) {
		UserEntity user = null;
		onCreate(this.getWritableDatabase());
		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().query(
					TABLE_NAME,
					new String[] { COL_NAME_UUID, COL_NAME_USER_NAME, COL_NAME_PWD,
							COL_NAME_USER_ICON, COL_NAME_REGISTER_TIME },
					COL_NAME_PHONE + "= ? ", new String[] { phone }, null, null, null);
			if (cursor.getCount() > 0) {
				cursor.moveToNext();
				int i = 0;
				user = new UserEntity(cursor.getString(i++), phone,
						cursor.getString(i++), cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++));
			}
		} finally {
			cursor.close();
		}
		return user;
	}

	public void updateUser(ContentValues user) {
		SQLiteDatabase db = this.getWritableDatabase();

		int count = db.update(TABLE_NAME, user, COL_NAME_PHONE + "= ? ",
				new String[] { user.getAsString(COL_NAME_PHONE) });
		if (count == 0) {
			db.insert(TABLE_NAME, null, user);
		}
	}

	public UserEntity auth(String phone, String pwd) {
		UserEntity user = this.getUser(phone);
		if (user == null) {
			return null;
		}
		// TODO:
		String pwdInDb = user.getPwd();
		if ((pwdInDb == null && pwd == null)
				|| (pwdInDb != null && pwdInDb.equals(pwd))) {
			user.setFriends(getUserFriends(user.getUuid()));
			return user;
		} else {
			return null;
		}
	}

	public List<UserEntity> getUserFriends(String userId) {
		List<UserEntity> result = new ArrayList<UserEntity>();
		String sql = " select distinct u.uuid, u.phone, u.name, u.photo from e_user u, e_friend f "
				+ " where u.uuid = f.friend_id and f.user_id = ? ";
		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase()
					.rawQuery(sql, new String[] { userId });
			while (cursor.moveToNext()) {
				int i = 0;
				result.add(new UserEntity(cursor.getString(i++), cursor.getString(i++),
						cursor.getString(i++), null, cursor.getString(i++)));
			}
		} finally {
			cursor.close();
		}
		return result;
	}
}
