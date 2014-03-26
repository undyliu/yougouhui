package com.seekon.yougouhui.fragment.listener;

import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;

import com.seekon.yougouhui.fragment.ChannelFragment;
import com.seekon.yougouhui.util.Logger;

public class TabSpinnerItemSelectedListener implements OnItemSelectedListener {
	private static final String TAG = TabSpinnerItemSelectedListener.class
			.getSimpleName();

	private ViewPager viewPager = null;

	public TabSpinnerItemSelectedListener() {
		super();
	}

	public TabSpinnerItemSelectedListener(ViewPager viewPager) {
		super();
		this.viewPager = viewPager;
	}

	public void setViewPager(ViewPager viewPager) {
		this.viewPager = viewPager;
	}

	@Override
	public void onItemSelected(AdapterView<?> arg0, View arg1, int position,
			long arg3) {
		String str = arg0.getItemAtPosition(position).toString();
		Logger.debug(TAG, "你点击的是:" + str);
		if (position == 0) {
			return;
		}
		if (viewPager != null) {
			viewPager.setCurrentItem(position + ChannelFragment.TAB_SHOW_COUNT - 1,
					false);
		}
	}

	@Override
	public void onNothingSelected(AdapterView<?> arg0) {

	}

}
