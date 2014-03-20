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
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

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
	
	 private Tab selectedTab = null;
	
	 private List<ContentValues> channels = null;


	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = (FragmentActivity) this.getActivity();
		actionBar = attachedActivity.getActionBar();

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
						// showToast(getString(R.string.disconnected_server));
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};
		attachedActivity.registerReceiver(requestReceiver, filter);

		updateTabs();
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		// if (mViewPager != null) {
		// mViewPager.removeAllViews();
		// }
		 mViewPager = (ViewPager) inflater.inflate(R.layout.channel_page_view,
		 container, false);
		// if (channels != null) {
		// mAdapter = new TabFragmentPagerAdapter(
		// attachedActivity.getSupportFragmentManager(), channels);
		if (mAdapter != null) {
			mViewPager.setAdapter(mAdapter);
		}
		// }
		// if(selectedTab != null){
		// actionBar.selectTab(selectedTab);
		// }

		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);// 设置为页签导航模式
		return mViewPager;
		//return inflater.inflate(R.layout.channel_fragment, container, false);
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

				// if (mViewPager == null) {
				// mViewPager = (ViewPager) attachedActivity
				// .findViewById(R.id.tabChannelViewPager);
				// }

				List<Fragment> messageFragments = new ArrayList<Fragment>();
				for (ContentValues channel : channels) {
					ActionBar.Tab channelTab = actionBar.newTab().setText(
							channel.getAsString(COL_NAME_NAME));
					channelTab.setTabListener(ChannelFragment.this);
					actionBar.addTab(channelTab);
					messageFragments.add(new MessageListFragment(channel));
//					messageFragments.add(new
//					TextFragment(channel.getAsString(COL_NAME_NAME)));
				}

				 mAdapter = new TabFragmentPagerAdapter(
				 attachedActivity.getSupportFragmentManager(), messageFragments);
				// List<View> messageViews = new ArrayList<View>();
				// for (ContentValues channel : channels) {
				// TextView view = new TextView(attachedActivity);
				// view.setText(channel.getAsString(COL_NAME_NAME));
				// messageViews.add(view);
				// }
				//mAdapter = new TabPagerAdapter(messageViews);
				mViewPager.setAdapter(mAdapter);
				mViewPager.setCurrentItem(0);
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
		// selectedTab = tab;
		mViewPager.setCurrentItem(tab.getPosition(), false);
//		if(mAdapter != null){
//			mAdapter.show(tab.getPosition());
//		}
	}

	@Override
	public void onTabUnselected(Tab tab, FragmentTransaction ft) {

	}

}
