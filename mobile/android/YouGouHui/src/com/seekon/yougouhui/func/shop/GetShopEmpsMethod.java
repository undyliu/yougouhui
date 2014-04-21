package com.seekon.yougouhui.func.shop;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetShopEmpsMethod extends JSONArrayResourceMethod {

	private static final String GET_SHOP_EMPS_URI = Const.SERVER_APP_URL
			+ "/getShopEmps/";

	private String shopId;

	public GetShopEmpsMethod(Context context, String shopId) {
		super(context);
		this.shopId = shopId;
	}

	@Override
	protected Request buildRequest() {
		return new BaseRequest(Method.GET, URI.create(GET_SHOP_EMPS_URI + shopId),
				null, null);
	}

}
