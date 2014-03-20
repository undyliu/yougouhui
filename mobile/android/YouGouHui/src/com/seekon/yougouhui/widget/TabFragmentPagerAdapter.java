package com.seekon.yougouhui.widget;

import java.util.List;

import android.content.ContentValues;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.view.View;
import android.view.ViewGroup;

import com.seekon.yougouhui.activity.TextFragment;
import com.seekon.yougouhui.func.DataConst;

public class TabFragmentPagerAdapter extends FragmentPagerAdapter{
	
	private List<Fragment> fragments = null;
	
	private FragmentManager fragmentManager = null;
	
	public TabFragmentPagerAdapter(FragmentManager fm, List<Fragment> fragments) {
		super(fm);
		this.fragments = fragments;
		this.fragmentManager = fm;
	}

	@Override
	public Fragment getItem(int arg0) {
		return fragments.get(arg0);
	}

	@Override
	public int getCount() {
		return fragments == null? 0 : fragments.size();
	}
	
//	public void show(int index){
//		android.support.v4.app.FragmentTransaction ftt = fragmentManager.beginTransaction();
//		for(int i = 0; i < fragments.size(); i++){
//			Fragment fragment = this.getItem(i);
//			if(i == index && fragment != null && fragment.isHidden()){
//				ftt.show(fragment);
//			}else{
//				ftt.hide(fragment);
//			}
//		}
//		ftt.commit();
//	}
	
}
