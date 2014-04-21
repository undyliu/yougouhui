package com.seekon.yougouhui.func.setting;

import android.content.Context;

import com.seekon.yougouhui.func.spi.ISettingProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;

public class SettingProcessor extends ContentProcessor implements
		ISettingProcessor {

	private static ISettingProcessor instance = null;
	private static Object lock = new Object();

	public static ISettingProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (ISettingProcessor) proxy
						.bind(new SettingProcessor(mContext));
			}
		}
		return instance;
	}

	private SettingProcessor(Context mContext) {
		super(mContext, SettingData.COL_NAMES, SettingConst.CONTENT_URI);
	}

	@Override
	public RestMethodResult<JSONArrayResource> getSettings() {
		return (RestMethodResult)this.execMethod(new GetSettingsMethod(mContext));
	}

}
