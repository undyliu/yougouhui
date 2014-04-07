package com.seekon.yougouhui.func.profile.shop;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ShopTradeProvider extends SQLiteContentProvider {

	private static final int SHOP_TRADES = 1;

	private static final int SHOP_TRADE_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.shopTrade";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.shopTrade";

	private ShopTradeData shopTrades;

	private UriMatcher uriMatcher;

	public ShopTradeProvider() {
		super(ShopTradeConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(ShopTradeConst.AUTHORITY, ShopTradeConst.TABLE_NAME,
				SHOP_TRADES);
		uriMatcher.addURI(ShopTradeConst.AUTHORITY, ShopTradeConst.TABLE_NAME
				+ "/*", SHOP_TRADE_ID);

		shopTrades = new ShopTradeData(getContext());
		shopTrades.onCreate(shopTrades.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return shopTrades.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return shopTrades.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SHOP_TRADE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SHOP_TRADES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SHOP_TRADES:
			return CONTENT_TYPE;
		case SHOP_TRADE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
