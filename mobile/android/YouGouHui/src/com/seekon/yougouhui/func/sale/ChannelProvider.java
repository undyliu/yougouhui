package com.seekon.yougouhui.func.sale;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ChannelProvider extends SQLiteContentProvider {

	private static final int CHANNELS = 1;

	private static final int CHANNEL_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.channel";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.channel";

	private ChannelData channels;

	private UriMatcher uriMatcher;

	public ChannelProvider() {
		super(ChannelConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher
				.addURI(ChannelConst.AUTHORITY, ChannelConst.TABLE_NAME, CHANNELS);
		uriMatcher.addURI(ChannelConst.AUTHORITY, ChannelConst.TABLE_NAME + "/*",
				CHANNEL_ID);
		channels = new ChannelData(getContext());
		channels.onCreate(channels.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case CHANNELS:
			return CONTENT_TYPE;
		case CHANNEL_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return channels.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return channels.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == CHANNEL_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == CHANNELS;
		}
		return false;
	}
}
