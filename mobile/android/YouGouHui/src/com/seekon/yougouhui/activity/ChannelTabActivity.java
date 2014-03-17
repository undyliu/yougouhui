package com.seekon.yougouhui.activity;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_PARENT_ID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.LinkedList;
import java.util.List;

import android.app.ActivityGroup;
import android.content.BroadcastReceiver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.Cursor;
import android.os.Bundle;
import android.widget.TabHost;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.mess.ChannelConst;
import com.seekon.yougouhui.func.mess.MessageServiceHelper;
import com.seekon.yougouhui.util.Logger;

@SuppressWarnings("deprecation")
public class ChannelTabActivity extends ActivityGroup {

	private static final String TAG = ChannelTabActivity.class.getSimpleName();

	private Long requestId;

	private BroadcastReceiver requestReceiver;

	private MessageServiceHelper mActivityServiceHelper;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.channel_tab);

	}

	@Override
	protected void onResume() {
		super.onResume();

		IntentFilter filter = new IntentFilter(
				MessageServiceHelper.CHANNEL_REQUEST_RESULT);
		requestReceiver = new BroadcastReceiver() {

			@Override
			public void onReceive(Context context, Intent intent) {

				long resultRequestId = intent.getLongExtra(
						MessageServiceHelper.EXTRA_REQUEST_ID, 0);

				Logger.debug(TAG, "Received intent " + intent.getAction()
						+ ", request ID " + resultRequestId);

				if (resultRequestId == requestId) {

					Logger.debug(TAG, "Result is for our request ID");

					// setRefreshing(false);

					int resultCode = intent.getIntExtra(
							MessageServiceHelper.EXTRA_RESULT_CODE, 0);

					Logger.debug(TAG, "Result code = " + resultCode);

					if (resultCode == 200) {

						Logger.debug(TAG, "Updating UI with new data");

						// String name = getNameFromContentProvider();
						// showNameToast(name);
						updateTabs(getChannelsFromContentProvider());

					} else {
						// showToast(getString(R.string.error_occurred));
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};

		mActivityServiceHelper = MessageServiceHelper.getInstance(this);
		this.registerReceiver(requestReceiver, filter);

		if (requestId == null) {
			requestId = mActivityServiceHelper.getChannels(null,
					MessageServiceHelper.CHANNEL_REQUEST_RESULT);
		}
	}

	@Override
	protected void onPause() {
		super.onPause();
		this.unregisterReceiver(requestReceiver);
	}
	
	private List<ContentValues> getChannelsFromContentProvider() {
		List<ContentValues> channels = new LinkedList<ContentValues>();
		Cursor cursor = getContentResolver().query(ChannelConst.CONTENT_URI,
				new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME },
				COL_NAME_PARENT_ID + " is null ", null, COL_NAME_ORD_INDEX);
		while (cursor.moveToNext()) {
			ContentValues values = new ContentValues();
			values.put(COL_NAME_UUID, cursor.getInt(0));
			values.put(COL_NAME_CODE, cursor.getString(1));
			values.put(COL_NAME_NAME, cursor.getString(2));
			channels.add(values);
		}
		cursor.close();
		return channels;
	}

	private void updateTabs(List<ContentValues> channels) {
		TabHost tabChannel = (TabHost) findViewById(R.id.tabChannel);
		tabChannel.setup(this.getLocalActivityManager());
		for (ContentValues values : channels) {
			Intent view = null;
			String channelCode = values.getAsString(COL_NAME_CODE);
			if ("other".equalsIgnoreCase(channelCode)) {
				view = new Intent(this, SubChannelListActivity.class);
			} else {
				view = new Intent(this, MessageListActivity.class);
			}
			view.putExtra(ChannelConst.CHANNEL_DATA_KEY, values);
			tabChannel.addTab(tabChannel
					.newTabSpec(values.getAsString(COL_NAME_UUID))
					.setIndicator(values.getAsString(COL_NAME_NAME)).setContent(view));
		}
		tabChannel.setCurrentTab(0);
	}
}
