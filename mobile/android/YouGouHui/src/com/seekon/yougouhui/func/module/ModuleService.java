package com.seekon.yougouhui.func.module;

import android.content.Intent;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.service.AbstractService;
import com.seekon.yougouhui.service.ServiceConst;

public class ModuleService extends AbstractService {

	public ModuleService() {
		super("ModuleService");
	}

	@Override
	protected void handlerIntent(Intent requestIntent) {
		String method = requestIntent.getStringExtra(ServiceConst.METHOD_EXTRA);
		String type = requestIntent.getStringExtra(DataConst.COL_NAME_TYPE);

		if (method.equalsIgnoreCase(ServiceConst.METHOD_GET)) {
			ModuleProcessor processor = new ModuleProcessor(getApplicationContext());
			processor.getModules(makeProcessorCallback(), type);
		} else {
			mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
		}

	}

}
