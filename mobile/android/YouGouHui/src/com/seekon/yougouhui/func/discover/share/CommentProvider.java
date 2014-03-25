package com.seekon.yougouhui.func.discover.share;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class CommentProvider extends SQLiteContentProvider {

	private static final int SHARE_COMMENTS = 1;

	private static final int SHARE_COMMENT_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.shares.comment";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.shares.comment";

	private CommentData comments = null;

	private UriMatcher uriMatcher;

	public CommentProvider() {
		super(CommentConst.TABLE_NAME);
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return comments.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return comments.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SHARE_COMMENT_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SHARE_COMMENTS;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SHARE_COMMENTS:
			return CONTENT_TYPE;
		case SHARE_COMMENT_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(CommentConst.AUTHORITY, CommentConst.TABLE_NAME,
				SHARE_COMMENTS);
		uriMatcher.addURI(CommentConst.AUTHORITY, CommentConst.TABLE_NAME + "/*",
				SHARE_COMMENT_ID);
		comments = new CommentData(getContext());
		comments.onCreate(comments.getWritableDatabase());// TODO:
		return true;
	}

}
