package com.seekon.yougouhui.func.user;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;


public class UserProvider extends SQLiteContentProvider{

	private static final int USERS = 1;

	private static final int USER_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.user";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.user";

	private UserData user;

	private UriMatcher uriMatcher;

	public UserProvider() {
		super(UserConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(UserConst.AUTHORITY, UserConst.TABLE_NAME, USERS);
		uriMatcher.addURI(UserConst.AUTHORITY, UserConst.TABLE_NAME + "/*",
				USER_ID);

		user = new UserData(getContext());
		user.onCreate(user.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return user.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return user.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == USER_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == USERS;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case USERS:
			return CONTENT_TYPE;
		case USER_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
