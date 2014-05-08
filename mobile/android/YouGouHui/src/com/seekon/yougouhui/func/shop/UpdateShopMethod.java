package com.seekon.yougouhui.func.shop;

import android.content.Context;

import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class UpdateShopMethod extends JSONObjResourceMethod {

	private ShopEntity shop;
	private String fieldName;

	public UpdateShopMethod(Context context, ShopEntity shop, String fieldName) {
		super(context);
		this.shop = shop;
		this.fieldName = fieldName;
	}

	@Override
	protected Request buildRequest() {
		return UpdateShopRequestFactory.getRequest(shop, fieldName);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(ShopUtils.toJson(shop).toString());
	}

}
