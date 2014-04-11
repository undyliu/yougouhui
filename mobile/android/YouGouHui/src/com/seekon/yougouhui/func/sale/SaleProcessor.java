package com.seekon.yougouhui.func.sale;

import android.content.Context;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class SaleProcessor extends ContentProcessor {

	private static SaleProcessor instance = null;
	private static Object lock = new Object();

	public static SaleProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new SaleProcessor(mContext);
			}
		}
		return instance;
	}

	private SaleProcessor(Context mContext) {
		super(mContext, SaleData.COL_NAMES, SaleConst.CONTENT_URI);
	}

	public void getSales(ProcessorCallback callback, String channelId) {
		GetSalesMethod method = new GetSalesMethod(mContext, channelId);
		this.execMethodWithCallback(method, callback);
	}

	public RestMethodResult<JSONObjResource> publishSale(SaleEntity sale) {
		return (RestMethodResult) this
				.execMethod(new PostSaleMethod(mContext, sale));
	}
}
