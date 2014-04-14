package com.seekon.yougouhui.func;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import android.content.ContentProvider;
import android.content.ContentUris;
import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;
import android.text.TextUtils;

import com.seekon.yougouhui.db.SQLiteCursorWrapper;
import com.seekon.yougouhui.util.ContentUtils;
import com.seekon.yougouhui.util.Logger;

public abstract class SQLiteContentProvider extends ContentProvider {

	protected final static String TAG = SQLiteContentProvider.class
			.getSimpleName();

	protected String tableName;

	protected abstract SQLiteDatabase getWritableDatabase();

	protected abstract SQLiteDatabase getReadableDatabase();

	protected abstract boolean validateUri(Uri uri, Action action);

	public SQLiteContentProvider(String tableName) {
		super();
		this.tableName = tableName;
	}

	@Override
	public int delete(Uri uri, String selection, String[] selectionArgs) {
		if (!this.validateUri(uri, Action.INSERT)) {
			throw new IllegalArgumentException("Unknown URI " + uri);
		}

		SQLiteDatabase db = getWritableDatabase();
		int rows = db.delete(tableName, selection, selectionArgs);
		getContext().getContentResolver().notifyChange(uri, null);
		return rows;
	}

	@Override
	public Uri insert(Uri uri, ContentValues values) {
		if (!this.validateUri(uri, Action.INSERT)) {
			throw new IllegalArgumentException("Unknown URI " + uri);
		}

		SQLiteDatabase db = getWritableDatabase();

		long id = db.insertOrThrow(tableName, null, values);
		Uri newUri = ContentUris.withAppendedId(uri, id);
		Logger.debug(TAG, "New profile URI: " + newUri.toString());
		getContext().getContentResolver().notifyChange(newUri, null);
		return newUri;
	}

	@Override
	public Cursor query(Uri uri, String[] projection, String selection,
			String[] selectionArgs, String sortOrder) {
		if (this.validateUri(uri, Action.QUERY)) {
			long id = Long.parseLong(uri.getPathSegments().get(1));
			selection = appendRowId(selection, id);
		}

		SQLiteDatabase db = getReadableDatabase();
		Cursor cursor = db.query(tableName, projection, selection, selectionArgs,
				null, null, sortOrder);
		//cursor.setNotificationUri(getContext().getContentResolver(), uri);
		return new SQLiteCursorWrapper(cursor);
	}

	@Override
	public int update(Uri uri, ContentValues values, String selection,
			String[] selectionArgs) {
		if (!this.validateUri(uri, Action.UPDATE)) {
			throw new IllegalArgumentException("Unknown URI " + uri);
		}

		SQLiteDatabase db = getWritableDatabase();
		String recordId = ContentUtils.parseStringId(uri);
		List<String> args = new ArrayList<String>();
		args.add(recordId);

		if (selectionArgs != null) {
			args.addAll(Arrays.asList(selectionArgs));
		}

		int affected = db.update(tableName, values, DataConst.COL_NAME_UUID
				+ "= ? "
				+ (!TextUtils.isEmpty(selection) ? " AND (" + selection + ')' : ""),
				args.toArray(new String[args.size()]));

		Logger.debug(TAG, "Updated profile URI: " + uri.toString());

		getContext().getContentResolver().notifyChange(uri, null);
		return affected;
	}

	protected String appendRowId(String selection, long id) {
		return COL_NAME_UUID + "=" + id
				+ (!TextUtils.isEmpty(selection) ? " AND (" + selection + ')' : "");
	}

	public enum Action {
		QUERY, UPDATE, INSERT, DELETE
	}
}
