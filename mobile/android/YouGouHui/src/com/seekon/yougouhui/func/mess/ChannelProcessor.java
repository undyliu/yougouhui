package com.seekon.yougouhui.func.mess;

import android.content.Context;

import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class ChannelProcessor extends ContentProcessor {

	public ChannelProcessor(Context mContext) {
		super(mContext, ChannelData.COL_NAMES, ChannelConst.CONTENT_URI);
	}

	public void getChannels(ProcessorCallback callback, String parentId) {
		GetChannelsMethod method = new GetChannelsMethod(mContext, parentId);
		this.execMethodWithCallback(method, callback);
	}

}
