package com.seekon.yougouhui.func.module;

import android.content.Context;

import com.seekon.yougouhui.func.spi.IModuleProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;

public class ModuleProcessor extends ContentProcessor implements
		IModuleProcessor {

	private static IModuleProcessor instance = null;
	private static Object lock = new Object();

	public static IModuleProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IModuleProcessor) proxy.bind(new ModuleProcessor(mContext));
			}
		}
		return instance;
	}

	private ModuleProcessor(Context mContext) {
		super(mContext, ModuleData.COL_NAMES, ModuleConst.CONTENT_URI);
	}

	@Override
	public RestMethodResult<JSONArrayResource> getModules(String type) {
		return (RestMethodResult)this.execMethod(new GetModulesMethod(mContext, type));
	}

}
