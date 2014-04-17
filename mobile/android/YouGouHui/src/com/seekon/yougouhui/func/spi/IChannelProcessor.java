package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.service.ProcessorCallback;

public interface IChannelProcessor {

	public void getChannels(ProcessorCallback callback, String parentId);
	
	public RestMethodResult<JSONArrayResource> getChannels(String parentId);
}
