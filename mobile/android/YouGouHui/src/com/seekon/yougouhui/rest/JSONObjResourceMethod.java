package com.seekon.yougouhui.rest;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
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
		RestMethodResult<JSONObjResource> result = super.buildResult(response);
		if (result.getStatusCode() == RestStatus.SC_OK) {
			JSONObjResource resource = result.getResource();
			if (resource.has(DataConst.NAME_ERROR)) {
				String errorMsg = resource.getString(DataConst.NAME_ERROR);
				if (errorMsg != null) {
					String statusMsg = result.getStatusMsg();
					if (statusMsg == null || statusMsg.length() == 0) {
						statusMsg = errorMsg;
					}
					result = new RestMethodResult<JSONObjResource>(
							RestStatus.SERVER_REMOTE_ERROR, statusMsg, result.getResource());
				}
			}
		}
		return result;
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(responseBody);
	}
}
