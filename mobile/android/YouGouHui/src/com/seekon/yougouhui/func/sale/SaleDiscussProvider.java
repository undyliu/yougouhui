package com.seekon.yougouhui.func.sale;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class SaleDiscussProvider extends SQLiteContentProvider {

	private static final int SALE_DISCUSSES = 1;

	private static final int SALE_DISCUSS_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.sale.discusses";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.sale.discusses";

	private SaleDiscussData saleDiscusses;

	private UriMatcher uriMatcher;

	public SaleDiscussProvider() {
		super(SaleDiscussConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(SaleDiscussConst.AUTHORITY, SaleDiscussConst.TABLE_NAME,
				SALE_DISCUSSES);
		uriMatcher.addURI(SaleDiscussConst.AUTHORITY, SaleDiscussConst.TABLE_NAME
				+ "/*", SALE_DISCUSS_ID);
		saleDiscusses = new SaleDiscussData(getContext());
		saleDiscusses.onCreate(saleDiscusses.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SALE_DISCUSSES:
			return CONTENT_TYPE;
		case SALE_DISCUSS_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return saleDiscusses.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return saleDiscusses.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SALE_DISCUSS_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SALE_DISCUSSES;
		}
		return false;
	}
}
