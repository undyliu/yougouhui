package com.seekon.yougouhui.rest;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
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
		RestMethodResult<JSONArrayResource> result = super.buildResult(response);
		if (result.getStatusCode() == RestStatus.SC_OK) {
			JSONArrayResource resource = result.getResource();
			for (int i = 0; i < resource.length(); i++) {
				Object obj = resource.get(i);
				if (obj instanceof JSONObject) {
					JSONObject jsonObj = (JSONObject) obj;
					if (jsonObj.has(DataConst.NAME_ERROR)) {
						String errorMsg = jsonObj.getString(DataConst.NAME_ERROR);
						if (errorMsg != null) {
							String statusMsg = result.getStatusMsg();
							if (statusMsg == null || statusMsg.length() == 0) {
								statusMsg = errorMsg;
							}
							result = new RestMethodResult<JSONArrayResource>(
									RestStatus.SERVER_REMOTE_ERROR, statusMsg,
									result.getResource());
							RunEnv.getInstance().setSessionId(null);//todo: why?
							break;
						}
					}
				}
			}
		}
		return result;
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
