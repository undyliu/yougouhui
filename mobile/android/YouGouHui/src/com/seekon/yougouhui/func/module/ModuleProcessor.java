package com.seekon.yougouhui.func.module;

import android.content.Context;

import com.seekon.yougouhui.func.spi.IModuleProcessor;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;
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

	public void getModules(ProcessorCallback callback, String type) {
		GetModulesMethod method = new GetModulesMethod(mContext, type);
		this.execMethodWithCallback(method, callback);
	}

}
