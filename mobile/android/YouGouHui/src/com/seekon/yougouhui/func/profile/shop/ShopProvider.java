package com.seekon.yougouhui.func.profile.shop;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ShopProvider extends SQLiteContentProvider {

	private static final int SHOPES = 1;

	private static final int SHOP_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.shop";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.shop";

	private ShopData shopes;

	private UriMatcher uriMatcher;

	public ShopProvider() {
		super(ShopConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(ShopConst.AUTHORITY, ShopConst.TABLE_NAME, SHOPES);
		uriMatcher
				.addURI(ShopConst.AUTHORITY, ShopConst.TABLE_NAME + "/*", SHOP_ID);

		shopes = new ShopData(getContext());
		shopes.onCreate(shopes.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return shopes.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return shopes.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SHOP_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SHOPES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SHOPES:
			return CONTENT_TYPE;
		case SHOP_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
