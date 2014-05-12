package com.seekon.yougouhui.func.message;

import android.content.Context;

import com.seekon.yougouhui.func.spi.IMessageProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;

public class MessageProcessor extends ContentProcessor implements
		IMessageProcessor {

	private static IMessageProcessor instance = null;
	private static Object lock = new Object();

	public static IMessageProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IMessageProcessor) proxy
						.bind(new MessageProcessor(mContext));
			}
		}
		return instance;
	}

	private MessageProcessor(Context mContext) {
		super(mContext, MessageData.COL_NAMES, MessageConst.CONTENT_URI);
	}

	@Override
	public RestMethodResult<JSONObjResource> sendMessage(UserEntity sender,
			UserEntity receiver, String content) {
		return (RestMethodResult) this.execMethod(new SendMessageMethod(mContext,
				sender, receiver, content));
	}
}
