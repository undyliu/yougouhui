package com.seekon.yougouhui.func.module;

import android.content.Context;

import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class ModuleProcessor extends ContentProcessor {

	private static ModuleProcessor instance = null;
	private static Object lock = new Object();

	public static ModuleProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ModuleProcessor(mContext);
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
