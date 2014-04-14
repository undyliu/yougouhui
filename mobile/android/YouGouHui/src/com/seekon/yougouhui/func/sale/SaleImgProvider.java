package com.seekon.yougouhui.func.sale;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class SaleImgProvider extends SQLiteContentProvider {

	private static final int SALE_IMAGES = 1;

	private static final int SALE_IMAGE_ID = 2;

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.sale.image";

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.sale.image";

	private SaleImgData saleImages;

	private UriMatcher uriMatcher;

	public SaleImgProvider() {
		super(SaleImgConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(SaleImgConst.AUTHORITY, SaleImgConst.TABLE_NAME,
				SALE_IMAGES);
		uriMatcher.addURI(SaleImgConst.AUTHORITY, SaleImgConst.TABLE_NAME + "/*",
				SALE_IMAGE_ID);
		saleImages = new SaleImgData(getContext());
		saleImages.onCreate(saleImages.getWritableDatabase());// TODO:
		return true;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case SALE_IMAGES:
			return CONTENT_TYPE;
		case SALE_IMAGE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return saleImages.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return saleImages.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if (action == Action.UPDATE || action == Action.QUERY
				|| action == Action.DELETE) {
			return uriMatcher.match(uri) == SALE_IMAGE_ID;
		} else if (action == Action.INSERT) {
			return uriMatcher.match(uri) == SALE_IMAGES;
		}
		return false;
	}
}
