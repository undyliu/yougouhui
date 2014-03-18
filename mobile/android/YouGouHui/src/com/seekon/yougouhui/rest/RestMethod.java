package com.seekon.yougouhui.rest;

import com.seekon.yougouhui.rest.resource.Resource;

public interface RestMethod<T extends Resource>{

	public RestMethodResult<T> execute();
}
