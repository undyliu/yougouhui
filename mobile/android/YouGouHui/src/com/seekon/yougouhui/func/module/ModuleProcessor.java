package com.seekon.yougouhui.func.module;

import android.content.Context;

import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class ModuleProcessor extends ContentProcessor {

	public ModuleProcessor(Context mContext) {
		super(mContext, ModuleData.COL_NAMES, ModuleConst.CONTENT_URI);
	}

	public void getModules(ProcessorCallback callback, String type) {
		GetModulesMethod method = new GetModulesMethod(mContext, type);
		this.execMethodWithCallback(method, callback);
	}

}
