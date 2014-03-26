package com.seekon.yougouhui.func.mess;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class MessageProvider extends SQLiteContentProvider {

	private static final int MESSAGES = 1;

	private static final int MESSAGE_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.message";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.message";

	private MessageData messages;

	private UriMatcher uriMatcher;

	public MessageProvider() {
		super(MessageConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher
				.addURI(MessageConst.AUTHORITY, MessageConst.TABLE_NAME, MESSAGES);
		uriMatcher.addURI(MessageConst.AUTHORITY, MessageConst.TABLE_NAME + "/#",
				MESSAGE_ID);
		messages = new MessageData(getContext());
		messages.onCreate(messages.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case MESSAGES:
			return CONTENT_TYPE;
		case MESSAGE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return messages.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return messages.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == MESSAGE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == MESSAGES;
		}
		return false;
	}
}
