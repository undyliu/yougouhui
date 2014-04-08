package com.seekon.yougouhui.func.profile.shop;

import android.content.Context;

import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ChangeShopMethod extends MultipartRestMethod<JSONObjResource> {

	private ShopEntity shop;
	private String fieldName;

	public ChangeShopMethod(Context context, ShopEntity shop, String fieldName) {
		super(context);
		this.shop = shop;
		this.fieldName = fieldName;
	}

	@Override
	protected Request buildRequest() {
		return ChangeShopRequestFactory.getRequest(shop, fieldName);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(ShopUtils.toJson(shop).toString());
	}

}
