package com.seekon.yougouhui.func.mess;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TITLE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_CHANNEL_ID;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_DISCOUNT;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_PRICE;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_VISIT_COUNT;
import android.content.Context;

import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class MessageProcessor extends ContentProcessor {

	public MessageProcessor(Context mContext) {
		super(mContext, new String[] { COL_NAME_UUID, COL_NAME_TITLE,
				COL_NAME_CONTENT, COL_NAME_IMG, COL_NAME_CHANNEL_ID, COL_NAME_DISCOUNT,
				COL_NAME_PRICE, COL_NAME_DISCOUNT, COL_NAME_VISIT_COUNT },
				MessageConst.CONTENT_URI);
	}

	public void getMessages(ProcessorCallback callback, String channelId) {
		GetMessagesMethod method = new GetMessagesMethod(mContext, channelId);
		this.execMethodWithCallback(method, callback);
	}
}
