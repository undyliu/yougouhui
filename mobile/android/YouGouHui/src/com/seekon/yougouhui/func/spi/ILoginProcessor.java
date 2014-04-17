package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface ILoginProcessor {
	public RestMethodResult<JSONObjResource> login(String phone, String pwd);
}
