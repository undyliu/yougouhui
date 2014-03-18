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
import android.os.AsyncTask;
import android.os.Bundle;
import android.widget.TabHost;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.mess.ChannelConst;
import com.seekon.yougouhui.func.mess.MessageServiceHelper;
import com.seekon.yougouhui.util.Logger;

/**
 * 活动栏目页签
 * 
 * @author undyliu
 * 
 */
@SuppressWarnings("deprecation")
public class ChannelTabActivity extends ActivityGroup {

	private static final String TAG = ChannelTabActivity.class.getSimpleName();

	private Long requestId;

	private BroadcastReceiver requestReceiver;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.channel_tab);

		IntentFilter filter = new IntentFilter(
				MessageServiceHelper.CHANNEL_REQUEST_RESULT);
		requestReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context context, Intent intent) {
				long resultRequestId = intent.getLongExtra(
						MessageServiceHelper.EXTRA_REQUEST_ID, 0);
				if (resultRequestId == requestId) {
					int resultCode = intent.getIntExtra(
							MessageServiceHelper.EXTRA_RESULT_CODE, 0);
					if (resultCode == 200) {
						updateTabs();
					} else {
						//showToast(getString(R.string.disconnected_server));
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};
		this.registerReceiver(requestReceiver, filter);
		
		updateTabs();
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		this.unregisterReceiver(requestReceiver);
	}

	private void updateTabs() {
		AsyncTask<Void, Void, List<ContentValues>> task = new AsyncTask<Void, Void, List<ContentValues>>() {
			@Override
			protected List<ContentValues> doInBackground(Void... params) {
				Logger.debug(TAG, "get channels from local db.");
				
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

			@Override
			protected void onPostExecute(List<ContentValues> channels) {
				if (channels.size() == 0) {
					updateChannelsRemote();
					return;
				}

				TabHost tabChannel = (TabHost) findViewById(R.id.tabChannel);
				tabChannel.setup(ChannelTabActivity.this.getLocalActivityManager());
				for (ContentValues values : channels) {
					Intent view = null;
					String channelCode = values.getAsString(COL_NAME_CODE);
					if ("other".equalsIgnoreCase(channelCode)) {
						view = new Intent(ChannelTabActivity.this,
								SubChannelListActivity.class);
					} else {
						view = new Intent(ChannelTabActivity.this,
								MessageListActivity.class);
					}
					view.putExtra(ChannelConst.CHANNEL_DATA_KEY, values);
					tabChannel
							.addTab(tabChannel.newTabSpec(values.getAsString(COL_NAME_UUID))
									.setIndicator(values.getAsString(COL_NAME_NAME))
									.setContent(view));
				}
				tabChannel.setCurrentTab(0);
			}
		};

		task.execute((Void) null);
	}

	private void updateChannelsRemote() {
		if (requestId == null && RunEnv.getInstance().isConnectedToInternet()) {
			Logger.debug(TAG, "updateChannelsRemote");
			AsyncTask<Void, Void, Long> task = new AsyncTask<Void, Void, Long>() {
				@Override
				protected Long doInBackground(Void... params) {
					return MessageServiceHelper.getInstance(ChannelTabActivity.this)
							.getChannels(null, MessageServiceHelper.CHANNEL_REQUEST_RESULT);
				}

				@Override
				protected void onPostExecute(Long result) {
					requestId = result;
				}
			};
			task.execute((Void) null);
		}
	}
}
