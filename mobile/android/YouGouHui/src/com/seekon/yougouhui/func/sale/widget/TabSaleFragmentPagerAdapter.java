package com.seekon.yougouhui.func.sale.widget;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import com.seekon.yougouhui.fragment.SaleListFragment;
import com.seekon.yougouhui.func.sale.ChannelEntity;

public class TabSaleFragmentPagerAdapter extends FragmentPagerAdapter {

	private List<ChannelEntity> channels;

	private Map<Integer, Fragment> fragmentMap = new HashMap<Integer, Fragment>();

	public TabSaleFragmentPagerAdapter(FragmentManager fm,
			List<ChannelEntity> channels) {
		super(fm);
		this.channels = channels;
	}

	@Override
	public Fragment getItem(int position) {
		Fragment fragment = fragmentMap.get(position);
		if (fragment == null) {
			fragment = new SaleListFragment();
			((SaleListFragment) fragment).setChannel(channels.get(position));
			fragmentMap.put(position, fragment);
		}
		return fragment;
	}

	@Override
	public int getCount() {
		return channels == null ? 0 : channels.size();
	}

}
