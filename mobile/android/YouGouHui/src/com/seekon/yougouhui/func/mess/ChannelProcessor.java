package com.seekon.yougouhui.func.mess;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_PARENT_ID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import android.content.Context;

import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class ChannelProcessor extends ContentProcessor{

	public ChannelProcessor(Context mContext) {
		super(mContext, new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME,
									// COL_NAME_ORD_INDEX,
									COL_NAME_PARENT_ID }, ChannelConst.CONTENT_URI);
	}

	public void getChannels(ProcessorCallback callback, String parentId) {
		GetChannelsMethod method = new GetChannelsMethod(mContext, parentId);
		this.execMethodWithCallback(method, callback);
	}

}
