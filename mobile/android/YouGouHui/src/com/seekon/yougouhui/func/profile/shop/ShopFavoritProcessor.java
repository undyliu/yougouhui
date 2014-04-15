package com.seekon.yougouhui.func.profile.shop;

import android.content.Context;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;

public class ShopFavoritProcessor extends ContentProcessor {

	private static ShopFavoritProcessor instance = null;
	private static Object lock = new Object();

	public static ShopFavoritProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ShopFavoritProcessor(mContext);
			}
		}
		return instance;
	}

	private ShopFavoritProcessor(Context mContext) {
		super(mContext, ShopFavoritData.COL_NAMES, ShopFavoritConst.CONTENT_URI);
	}

	public RestMethodResult<JSONObjResource> addShopFavorit(String shopId,
			String userId) {
		return (RestMethodResult) this.execMethod(new PostShopFavoritMethod(
				mContext, shopId, userId));
	}
}
