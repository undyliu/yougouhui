package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_PARENT_ID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import android.app.ActionBar;
import android.app.ActionBar.Tab;
import android.app.FragmentTransaction;
import android.content.BroadcastReceiver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.mess.ChannelConst;
import com.seekon.yougouhui.func.mess.MessageServiceHelper;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.widget.TabFragmentPagerAdapter;

public class ChannelFragment extends Fragment implements ActionBar.TabListener {

	private static String TAG = ChannelFragment.class.getSimpleName();

	private Long requestId;

	private BroadcastReceiver requestReceiver;

	private FragmentActivity attachedActivity = null;

	private ActionBar actionBar = null;

	private ViewPager mViewPager;

	private TabFragmentPagerAdapter mAdapter = null;

	List<Fragment> messageFragments = new ArrayList<Fragment>();

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = (FragmentActivity) this.getActivity();
		actionBar = attachedActivity.getActionBar();
		actionBar.setDisplayShowCustomEnabled(true);

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
						// showToast(getString(R.string.disconnected_server));
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};

		updateTabs();
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		mViewPager = (ViewPager) inflater.inflate(R.layout.channel_page_view,
				container, false);

		return mViewPager;
	}

	@Override
	public void onResume() {
		super.onResume();
		attachedActivity.registerReceiver(requestReceiver, new IntentFilter(
				MessageServiceHelper.CHANNEL_REQUEST_RESULT));

		if (mAdapter != null) {
			mViewPager.setAdapter(mAdapter);
		}

		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);// 设置为页签导航模式
	}

	@Override
	public void onPause() {
		super.onDestroy();
		Logger.debug(TAG, " onPause channelFragement");
		attachedActivity.unregisterReceiver(requestReceiver);
	}

	private void updateTabs() {
		AsyncTask<Void, Void, List<ContentValues>> task = new AsyncTask<Void, Void, List<ContentValues>>() {
			@Override
			protected List<ContentValues> doInBackground(Void... params) {
				Logger.debug(TAG, "get channels from local db.");

				List<ContentValues> channels = new LinkedList<ContentValues>();
				Cursor cursor = attachedActivity.getContentResolver().query(
						ChannelConst.CONTENT_URI,
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

				if (mViewPager == null) {
					mViewPager = (ViewPager) attachedActivity
							.findViewById(R.id.tabChannelViewPager);
				}

				for (ContentValues channel : channels) {
					ActionBar.Tab channelTab = actionBar.newTab();
					channelTab.setTabListener(ChannelFragment.this);
					
					String channelCode = channel.getAsString(COL_NAME_CODE);
					if ("other".equalsIgnoreCase(channelCode)) {
						channelTab.setCustomView(getSpinnerView());
					} else {
						channelTab.setText(channel.getAsString(COL_NAME_NAME));
						messageFragments.add(new MessageListFragment(channel));
					}
					
					actionBar.addTab(channelTab);
				}

				mAdapter = new TabFragmentPagerAdapter(
						ChannelFragment.this.getChildFragmentManager(), messageFragments);
				mViewPager.setAdapter(mAdapter);
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
					return MessageServiceHelper.getInstance(attachedActivity)
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

	@Override
	public void onTabReselected(Tab tab, FragmentTransaction ft) {

	}

	@Override
	public void onTabSelected(Tab tab, FragmentTransaction ft) {
		mViewPager.setCurrentItem(tab.getPosition(), false);
	}

	@Override
	public void onTabUnselected(Tab tab, FragmentTransaction ft) {

	}

	private View getSpinnerView() {
		View actionbarLayout = LayoutInflater.from(attachedActivity).inflate(
				R.layout.subchannel_spinner, null);
		Spinner mActionbarSpinner = (Spinner) actionbarLayout
				.findViewById(R.id.action_bar_spinner);
		mActionbarSpinner
				.setOnItemSelectedListener(new SpinnerItemSelectedListener());

		List<String> data = new ArrayList<String>();
		data.add("A");
		data.add("B");
		data.add("C");
		data.add("D");

		mActionbarSpinner.setAdapter(new ArrayAdapter<String>(attachedActivity,
				android.R.layout.simple_expandable_list_item_1, data));
		return actionbarLayout;
	}

	private class SpinnerItemSelectedListener implements OnItemSelectedListener {

		@Override
		public void onItemSelected(AdapterView<?> arg0, View view, int position,
				long arg3) {
			String str = arg0.getItemAtPosition(position).toString();
			Logger.debug(TAG, "你点击的是:" + str);
			// Toast.makeText(MainActivity.this, "你点击的是:"+str, 2000).show();
		}

		@Override
		public void onNothingSelected(AdapterView<?> arg0) {
		}
	}
}
