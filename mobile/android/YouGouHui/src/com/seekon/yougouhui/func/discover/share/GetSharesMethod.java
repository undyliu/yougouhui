package com.seekon.yougouhui.func.discover.share;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetSharesMethod extends JSONArrayResourceMethod {

	private static final String GET_FRIEND_SHARES_URI = Const.SERVER_APP_URL
			+ "/getFriendShares";

	private String lastPublishTime;
	
	public GetSharesMethod(Context context, String lastPublishTime) {
		super(context);
		this.lastPublishTime = lastPublishTime;
		if(this.lastPublishTime == null || this.lastPublishTime.length() == 0){
			this.lastPublishTime = "-1";
		}
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_FRIEND_SHARES_URI + "/" + lastPublishTime);
		return new BaseRequest(Method.GET, uri, null, null);
	}

}
