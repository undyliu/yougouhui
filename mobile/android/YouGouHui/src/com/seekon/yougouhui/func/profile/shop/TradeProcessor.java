package com.seekon.yougouhui.func.profile.shop;

import android.content.Context;

import com.seekon.yougouhui.func.spi.ITradeProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;

public class TradeProcessor extends ContentProcessor implements ITradeProcessor{

	private static ITradeProcessor instance = null;

	private static Object lock = new Object();

	public static ITradeProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (ITradeProcessor) proxy.bind(new TradeProcessor(mContext));
			}
		}
		return instance;
	}

	private TradeProcessor(Context mContext) {
		super(mContext, TradeData.COL_NAMES, TradeConst.CONTENT_URI);

	}

	public RestMethodResult<JSONArrayResource> getTrades() {
		return (RestMethodResult) this.execMethod(new GetTradesMethod(mContext));
	}
}
