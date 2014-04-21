package com.seekon.yougouhui.func.shop;

import android.content.Context;

import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;

public abstract class GetTradesTaskCallback extends
		AbstractRestTaskCallback<JSONArrayResource> {

	private Context context;

	public GetTradesTaskCallback(Context context) {
		super("获取主营业务数据失败.");
		this.context = context;
	}

	@Override
	public RestMethodResult<JSONArrayResource> doInBackground() {
		return TradeProcessor.getInstance(context).getTrades();
	}

	@Override
	public void onCancelled() {

	}
}
