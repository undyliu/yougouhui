package com.seekon.yougouhui.activity.profile.favorit;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.ActionBar.Tab;
import android.app.ActionBar.TabListener;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.fragment.listener.TabFragmentPagerAdapter;

/**
 * 我的收藏主页
 * 
 * @author undyliu
 * 
 */
public class FavoritMainActivity extends FragmentActivity {

	private ViewPager viewPager;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.favorit_main);

		viewPager = (ViewPager) findViewById(R.id.favorit_pager);
		
		final ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
		
    Tab tabSale = actionBar.newTab().setText(R.string.title_favorit_tab_sale);
    Tab tabShop = actionBar.newTab().setText(R.string.title_favorit_tab_shop);
       
    tabSale.setTabListener(new MyTabListener());
    tabShop.setTabListener(new MyTabListener());
    
    actionBar.addTab(tabSale);
    actionBar.addTab(tabShop);
    
    List<Fragment> fragements = new ArrayList<Fragment>();
    fragements.add(new SaleFavoritFragment());
    fragements.add(new ShopFavoritFragment());
    
    TabFragmentPagerAdapter adapter = new TabFragmentPagerAdapter(getSupportFragmentManager(), fragements);
    viewPager.setAdapter(adapter);
    
    viewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
			
			@Override
			public void onPageSelected(int arg0) {
				actionBar.setSelectedNavigationItem(arg0);
			}
			
			@Override
			public void onPageScrolled(int arg0, float arg1, int arg2) {
				
			}
			
			@Override
			public void onPageScrollStateChanged(int arg0) {
				
			}
		});
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}
	
	class MyTabListener implements TabListener {

		public void onTabReselected(Tab tab, FragmentTransaction ft) {
			viewPager.setCurrentItem(tab.getPosition());
		}

		public void onTabSelected(Tab tab, FragmentTransaction ft) {
			
		}

		public void onTabUnselected(Tab tab, FragmentTransaction ft) {
			
		}
	}
}
