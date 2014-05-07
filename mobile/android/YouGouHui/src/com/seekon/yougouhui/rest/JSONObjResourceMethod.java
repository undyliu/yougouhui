package com.seekon.yougouhui.rest;

import android.content.Context;

import com.seekon.yougouhui.rest.resource.JSONObjResource;

public abstract class JSONObjResourceMethod extends
		BaseRestMethod<JSONObjResource> {

	protected Context context;

	public JSONObjResourceMethod(Context context) {
		super();
		this.context = context.getApplicationContext();
	}

	@Override
	protected Context getContext() {
		return this.context;
	}

	@Override
	protected RestMethodResult<JSONObjResource> buildResult(Response response)
			throws Exception {
		return RestUtils.processResultErrorMessage(super.buildResult(response));
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(responseBody);
	}
}
