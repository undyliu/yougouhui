package com.seekon.yougouhui.func.user;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class GetUserProfileMethod extends JSONObjResourceMethod {

	private static final String GET_USER_PROFILE_URI = Const.SERVER_APP_URL
			+ "/getUserProfile/";

	private UserEntity user;

	public GetUserProfileMethod(Context context, UserEntity user) {
		super(context);
		this.user = user;
	}

	@Override
	protected Request buildRequest() {
		return new BaseRequest(Method.GET, GET_USER_PROFILE_URI + user.getUuid(), null,
				null);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		return resource;
	}
}
