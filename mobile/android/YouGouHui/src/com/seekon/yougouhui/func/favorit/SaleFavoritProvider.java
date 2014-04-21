package com.seekon.yougouhui.func.favorit;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class SaleFavoritProvider extends SQLiteContentProvider {

	private static final int SALE_FAVORITES = 1;

	private static final int SALE_FAVORITE_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.sale.favorites";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.sale.favorites";

	private SaleFavoritData saleFavorites;

	private UriMatcher uriMatcher;

	public SaleFavoritProvider() {
		super(SaleFavoritConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(SaleFavoritConst.AUTHORITY, SaleFavoritConst.TABLE_NAME,
				SALE_FAVORITES);
		uriMatcher.addURI(SaleFavoritConst.AUTHORITY, SaleFavoritConst.TABLE_NAME
				+ "/*", SALE_FAVORITE_ID);
		saleFavorites = new SaleFavoritData(getContext());
		saleFavorites.onCreate(saleFavorites.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SALE_FAVORITES:
			return CONTENT_TYPE;
		case SALE_FAVORITE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return saleFavorites.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return saleFavorites.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SALE_FAVORITE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SALE_FAVORITES;
		}
		return false;
	}
}
