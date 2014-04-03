package com.seekon.yougouhui.func.profile.contact;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.profile.contact.FriendConst.COL_NAME_FRIEND_ID;
import static com.seekon.yougouhui.func.profile.contact.FriendConst.COL_NAME_USER_ID;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.func.AbstractDBHelper;
import com.seekon.yougouhui.func.user.UserEntity;

public class FriendData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_USER_ID, COL_NAME_FRIEND_ID };

	public FriendData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL("CREATE TABLE IF NOT EXISTS " + FriendConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_USER_ID + " TEXT, "
				+ COL_NAME_FRIEND_ID + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase arg0, int arg1, int arg2) {

	}

	public List<UserEntity> getContactListByUserId(String userId) {
		List<UserEntity> contactList = new ArrayList<UserEntity>();
		String sql = " select u.uuid, u.phone, u.name, u.photo from e_user u, e_friend f "
				+ " where u.uuid = f.friend_id and f.user_id = ? ";
		Cursor cursor = getReadableDatabase()
				.rawQuery(sql, new String[] { userId });
		while (cursor.moveToNext()) {
			int i = 0;
			UserEntity contact = new UserEntity(cursor.getString(i++),
					cursor.getString(i++), cursor.getString(i++), null,
					cursor.getString(i++));
			contactList.add(contact);
		}
		return contactList;
	}
}
