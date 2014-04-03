package com.seekon.yougouhui.func.profile.contact;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class FriendProvider extends SQLiteContentProvider {

	private static final int FRIEDNS = 1;

	private static final int FRIEND_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.friend";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.friend";

	private FriendData friends;

	private UriMatcher uriMatcher;

	public FriendProvider() {
		super(FriendConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(FriendConst.AUTHORITY, FriendConst.TABLE_NAME, FRIEDNS);
		uriMatcher.addURI(FriendConst.AUTHORITY, FriendConst.TABLE_NAME + "/*",
				FRIEND_ID);

		friends = new FriendData(getContext());
		friends.onCreate(friends.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return friends.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return friends.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == FRIEND_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == FRIEDNS;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case FRIEDNS:
			return CONTENT_TYPE;
		case FRIEND_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}
}
