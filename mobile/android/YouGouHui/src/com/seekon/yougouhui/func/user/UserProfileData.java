package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.user.UserProfileConst.COL_NAME_GRADE_AMOUNT;
import static com.seekon.yougouhui.func.user.UserProfileConst.COL_NAME_GRADE_USED;
import static com.seekon.yougouhui.func.user.UserProfileConst.COL_NAME_SALE_DIS_COUNT;
import static com.seekon.yougouhui.func.user.UserProfileConst.COL_NAME_SHARE_COUNT;
import static com.seekon.yougouhui.func.user.UserProfileConst.COL_NAME_USER_ID;
import static com.seekon.yougouhui.func.user.UserProfileConst.TABLE_NAME;
import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;

public class UserProfileData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_USER_ID, COL_NAME_SALE_DIS_COUNT, COL_NAME_SHARE_COUNT,
			COL_NAME_GRADE_USED, COL_NAME_GRADE_AMOUNT };

	public UserProfileData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		String sql = " create table IF NOT EXISTS " + TABLE_NAME + " ("
				+ COL_NAME_UUID + " text primary key, " + COL_NAME_USER_ID
				+ " text not null, " + COL_NAME_SHARE_COUNT + " integer, "
				+ COL_NAME_SALE_DIS_COUNT + " integer, " + COL_NAME_GRADE_AMOUNT
				+ " integer, " + COL_NAME_GRADE_USED + " integer " + ")";
		db.execSQL(sql);
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}
}
