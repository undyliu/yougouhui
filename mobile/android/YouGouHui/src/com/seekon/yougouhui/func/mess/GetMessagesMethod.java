package com.seekon.yougouhui.func.mess;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetMessagesMethod extends JSONArrayResourceMethod {

	private static final String GET_MESSAGES_URI = Const.SERVER_APP_URL
			+ "/getActivities";

	private String channelId;

	public GetMessagesMethod(Context context, String channelId) {
		super(context);
		this.channelId = channelId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = null;
		if (channelId != null) {
			uri = URI.create(GET_MESSAGES_URI + "/" + channelId);
		} else {
			uri = URI.create(GET_MESSAGES_URI);
		}

		return new Request(Method.GET, uri, null, null);
	}

}
