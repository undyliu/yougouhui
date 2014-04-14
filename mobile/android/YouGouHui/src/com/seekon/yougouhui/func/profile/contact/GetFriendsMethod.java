package com.seekon.yougouhui.func.profile.contact;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetFriendsMethod extends JSONArrayResourceMethod {

	private static final String GET_FRIENDS_URI = Const.SERVER_APP_URL
			+ "/getFriends/";

	private String userId;

	public GetFriendsMethod(Context context, String userId) {
		super(context);
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_FRIENDS_URI + userId);
		return new BaseRequest(Method.GET, uri, null, null);
	}

}
