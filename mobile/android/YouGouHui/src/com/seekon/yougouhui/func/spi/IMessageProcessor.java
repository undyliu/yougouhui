package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IMessageProcessor {

	public RestMethodResult<JSONObjResource> sendMessage(UserEntity sender,
			UserEntity receiver, String content);
	
	/**
	 * 获取最新的消息记录
	 * @param receiver
	 * @param updateTime
	 * @return
	 */
	public RestMethodResult<JSONObjResource> getMessages(UserEntity receiver, String updateTime);
}
