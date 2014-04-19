package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;

public interface IModuleProcessor {

	public RestMethodResult<JSONArrayResource> getModules(String type);
}
