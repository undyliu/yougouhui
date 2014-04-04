package com.seekon.yougouhui.db;

import android.content.Context;
import android.database.sqlite.SQLiteOpenHelper;

public abstract class AbstractDBHelper extends SQLiteOpenHelper {

	public static final String DATABASE_NAME = "yougouhui.db";

	public static final int DATABASE_VERSION = 1;

	public AbstractDBHelper(Context context) {
		super(context, DATABASE_NAME, MyCursorFactory.getInstance(),
				DATABASE_VERSION);
	}
}
