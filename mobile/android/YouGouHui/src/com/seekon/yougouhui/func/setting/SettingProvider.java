package com.seekon.yougouhui.func.setting;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class SettingProvider extends SQLiteContentProvider {

	private static final int SETTINGS = 1;

	private static final int SETTING_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.setting";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.setting";

	private SettingData settings;

	private UriMatcher uriMatcher;

	public SettingProvider() {
		super(SettingConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher
				.addURI(SettingConst.AUTHORITY, SettingConst.TABLE_NAME, SETTINGS);
		uriMatcher.addURI(SettingConst.AUTHORITY, SettingConst.TABLE_NAME + "/*",
				SETTING_ID);

		settings = new SettingData(getContext());
		settings.onCreate(settings.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return settings.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return settings.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SETTING_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SETTINGS;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SETTINGS:
			return CONTENT_TYPE;
		case SETTING_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
