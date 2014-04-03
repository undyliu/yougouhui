package com.seekon.yougouhui.func.mess;

import android.content.Intent;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.service.AbstractService;
import com.seekon.yougouhui.service.ServiceConst;

public class MessageService extends AbstractService {

	public static final int RESOURCE_TYPE_CHANNEL = 1;

	public static final int RESOURCE_TYPE_MESSAGE = 2;

	public MessageService() {
		super("MessageService");
	}

	@Override
	protected void handlerIntent(Intent requestIntent) {
		String method = requestIntent.getStringExtra(ServiceConst.METHOD_EXTRA);
		int resourceType = requestIntent.getIntExtra(
				ServiceConst.RESOURCE_TYPE_EXTRA, -1);

		switch (resourceType) {
		case RESOURCE_TYPE_CHANNEL:
			if (method.equalsIgnoreCase(ServiceConst.METHOD_GET)) {
				String parentId = requestIntent
						.getStringExtra(DataConst.COL_NAME_PARENT_ID);
				ChannelProcessor processor = ChannelProcessor
						.getInstance(getApplicationContext());
				processor.getChannels(makeProcessorCallback(), parentId);
			} else {
				mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
			}
			break;
		case RESOURCE_TYPE_MESSAGE:
			if (method.equalsIgnoreCase(ServiceConst.METHOD_GET)) {
				String channelId = requestIntent
						.getStringExtra(MessageConst.COL_NAME_CHANNEL_ID);
				MessageProcessor processor = MessageProcessor
						.getInstance(getApplicationContext());
				processor.getMessages(makeProcessorCallback(), channelId);
			} else {
				mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
			}
			break;
		default:
			mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
			break;
		}
	}

}
