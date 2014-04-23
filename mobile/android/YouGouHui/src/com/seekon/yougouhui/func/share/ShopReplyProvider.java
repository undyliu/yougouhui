package com.seekon.yougouhui.func.share;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ShopReplyProvider extends SQLiteContentProvider {

	private static final int SHOP_REPLIES = 1;

	private static final int SHOP_REPLY_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.shares.shopReply";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.shares.shopReply";

	private ShopReplyData shopReplies = null;

	private UriMatcher uriMatcher;

	public ShopReplyProvider() {
		super(ShopReplyConst.TABLE_NAME);
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return shopReplies.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return shopReplies.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SHOP_REPLY_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SHOP_REPLIES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SHOP_REPLIES:
			return CONTENT_TYPE;
		case SHOP_REPLY_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(ShopReplyConst.AUTHORITY, ShopReplyConst.TABLE_NAME,
				SHOP_REPLIES);
		uriMatcher.addURI(ShopReplyConst.AUTHORITY, ShopReplyConst.TABLE_NAME + "/*",
				SHOP_REPLY_ID);
		shopReplies = new ShopReplyData(getContext());
		shopReplies.onCreate(shopReplies.getWritableDatabase());// TODO:
		return true;
	}

}

