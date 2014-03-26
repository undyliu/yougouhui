package com.seekon.yougouhui.func.module;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.ResultReceiver;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.service.ServiceConst;

public class ModuleServiceHelper extends RequestServiceHelper {

	public static String DISCOVER_REQUEST_RESULT = "DISCOVER_REQUEST_RESULT";

	public static String PROFILE_REQUEST_RESULT = "PROFILE_REQUEST_RESULT";

	private static final String HASH_KEY_MODULE = "MODULE";

	private static ModuleServiceHelper instance = null;

	private static Object lock = new Object();

	protected ModuleServiceHelper(Context context) {
		super(context);
	}

	public static ModuleServiceHelper getInstance(Context context) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ModuleServiceHelper(context);
			}
		}
		return instance;
	}

	public long getModules(String moduleType, final String broadcastIntentAction) {
		if (requests.containsKey(HASH_KEY_MODULE)) {
			return requests.get(HASH_KEY_MODULE);
		}

		long requestId = this.generateRequestID();
		requests.put(HASH_KEY_MODULE, requestId);

		ResultReceiver serviceCallback = new ResultReceiver(null) {
			@Override
			protected void onReceiveResult(int resultCode, Bundle resultData) {
				handleResponse(resultCode, resultData, broadcastIntentAction,
						HASH_KEY_MODULE);
			}
		};

		Intent intent = new Intent(this.context, ModuleService.class);
		intent.putExtra(ServiceConst.METHOD_EXTRA, ServiceConst.METHOD_GET);
		intent.putExtra(ServiceConst.SERVICE_CALLBACK, serviceCallback);
		intent.putExtra(REQUEST_ID, requestId);
		intent.putExtra(DataConst.COL_NAME_TYPE, moduleType);

		this.context.startService(intent);

		return requestId;
	}

}
