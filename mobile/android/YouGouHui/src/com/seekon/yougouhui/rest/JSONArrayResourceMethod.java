package com.seekon.yougouhui.rest;

import android.content.Context;

import com.seekon.yougouhui.rest.resource.JSONArrayResource;

public abstract class JSONArrayResourceMethod extends
		BaseRestMethod<JSONArrayResource> {

	protected Context context;

	public JSONArrayResourceMethod(Context context) {
		super();
		this.context = context.getApplicationContext();
	}

	@Override
	protected Context getContext() {
		return this.context;
	}

	@Override
	protected JSONArrayResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONArrayResource(responseBody);
	}
}
