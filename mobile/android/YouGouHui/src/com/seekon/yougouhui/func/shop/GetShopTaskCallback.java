package com.seekon.yougouhui.func.shop;

import android.content.Context;

import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public abstract class GetShopTaskCallback extends
		AbstractRestTaskCallback<JSONObjResource> {

	private Context context;
	private String shopId;

	public GetShopTaskCallback(Context context, String shopId) {
		super("获取商铺信息失败.");
		this.context = context;
		this.shopId = shopId;
	}

	@Override
	public RestMethodResult<JSONObjResource> doInBackground() {
		return ShopProcessor.getInstance(context).getShop(shopId);
	}

	@Override
	public void onCancelled() {

	}
}
