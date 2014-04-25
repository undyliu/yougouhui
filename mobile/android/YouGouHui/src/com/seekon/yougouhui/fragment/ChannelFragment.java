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
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.fragment.listener.ChannelTabChangeListener;
import com.seekon.yougouhui.func.sale.ChannelConst;
import com.seekon.yougouhui.func.sale.ChannelEntity;
import com.seekon.yougouhui.func.sale.ChannelProcessor;
import com.seekon.yougouhui.func.sale.widget.TabSaleFragmentPagerAdapter;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;

public class ChannelFragment extends Fragment implements ActionBar.TabListener {

	public static final int TAB_SHOW_COUNT = 4;

	private FragmentActivity attachedActivity = null;

	private ActionBar actionBar = null;

	private ViewPager mViewPager;

	private TabSaleFragmentPagerAdapter mAdapter = null;

	private SubChannelViewBuilder subChannelViewBuilder = null;

	private ChannelTabChangeListener channelTabChangeListener = null;

	private List<ChannelEntity> channels = new LinkedList<ChannelEntity>();

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = (FragmentActivity) this.getActivity();
		subChannelViewBuilder = new SubChannelViewBuilder(attachedActivity);
		channelTabChangeListener = new ChannelTabChangeListener(this);

		actionBar = attachedActivity.getActionBar();
		actionBar.setDisplayShowCustomEnabled(true);

	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		mViewPager = (ViewPager) inflater.inflate(R.layout.channel_viewpager,
				container, false);

		updateViews();

		return mViewPager;
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (mAdapter != null && mViewPager != null) {
			Fragment fg = mAdapter.getItem(mViewPager.getCurrentItem());
			if (fg != null) {
				fg.onActivityResult(requestCode, resultCode, data);
			}
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void updateViews() {
		if (mAdapter != null) {
			mViewPager.setAdapter(mAdapter);
		}
		mViewPager.setOnPageChangeListener(channelTabChangeListener);

		subChannelViewBuilder.setViewPager(mViewPager);
		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);// 设置为页签导航模式

		if (channels.isEmpty()) {
			loadChannels();
		}
	}

	private void loadChannels() {
		loadChannelsFromLocal();
		if (channels.isEmpty()) {
			loadChannelsFromRemote();
		} else {
			updateTabs();
		}
	}

	private void loadChannelsFromLocal() {
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
	}

	private void updateTabs() {
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
	}

	private void loadChannelsFromRemote() {
		RestUtils.executeAsyncRestTask(attachedActivity,
				new AbstractRestTaskCallback<JSONArrayResource>() {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return ChannelProcessor.getInstance(attachedActivity).getChannels(
								null);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						loadChannelsFromLocal();
						updateTabs();
					}
				});
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
