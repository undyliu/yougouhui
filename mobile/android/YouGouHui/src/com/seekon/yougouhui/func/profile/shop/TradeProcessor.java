package com.seekon.yougouhui.func.profile.shop;

import android.content.Context;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.service.ContentProcessor;

public class TradeProcessor extends ContentProcessor {

	private static TradeProcessor instance = null;

	private static Object lock = new Object();

	public static TradeProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new TradeProcessor(mContext);
			}
		}
		return instance;
	}

	private TradeProcessor(Context mContext) {
		super(mContext, TradeData.COL_NAMES, TradeConst.CONTENT_URI);

	}

	public RestMethodResult<JSONArrayResource> getTrades() {
		return (RestMethodResult) this.execMethod(new GetTradeMethod(mContext));
	}
}
