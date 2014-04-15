package com.seekon.yougouhui.func.profile.favorit;

import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.service.ContentProcessor;

public class FavoritProcessor extends ContentProcessor {

	public static final int TYPE_SALE = 1;
	public static final int TYPE_SHOP = 2;

	public static FavoritProcessor getFavoritProcessor(Context mContext, int type) {
		switch (type) {
		case TYPE_SALE:
			return new FavoritProcessor(mContext, SaleFavoritData.COL_NAMES,
					SaleConst.CONTENT_URI);
		case TYPE_SHOP:
			return new FavoritProcessor(mContext, ShopFavoritData.COL_NAMES,
					ShopFavoritConst.CONTENT_URI);
		default:
			break;
		}
		return null;
	}

	private FavoritProcessor(Context mContext, String[] colNames, Uri contentUri) {
		super(mContext, colNames, contentUri);
	}

}
