package com.seekon.yougouhui.func.module;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetModulesMethod extends JSONArrayResourceMethod {

	private static final String GET_MODULES_URI = Const.SERVER_APP_URL
			+ "/getModules";

	private String type;

	public GetModulesMethod(Context context, String type) {
		super(context);
		this.type = type;
	}

	@Override
	protected Request buildRequest() {
		URI uri = null;
		if (type != null) {
			uri = URI.create(GET_MODULES_URI + "/" + type);
		} else {
			uri = URI.create(GET_MODULES_URI);
		}

		return new BaseRequest(Method.GET, uri, null, null);
	}

}
