package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IMessageProcessor {

	public RestMethodResult<JSONObjResource> sendMessage(UserEntity sender,
			UserEntity receiver, String content);
}
