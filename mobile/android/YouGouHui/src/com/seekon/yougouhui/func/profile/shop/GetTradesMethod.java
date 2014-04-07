package com.seekon.yougouhui.func.profile.shop;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetTradesMethod extends JSONArrayResourceMethod {

	private static final URI GET_TRADES_URI = URI.create(Const.SERVER_APP_URL
			+ "/getTrades");

	public GetTradesMethod(Context context) {
		super(context);
	}

	@Override
	protected Request buildRequest() {
		return new BaseRequest(Method.GET, GET_TRADES_URI, null, null);
	}

}
