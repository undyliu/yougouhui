package com.seekon.yougouhui.func.profile.favorit;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ShopFavoritProvider extends SQLiteContentProvider {

	private static final int SHOP_FAVORITES = 1;

	private static final int SHOP_FAVORITE_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.shop.favorites";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.shop.favorites";

	private ShopFavoritData shopFavorites;

	private UriMatcher uriMatcher;

	public ShopFavoritProvider() {
		super(ShopFavoritConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(ShopFavoritConst.AUTHORITY, ShopFavoritConst.TABLE_NAME,
				SHOP_FAVORITES);
		uriMatcher.addURI(ShopFavoritConst.AUTHORITY, ShopFavoritConst.TABLE_NAME
				+ "/*", SHOP_FAVORITE_ID);
		shopFavorites = new ShopFavoritData(getContext());
		shopFavorites.onCreate(shopFavorites.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SHOP_FAVORITES:
			return CONTENT_TYPE;
		case SHOP_FAVORITE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return shopFavorites.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return shopFavorites.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SHOP_FAVORITE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SHOP_FAVORITES;
		}
		return false;
	}
}
