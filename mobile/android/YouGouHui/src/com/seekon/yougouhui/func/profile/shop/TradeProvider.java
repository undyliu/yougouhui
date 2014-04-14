package com.seekon.yougouhui.func.profile.shop;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class TradeProvider extends SQLiteContentProvider {

	private static final int TRADES = 1;

	private static final int TRADE_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.trade";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.trade";

	private TradeData trades;

	private UriMatcher uriMatcher;

	public TradeProvider() {
		super(TradeConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(TradeConst.AUTHORITY, TradeConst.TABLE_NAME, TRADES);
		uriMatcher.addURI(TradeConst.AUTHORITY, TradeConst.TABLE_NAME + "/*",
				TRADE_ID);

		trades = new TradeData(getContext());
		trades.onCreate(trades.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return trades.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return trades.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == TRADE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == TRADES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case TRADES:
			return CONTENT_TYPE;
		case TRADE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
