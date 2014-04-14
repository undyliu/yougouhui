package com.seekon.yougouhui.func.profile.shop;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetShopMethod extends JSONObjResourceMethod {

	private static final String GET_SHOP_URI = Const.SERVER_APP_URL + "/getShop/";

	private String shopId;

	public GetShopMethod(Context context, String shopId) {
		super(context);
		this.shopId = shopId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_SHOP_URI + shopId);
		return new BaseRequest(Method.GET, uri, null, null);
	}

}
