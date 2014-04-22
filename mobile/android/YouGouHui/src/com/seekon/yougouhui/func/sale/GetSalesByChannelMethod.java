package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetSalesByChannelMethod extends JSONObjResourceMethod {

	private static final String GET_SALES_URI = Const.SERVER_APP_URL
			+ "/getSalesByChannel/";

	private String channelId;

	private String updateTime;
	
	public GetSalesByChannelMethod(Context context, String channelId,
			String updateTime) {
		super(context);
		this.channelId = channelId;
		this.updateTime = updateTime;
	}
	
	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_SALES_URI + channelId + "/" + updateTime);
		return new BaseRequest(Method.GET, uri, null, null);
	}

}
