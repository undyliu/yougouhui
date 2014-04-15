package com.seekon.yougouhui.func.sale;

import android.content.Context;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;

public class SaleFavoritProcessor extends ContentProcessor {

	private static SaleFavoritProcessor instance = null;
	private static Object lock = new Object();

	public static SaleFavoritProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new SaleFavoritProcessor(mContext);
			}
		}
		return instance;
	}

	private SaleFavoritProcessor(Context mContext) {
		super(mContext, SaleFavoritData.COL_NAMES, SaleFavoritConst.CONTENT_URI);
	}

	public RestMethodResult<JSONObjResource> addSaleFavorit(String saleId,
			String userId) {
		return (RestMethodResult) this.execMethod(new PostSaleFavoritMethod(
				mContext, saleId, userId));
	}
}
