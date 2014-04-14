package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;

import android.support.v4.view.PagerAdapter;
import android.view.View;
import android.view.ViewGroup;

public class RegisterPagerAdapter extends PagerAdapter {

	private List<String> titleList;
	private List<View> pageViews;

	public RegisterPagerAdapter(List<View> pageViews, List<String> titleList) {
		super();
		this.pageViews = pageViews;
		this.titleList = titleList;
	}

	@Override
	public int getCount() {
		return pageViews.size();
	}

	@Override
	public boolean isViewFromObject(View arg0, Object arg1) {
		return arg0 == arg1;
	}

	@Override
	public void destroyItem(ViewGroup container, int position, Object object) {
		container.removeView(pageViews.get(position));
	}

	@Override
	public Object instantiateItem(ViewGroup container, int position) {
		container.addView(pageViews.get(position));
		return pageViews.get(position);
	}

	@Override
	public CharSequence getPageTitle(int position) {
		return titleList.get(position);
	}
}
