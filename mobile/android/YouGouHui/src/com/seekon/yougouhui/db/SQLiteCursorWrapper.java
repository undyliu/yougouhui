package com.seekon.yougouhui.db;

import android.content.ContentResolver;
import android.database.CharArrayBuffer;
import android.database.ContentObserver;
import android.database.Cursor;
import android.database.DataSetObserver;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

/**
 * 对游标封装，监测连接的泄露
 * 
 * @author undyliu
 * 
 */
public class SQLiteCursorWrapper implements Cursor {
	private static final String TAG = SQLiteCursorWrapper.class.getSimpleName();

	private boolean closed = false;
	private Throwable mTrace;

	private Cursor cursor;

	public SQLiteCursorWrapper(Cursor cursor) {
		super();
		this.cursor = cursor;
		mTrace = new Throwable("监测游标是否关闭.");
	}

	public void close() {
		cursor.close();
		closed = true;
	}

	@Override
	protected void finalize() throws Throwable {
		try {
			if (!closed) {
				Log.e(TAG, "存在未关闭的游标：", mTrace);
			}
		} finally {
			super.finalize();
		}
	}

	public void copyStringToBuffer(int columnIndex, CharArrayBuffer buffer) {
		cursor.copyStringToBuffer(columnIndex, buffer);
	}

	public void deactivate() {
		cursor.deactivate();
	}

	public byte[] getBlob(int columnIndex) {
		return cursor.getBlob(columnIndex);
	}

	public int getColumnCount() {
		return cursor.getColumnCount();
	}

	public int getColumnIndex(String columnName) {
		return cursor.getColumnIndex(columnName);
	}

	public int getColumnIndexOrThrow(String columnName)
			throws IllegalArgumentException {
		return cursor.getColumnIndexOrThrow(columnName);
	}

	public String getColumnName(int columnIndex) {
		return cursor.getColumnName(columnIndex);
	}

	public String[] getColumnNames() {
		return cursor.getColumnNames();
	}

	public int getCount() {
		return cursor.getCount();
	}

	public double getDouble(int columnIndex) {
		return cursor.getDouble(columnIndex);
	}

	public Bundle getExtras() {
		return cursor.getExtras();
	}

	public float getFloat(int columnIndex) {
		return cursor.getFloat(columnIndex);
	}

	public int getInt(int columnIndex) {
		return cursor.getInt(columnIndex);
	}

	public long getLong(int columnIndex) {
		return cursor.getLong(columnIndex);
	}

//	public Uri getNotificationUri() {
//		return cursor.getNotificationUri();
//	}

	public int getPosition() {
		return cursor.getPosition();
	}

	public short getShort(int columnIndex) {
		return cursor.getShort(columnIndex);
	}

	public String getString(int columnIndex) {
		return cursor.getString(columnIndex);
	}

	public int getType(int columnIndex) {
		return cursor.getType(columnIndex);
	}

	public boolean getWantsAllOnMoveCalls() {
		return cursor.getWantsAllOnMoveCalls();
	}

	public boolean isAfterLast() {
		return cursor.isAfterLast();
	}

	public boolean isBeforeFirst() {
		return cursor.isBeforeFirst();
	}

	public boolean isClosed() {
		return cursor.isClosed();
	}

	public boolean isFirst() {
		return cursor.isFirst();
	}

	public boolean isLast() {
		return cursor.isLast();
	}

	public boolean isNull(int columnIndex) {
		return cursor.isNull(columnIndex);
	}

	public boolean move(int offset) {
		return cursor.move(offset);
	}

	public boolean moveToFirst() {
		return cursor.moveToFirst();
	}

	public boolean moveToLast() {
		return cursor.moveToLast();
	}

	public boolean moveToNext() {
		return cursor.moveToNext();
	}

	public boolean moveToPosition(int position) {
		return cursor.moveToPosition(position);
	}

	public boolean moveToPrevious() {
		return cursor.moveToPrevious();
	}

	public void registerContentObserver(ContentObserver observer) {
		cursor.registerContentObserver(observer);
	}

	public void registerDataSetObserver(DataSetObserver observer) {
		cursor.registerDataSetObserver(observer);
	}

	public boolean requery() {
		return cursor.requery();
	}

	public Bundle respond(Bundle extras) {
		return cursor.respond(extras);
	}

	public void setNotificationUri(ContentResolver cr, Uri uri) {
		cursor.setNotificationUri(cr, uri);
	}

	public void unregisterContentObserver(ContentObserver observer) {
		cursor.unregisterContentObserver(observer);
	}

	public void unregisterDataSetObserver(DataSetObserver observer) {
		cursor.unregisterDataSetObserver(observer);
	}

}
