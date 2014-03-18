package com.seekon.yougouhui.func.module;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TYPE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import android.content.Context;

import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class ModuleProcessor extends ContentProcessor{
	
	public ModuleProcessor(Context mContext) {
		super(mContext, new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME,
				 COL_NAME_TYPE }, ModuleConst.CONTENT_URI);
	}

	public void getModules(ProcessorCallback callback, String type) {
		GetModulesMethod method = new GetModulesMethod(mContext, type);
		this.execMethodWithCallback(method, callback);
	}

}
