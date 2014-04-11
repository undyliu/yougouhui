package com.seekon.yougouhui.func.sale;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.ResultReceiver;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.service.ServiceConst;

public class SaleServiceHelper extends RequestServiceHelper {

	public static String CHANNEL_REQUEST_RESULT = "CHANNEL_REQUEST_RESULT";

	public static String SUBCHANNEL_REQUEST_RESULT = "SUBCHANNEL_REQUEST_RESULT";

	public static String SALE_REQUEST_RESULT = "SALE_REQUEST_RESULT";

	private static final String HASH_KEY_CHANNEL = "CHANNEL";

	private static final String HASH_KEY_SALE = "SALE";

	private static SaleServiceHelper instance = null;

	private static Object lock = new Object();

	private SaleServiceHelper(Context context) {
		super(context);
	}

	public static SaleServiceHelper getInstance(Context context) {
		synchronized (lock) {
			if (instance == null) {
				instance = new SaleServiceHelper(context);
			}
		}
		return instance;
	}

	public long getChannels(String parentId, final String broadcastIntentAction) {
		if (requests.containsKey(HASH_KEY_CHANNEL)) {
			return requests.get(HASH_KEY_CHANNEL);
		}

		long requestId = this.generateRequestID();
		requests.put(HASH_KEY_CHANNEL, requestId);

		ResultReceiver serviceCallback = new ResultReceiver(null) {
			@Override
			protected void onReceiveResult(int resultCode, Bundle resultData) {
				handleResponse(resultCode, resultData, broadcastIntentAction,
						HASH_KEY_CHANNEL);
			}
		};

		Intent intent = new Intent(this.context, SaleService.class);
		intent.putExtra(ServiceConst.METHOD_EXTRA, ServiceConst.METHOD_GET);
		intent.putExtra(ServiceConst.RESOURCE_TYPE_EXTRA,
				SaleService.RESOURCE_TYPE_CHANNEL);
		intent.putExtra(ServiceConst.SERVICE_CALLBACK, serviceCallback);
		intent.putExtra(REQUEST_ID, requestId);
		intent.putExtra(DataConst.COL_NAME_PARENT_ID, parentId);

		this.context.startService(intent);

		return requestId;
	}

	public long getMessages(String channelId, final String broadcastIntentAction) {
		if (requests.containsKey(HASH_KEY_SALE)) {
			return requests.get(HASH_KEY_SALE);
		}

		long requestId = this.generateRequestID();
		requests.put(HASH_KEY_SALE, requestId);

		ResultReceiver serviceCallback = new ResultReceiver(null) {
			@Override
			protected void onReceiveResult(int resultCode, Bundle resultData) {
				handleResponse(resultCode, resultData, broadcastIntentAction,
						HASH_KEY_SALE);
			}
		};

		Intent intent = new Intent(this.context, SaleService.class);
		intent.putExtra(ServiceConst.METHOD_EXTRA, ServiceConst.METHOD_GET);
		intent.putExtra(ServiceConst.RESOURCE_TYPE_EXTRA,
				SaleService.RESOURCE_TYPE_SALE);
		intent.putExtra(ServiceConst.SERVICE_CALLBACK, serviceCallback);
		intent.putExtra(REQUEST_ID, requestId);
		intent.putExtra(SaleConst.COL_NAME_CHANNEL_ID, channelId);

		this.context.startService(intent);

		return requestId;
	}
}
