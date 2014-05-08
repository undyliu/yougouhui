package com.seekon.yougouhui.rest;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.Logger;

public abstract class JSONArrayResourceMethod extends
		BaseRestMethod<JSONArrayResource> {
	private final static String TAG = JSONArrayResourceMethod.class
			.getSimpleName();
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
	protected RestMethodResult<JSONArrayResource> buildResult(Response response)
			throws Exception {
		return RestUtils.processResultErrorMessage(super.buildResult(response));
	}

	@Override
	protected JSONArrayResource parseResponseBody(String responseBody)
			throws Exception {
		JSONArrayResource resource = null;
		try {
			resource = new JSONArrayResource(responseBody);
		} catch (JSONException e) {
			Logger.warn(TAG, e.getMessage());
			try {
				JSONObject jsonObj = new JSONObject(responseBody);
				resource = new JSONArrayResource();
				resource.put(jsonObj);
			} catch (JSONException ee) {
				Logger.warn(TAG, ee.getMessage());
				throw e;
			}
		}

		return resource;
	}
}
