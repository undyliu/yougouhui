package com.seekon.yougouhui.func.sale;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class SaleProvider extends SQLiteContentProvider {

	private static final int SALES = 1;

	private static final int SALE_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.sale";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.sale";

	private SaleData sales;

	private UriMatcher uriMatcher;

	public SaleProvider() {
		super(SaleConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(SaleConst.AUTHORITY, SaleConst.TABLE_NAME, SALES);
		uriMatcher
				.addURI(SaleConst.AUTHORITY, SaleConst.TABLE_NAME + "/*", SALE_ID);
		sales = new SaleData(getContext());
		sales.onCreate(sales.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SALES:
			return CONTENT_TYPE;
		case SALE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return sales.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return sales.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SALE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SALES;
		}
		return false;
	}
}
