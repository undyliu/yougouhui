package com.seekon.yougouhui.rest;

import android.content.Context;

import com.seekon.yougouhui.rest.resource.Resource;

public abstract class MultipartRestMethod<T extends Resource> extends
		AbstractRestMethod<T> {

	protected Context context;

	public MultipartRestMethod(Context context) {
		super();
		this.context = context;
	}

	@Override
	protected Context getContext() {
		return context;
	}

	@Override
	protected Response doRequest(Request request) {
		RestClient client = new MultipartClient();
		return client.execute(request);
	}

}
