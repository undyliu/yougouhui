package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetSalesByChannelMethod extends JSONArrayResourceMethod {

	private static final String GET_SALES_URI = Const.SERVER_APP_URL
			+ "/getSalesByChannel";

	private String channelId;

	public GetSalesByChannelMethod(Context context, String channelId) {
		super(context);
		this.channelId = channelId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = null;
		if (channelId != null) {
			uri = URI.create(GET_SALES_URI + "/" + channelId);
		} else {
			uri = URI.create(GET_SALES_URI);
		}

		return new BaseRequest(Method.GET, uri, null, null);
	}

}
