package com.seekon.yougouhui.func.discover.share;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ShareProvider extends SQLiteContentProvider {

	private static final int SHARES = 1;

	private static final int SHARE_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.shares";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.shares";

	private ShareData shares;

	private UriMatcher uriMatcher;

	public ShareProvider() {
		super(ShareConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(ShareConst.AUTHORITY, ShareConst.TABLE_NAME, SHARES);
		uriMatcher.addURI(ShareConst.AUTHORITY, ShareConst.TABLE_NAME + "/*",
				SHARE_ID);
		shares = new ShareData(getContext());
		shares.onCreate(shares.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return shares.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return shares.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if(action == Action.UPDATE || action == Action.QUERY || action == Action.DELETE){
			return uriMatcher.match(uri) == SHARE_ID;
		}else if(action == Action.INSERT){
			return uriMatcher.match(uri) == SHARES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SHARES:
			return CONTENT_TYPE;
		case SHARE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
