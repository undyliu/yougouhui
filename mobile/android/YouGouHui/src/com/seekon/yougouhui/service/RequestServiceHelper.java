package com.seekon.yougouhui.service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

public abstract class RequestServiceHelper {

	public static String EXTRA_REQUEST_ID = "EXTRA_REQUEST_ID";
	public static String EXTRA_RESULT_CODE = "EXTRA_RESULT_CODE";

	protected static final String REQUEST_ID = "REQUEST_ID";

	protected Map<String, Long> requests = new HashMap<String, Long>();

	protected Context context;

	protected RequestServiceHelper(Context context) {
		super();
		this.context = context.getApplicationContext();
	}

	protected long generateRequestID() {
		long requestId = UUID.randomUUID().getLeastSignificantBits();
		return requestId;
	}

	protected void handleResponse(int resultCode, Bundle resultData,
			String broadcastIntentAction, String requestKey) {
		Intent origIntent = (Intent) resultData
				.getParcelable(ServiceConst.ORIGINAL_INTENT_EXTRA);
		if (origIntent != null) {
			long requestId = origIntent.getLongExtra(REQUEST_ID, 0);

			requests.remove(requestKey);
			Intent resultBroadcast = new Intent(broadcastIntentAction);
			resultBroadcast.putExtra(EXTRA_REQUEST_ID, requestId);
			resultBroadcast.putExtra(EXTRA_RESULT_CODE, resultCode);

			context.sendBroadcast(resultBroadcast);
		}
	}
}
