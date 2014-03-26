package com.seekon.yougouhui.fragment.listener;

import android.app.ActionBar;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.widget.Spinner;

import com.seekon.yougouhui.fragment.ChannelFragment;

public class ChannelTabChangeListener implements OnPageChangeListener {

	private ChannelFragment channelFragment = null;

	public ChannelTabChangeListener(ChannelFragment channelFragment) {
		super();
		this.channelFragment = channelFragment;
	}

	@Override
	public void onPageScrollStateChanged(int arg0) {

	}

	@Override
	public void onPageScrolled(int arg0, float arg1, int arg2) {

	}

	@Override
	public void onPageSelected(int position) {
		if (channelFragment != null) {
			ActionBar actionBar = channelFragment.getActivity().getActionBar();
			int tabCount = ChannelFragment.TAB_SHOW_COUNT;
			if (position <= tabCount) {
				int selectedNav = actionBar.getSelectedNavigationIndex();
				if (position != selectedNav) {
					actionBar.setSelectedNavigationItem(position);
				}
			}

			Spinner spinner = channelFragment.getSubChannelViewBuilder().getSpinner();
			if (spinner != null) {
				if (position >= tabCount) {
					int selectedPos = position - tabCount + 1;
					if (selectedPos != spinner.getSelectedItemPosition()) {
						spinner.setSelection(selectedPos);
					}
				} else {
					spinner.setSelection(0);
				}
			}
		}
	}

}
