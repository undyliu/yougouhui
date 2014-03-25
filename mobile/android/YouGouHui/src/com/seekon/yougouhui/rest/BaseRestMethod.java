package com.seekon.yougouhui.rest;

import com.seekon.yougouhui.rest.resource.Resource;

public abstract class BaseRestMethod<T extends Resource> extends
		AbstractRestMethod<T> {

	@Override
	protected Response doRequest(Request request) {
		RestClient client = new BaseRestClient();
		return client.execute(request);
	}

}
