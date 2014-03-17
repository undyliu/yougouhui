package com.seekon.yougouhui.activity;

import android.app.ListActivity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.util.Logger;

public abstract class RequestListActivity extends ListActivity {

	protected static final String TAG = RequestListActivity.class.getSimpleName();
	
	protected Long requestId;

	protected BroadcastReceiver requestReceiver;

	protected String requestResultType;

	public RequestListActivity(String requestResultType) {
		super();
		this.requestResultType = requestResultType;
	}

	@Override
	protected void onResume() {
		super.onResume();

		IntentFilter filter = new IntentFilter(requestResultType);
		requestReceiver = new BroadcastReceiver() {

			@Override
			public void onReceive(Context context, Intent intent) {
				long resultRequestId = intent.getLongExtra(
						RequestServiceHelper.EXTRA_REQUEST_ID, 0);
				if (resultRequestId == requestId) {
					int resultCode = intent.getIntExtra(
							RequestServiceHelper.EXTRA_RESULT_CODE, 0);
					if (resultCode == 200) {
						updateListItems();
					} else {
						// showToast(getString(R.string.error_occurred));
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};
		this.registerReceiver(requestReceiver, filter);

		if (requestId == null) {
			initRequestId();
		}
	}

	@Override
	protected void onPause() {
		super.onPause();
		this.unregisterReceiver(requestReceiver);
	}
	
	protected abstract void initRequestId();
	
	protected abstract void updateListItems();

}
