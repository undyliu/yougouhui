package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_PARENT_ID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.LinkedList;
import java.util.List;

import android.app.ActionBar;
import android.app.ActionBar.Tab;
import android.app.FragmentTransaction;
import android.content.BroadcastReceiver;
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

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.fragment.listener.ChannelTabChangeListener;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.ChannelConst;
import com.seekon.yougouhui.func.sale.ChannelEntity;
import com.seekon.yougouhui.func.sale.SaleServiceHelper;
import com.seekon.yougouhui.func.sale.widget.TabSaleFragmentPagerAdapter;
import com.seekon.yougouhui.util.Logger;

public class ChannelFragment extends Fragment implements ActionBar.TabListener {

	private static String TAG = ChannelFragment.class.getSimpleName();

	public static final int TAB_SHOW_COUNT = 4;

	private Long requestId;

	private BroadcastReceiver requestReceiver;

	private FragmentActivity attachedActivity = null;

	private ActionBar actionBar = null;

	private ViewPager mViewPager;

	private TabSaleFragmentPagerAdapter mAdapter = null;

	private SubChannelViewBuilder subChannelViewBuilder = null;

	private ChannelTabChangeListener channelTabChangeListener = null;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = (FragmentActivity) this.getActivity();
		subChannelViewBuilder = new SubChannelViewBuilder(attachedActivity);
		channelTabChangeListener = new ChannelTabChangeListener(this);

		actionBar = attachedActivity.getActionBar();
		actionBar.setDisplayShowCustomEnabled(true);

		requestReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context context, Intent intent) {
				long resultRequestId = intent.getLongExtra(
						SaleServiceHelper.EXTRA_REQUEST_ID, 0);
				if (resultRequestId == requestId) {
					int resultCode = intent.getIntExtra(
							SaleServiceHelper.EXTRA_RESULT_CODE, 0);
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
		mViewPager = (ViewPager) inflater.inflate(R.layout.channel_viewpager,
				container, false);

		return mViewPager;
	}

	@Override
	public void onResume() {
		super.onResume();
		attachedActivity.registerReceiver(requestReceiver, new IntentFilter(
				SaleServiceHelper.CHANNEL_REQUEST_RESULT));

		if (mAdapter != null) {
			mViewPager.setAdapter(mAdapter);
		}
		mViewPager.setOnPageChangeListener(channelTabChangeListener);

		subChannelViewBuilder.setViewPager(mViewPager);
		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);// 设置为页签导航模式
	}

	@Override
	public void onPause() {
		super.onDestroy();
		Logger.debug(TAG, " onPause channelFragement");
		attachedActivity.unregisterReceiver(requestReceiver);
	}

	private void updateTabs() {
		AsyncTask<Void, Void, List<ChannelEntity>> task = new AsyncTask<Void, Void, List<ChannelEntity>>() {
			@Override
			protected List<ChannelEntity> doInBackground(Void... params) {
				Logger.debug(TAG, "get channels from local db.");

				List<ChannelEntity> channels = new LinkedList<ChannelEntity>();
				Cursor cursor = null;
				try {
					cursor = attachedActivity.getContentResolver().query(
							ChannelConst.CONTENT_URI,
							new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME,
									COL_NAME_ORD_INDEX }, COL_NAME_PARENT_ID + " is null ", null,
							COL_NAME_ORD_INDEX);
					while (cursor.moveToNext()) {
						int i = 0;
						channels.add(new ChannelEntity(cursor.getString(i++), cursor
								.getString(i++), cursor.getString(i++), cursor.getInt(i++)));
					}
				} finally {
					cursor.close();
				}
				return channels;
			}

			@Override
			protected void onPostExecute(List<ChannelEntity> channels) {
				if (channels.size() == 0) {
					updateChannelsRemote();
					return;
				}

				if (mViewPager == null) {
					mViewPager = (ViewPager) attachedActivity
							.findViewById(R.id.tabChannelViewPager);
				}

				int index = 0;
				List<ChannelEntity> subChannels = channels.subList(TAB_SHOW_COUNT,
						channels.size());
				for (ChannelEntity channel : channels) {

					if (index < TAB_SHOW_COUNT) {
						ActionBar.Tab channelTab = actionBar.newTab();
						channelTab.setTabListener(ChannelFragment.this);
						channelTab.setText(channel.getName());
						actionBar.addTab(channelTab);
					} else if (index == TAB_SHOW_COUNT) {
						ActionBar.Tab channelTab = actionBar.newTab();
						channelTab.setTabListener(ChannelFragment.this);
						channelTab.setCustomView(subChannelViewBuilder
								.getSpinnerView(subChannels));
						actionBar.addTab(channelTab);
					}

					index++;
				}

				subChannelViewBuilder.setViewPager(mViewPager);
				mAdapter = new TabSaleFragmentPagerAdapter(
						ChannelFragment.this.getChildFragmentManager(), channels);
				mViewPager.setAdapter(mAdapter);
				// mViewPager.setCurrentItem(0);
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
					return SaleServiceHelper.getInstance(attachedActivity).getChannels(
							null, SaleServiceHelper.CHANNEL_REQUEST_RESULT);
				}

				@Override
				protected void onPostExecute(Long result) {
					requestId = result;
				}
			};
			task.execute((Void) null);
		}
	}

	public SubChannelViewBuilder getSubChannelViewBuilder() {
		return this.subChannelViewBuilder;
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

}
