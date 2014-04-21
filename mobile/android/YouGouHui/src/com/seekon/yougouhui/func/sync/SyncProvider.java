package com.seekon.yougouhui.func.sync;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class SyncProvider extends SQLiteContentProvider {

	private static final int UPDATES = 1;

	private static final int UPDATE_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.sync";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.sync";

	private SyncData syncDatas;

	private UriMatcher uriMatcher;

	public SyncProvider() {
		super(SyncConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(SyncConst.AUTHORITY, SyncConst.TABLE_NAME, UPDATES);
		uriMatcher.addURI(SyncConst.AUTHORITY, SyncConst.TABLE_NAME + "/*",
				UPDATE_ID);

		syncDatas = SyncData.getInstance(getContext());
		syncDatas.onCreate(syncDatas.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return syncDatas.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return syncDatas.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == UPDATE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == UPDATES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case UPDATES:
			return CONTENT_TYPE;
		case UPDATE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
