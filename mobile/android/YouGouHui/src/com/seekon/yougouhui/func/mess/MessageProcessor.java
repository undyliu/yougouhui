package com.seekon.yougouhui.func.mess;

import android.content.Context;

import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class MessageProcessor extends ContentProcessor {

	public MessageProcessor(Context mContext) {
		super(mContext, MessageData.COL_NAMES, MessageConst.CONTENT_URI);
	}

	public void getMessages(ProcessorCallback callback, String channelId) {
		GetMessagesMethod method = new GetMessagesMethod(mContext, channelId);
		this.execMethodWithCallback(method, callback);
	}
}
