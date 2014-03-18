package com.seekon.yougouhui.func.mess;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

/**
 * 获取栏目信息的rest访问
 * 
 * @author undyliu
 * 
 */
public class GetChannelsMethod extends JSONArrayResourceMethod {

	private static final String GET_CHANNELS_URI = Const.SERVER_APP_URL
			+ "/getActiveChannels";

	private String pChannelId;

	public GetChannelsMethod(Context context, String pChannelId) {
		super(context);
		this.pChannelId = pChannelId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = null;
		if (pChannelId != null) {
			uri = URI.create(GET_CHANNELS_URI + "/" + pChannelId);
		} else {
			uri = URI.create(GET_CHANNELS_URI);
		}

		return new Request(Method.GET, uri, null, null);
	}

}
