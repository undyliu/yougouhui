package com.seekon.yougouhui.db;

import android.content.Context;
import android.database.sqlite.SQLiteOpenHelper;

public abstract class AbstractDBHelper extends SQLiteOpenHelper{

	public AbstractDBHelper(Context context) {
		super(context, DBConst.DATABASE_NAME, null, DBConst.DATABASE_VERSION);
	}
}
