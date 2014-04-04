package com.seekon.yougouhui.func.mess;

import android.content.Context;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class ChannelProcessor extends ContentProcessor {

	private static ChannelProcessor instance = null;
	private static Object lock = new Object();

	public static ChannelProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ChannelProcessor(mContext);
			}
		}
		return instance;
	}

	private ChannelProcessor(Context mContext) {
		super(mContext, ChannelData.COL_NAMES, ChannelConst.CONTENT_URI);
	}

	public void getChannels(ProcessorCallback callback, String parentId) {
		GetChannelsMethod method = new GetChannelsMethod(mContext, parentId);
		this.execMethodWithCallback(method, callback);
	}

	public RestMethodResult<JSONArrayResource> getChannels( String parentId){
		return (RestMethodResult)this.execMethod(new GetChannelsMethod(mContext, parentId));
	}
}
