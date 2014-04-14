package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetSalesByShopMethod extends JSONArrayResourceMethod {

	private static final String GET_SALES_URI = Const.SERVER_APP_URL
			+ "/getSalesByShop";

	private String shopId;

	public GetSalesByShopMethod(Context context, String shopId) {
		super(context);
		this.shopId = shopId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = null;
		if (shopId != null) {
			uri = URI.create(GET_SALES_URI + "/" + shopId);
		} else {
			uri = URI.create(GET_SALES_URI);
		}

		return new BaseRequest(Method.GET, uri, null, null);
	}
}
