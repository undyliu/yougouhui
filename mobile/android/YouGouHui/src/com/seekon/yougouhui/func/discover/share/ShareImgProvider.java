package com.seekon.yougouhui.func.discover.share;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ShareImgProvider extends SQLiteContentProvider {

	private static final int SHARE_IMAGES = 1;

	private static final int SHARE_IMAGE_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.shares.image";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.shares.image";

	private ShareImgData shareImages;

	private UriMatcher uriMatcher;

	public ShareImgProvider() {
		super(ShareImgConst.TABLE_NAME);
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return shareImages.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return shareImages.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SHARE_IMAGE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SHARE_IMAGES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SHARE_IMAGES:
			return CONTENT_TYPE;
		case SHARE_IMAGE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(ShareImgConst.AUTHORITY, ShareImgConst.TABLE_NAME,
				SHARE_IMAGES);
		uriMatcher.addURI(ShareImgConst.AUTHORITY, ShareImgConst.TABLE_NAME + "/#",
				SHARE_IMAGE_ID);
		shareImages = new ShareImgData(getContext());
		shareImages.onCreate(shareImages.getWritableDatabase());// TODO:
		return true;
	}

}
