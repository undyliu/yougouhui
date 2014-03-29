package com.seekon.yougouhui.func.discover.share;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.ResultReceiver;

import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.service.ServiceConst;

public class ShareServiceHelper extends RequestServiceHelper {

	public static String SHARE_GET_REQUEST_RESULT = "SHARE_GET_REQUEST_RESULT";

	private static final String HASH_KEY_SHARE = "SHARE";

	private static ShareServiceHelper instance = null;

	private static Object lock = new Object();

	protected ShareServiceHelper(Context context) {
		super(context);
	}

	public static ShareServiceHelper getInstance(Context context) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ShareServiceHelper(context);
			}
		}
		return instance;
	}

	public long getShares(String lastPublishTime, String minPublishTime,
			String lastCommentPubTime, final String broadcastIntentAction) {
		final String requestKey = HASH_KEY_SHARE;
		if (requests.containsKey(requestKey)) {
			return requests.get(requestKey);
		}

		long requestId = this.generateRequestID();
		requests.put(requestKey, requestId);

		ResultReceiver serviceCallback = new ResultReceiver(null) {
			@Override
			protected void onReceiveResult(int resultCode, Bundle resultData) {
				handleResponse(resultCode, resultData, broadcastIntentAction,
						requestKey);
			}
		};

		Intent intent = new Intent(this.context, ShareService.class);
		intent.putExtra(ServiceConst.METHOD_EXTRA, ServiceConst.METHOD_GET);
		intent.putExtra(ServiceConst.SERVICE_CALLBACK, serviceCallback);
		intent.putExtra(REQUEST_ID, requestId);
		intent.putExtra(ShareConst.LAST_PUBLISH_TIME, lastPublishTime);
		intent.putExtra(ShareConst.MIN_PUBLISH_TIME, minPublishTime);
		intent.putExtra(ShareConst.LAST_COMMENT_PUB_TIME, lastCommentPubTime);
		
		this.context.startService(intent);

		return requestId;
	}
}
