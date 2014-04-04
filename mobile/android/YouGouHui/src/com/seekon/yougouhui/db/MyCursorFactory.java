package com.seekon.yougouhui.db;

import android.database.Cursor;
import android.database.sqlite.SQLiteCursor;
import android.database.sqlite.SQLiteCursorDriver;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteDatabase.CursorFactory;
import android.database.sqlite.SQLiteQuery;

public class MyCursorFactory implements CursorFactory {

	private static CursorFactory instance = new MyCursorFactory();

	public static CursorFactory getInstance() {
		return instance;
	}

	@Override
	public Cursor newCursor(SQLiteDatabase arg0, SQLiteCursorDriver driver,
			String editTable, SQLiteQuery query) {
		SQLiteCursor cursor = new SQLiteCursor(driver, editTable, query);
		return new SQLiteCursorWrapper(cursor);
	}

}
