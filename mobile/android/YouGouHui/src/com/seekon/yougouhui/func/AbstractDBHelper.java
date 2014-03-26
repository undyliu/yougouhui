package com.seekon.yougouhui.func;

import android.content.Context;
import android.database.sqlite.SQLiteOpenHelper;

public abstract class AbstractDBHelper extends SQLiteOpenHelper {

	public static final String DATABASE_NAME = "yougouhui.db";

	public static final int DATABASE_VERSION = 1;

	public AbstractDBHelper(Context context) {
		super(context, DATABASE_NAME, null, DATABASE_VERSION);
	}
}
