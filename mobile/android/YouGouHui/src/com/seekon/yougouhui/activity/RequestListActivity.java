package com.seekon.yougouhui.activity;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;

import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.util.Logger;

public abstract class RequestListActivity extends Activity {

	protected static final String TAG = RequestListActivity.class.getSimpleName();

	protected Long requestId;

	protected BroadcastReceiver requestReceiver;

	protected String requestResultType;

	protected boolean updated = false;

	public RequestListActivity(String requestResultType) {
		super();
		this.requestResultType = requestResultType;
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		requestReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context context, Intent intent) {
				Logger.debug(TAG, intent);
				long resultRequestId = intent.getLongExtra(
						RequestServiceHelper.EXTRA_REQUEST_ID, 0);
				if (resultRequestId == requestId) {
					int resultCode = intent.getIntExtra(
							RequestServiceHelper.EXTRA_RESULT_CODE, 0);
					if (resultCode == 200) {
						updateListItemByRemoteCall();
					} else {
						// showToast(getString(R.string.error_occurred));
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};

	}

	@Override
	public void onResume() {
		super.onResume();
		registerReceiver(requestReceiver, new IntentFilter(requestResultType));
	}

	@Override
	public void onPause() {
		super.onPause();
		if (requestReceiver != null) {
			unregisterReceiver(requestReceiver);
		}
	}

	protected abstract void initRequestId();

	protected abstract void updateListItemByRemoteCall();
}
