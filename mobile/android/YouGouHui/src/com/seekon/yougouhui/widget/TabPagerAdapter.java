package com.seekon.yougouhui.widget;

import java.util.List;

import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;


public class TabPagerAdapter extends PagerAdapter{

	private List<View> mListViews;
	
	public TabPagerAdapter(List<View> mListViews) {
		super();
		this.mListViews = mListViews;
	}

	@Override
	public int getCount() {
		return mListViews == null ? 0: mListViews.size();
	}

	@Override
	public boolean isViewFromObject(View view, Object object) {
		return view == object;
	}

	/** 
   * 从指定的position创建page 
   * 
   * @param container ViewPager容器 
   * @param position The page position to be instantiated. 
   * @return 返回指定position的page，这里不需要是一个view，也可以是其他的视图容器. 
   */  
  @Override  
  public Object instantiateItem(View collection, int position) {  

        
      ((ViewPager) collection).addView(mListViews.get(position),0);  
        
      return mListViews.get(position);  
  }  

  /** 
   * <span style="font-family:'Droid Sans';">从指定的position销毁page</span> 
   *  
   *  
   *<span style="font-family:'Droid Sans';">参数同上</span> 
   */  
  @Override  
  public void destroyItem(View collection, int position, Object view) {  
      ((ViewPager) collection).removeView(mListViews.get(position));  
  }  
}
