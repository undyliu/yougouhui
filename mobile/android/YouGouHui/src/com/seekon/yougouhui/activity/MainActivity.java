package com.seekon.yougouhui.activity;

import android.app.TabActivity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.Menu;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TabHost;
import android.widget.TabWidget;
import android.widget.TextView;

import com.seekon.yougouhui.R;

/**
 * 主窗口界面
 * 
 * @author undyliu
 * 
 */
@SuppressWarnings("deprecation")
public class MainActivity extends TabActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		final TabHost tabCategory = this.getTabHost();
		tabCategory.setOnTabChangedListener(new TabHost.OnTabChangeListener() {
			
			@Override
			public void onTabChanged(String tabId) {
				tabCategory.setCurrentTabByTag(tabId);
				updateTabs();
			}
		});
		
		tabCategory.addTab(tabCategory.newTabSpec("tab_activity")
				.setIndicator(composeLayout("活动", R.drawable.message))
				.setContent(new Intent(this, ChannelTabActivity.class)));
		tabCategory.addTab(tabCategory.newTabSpec("tab_discover")
				.setIndicator(composeLayout("发现", R.drawable.discover))
				.setContent(new Intent(this, DiscoverActivity.class)));
		tabCategory.addTab(tabCategory.newTabSpec("tab_profile")
				.setIndicator(composeLayout("我", R.drawable.profile))
				.setContent(new Intent(this, ProfileActivity.class)));

		tabCategory.setCurrentTab(0);
		updateTabs();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	private void updateTabs(){
		TabHost tabCategory = this.getTabHost();
		int currentTab = tabCategory.getCurrentTab();
		TabWidget tw = tabCategory.getTabWidget();
		for (int i = 0; i < tw.getChildCount(); i++) {
			View view = tw.getChildAt(i);
			if(i == currentTab){
				view.setBackgroundColor(Color.DKGRAY);
			}else{
				view.setBackgroundColor(Color.LTGRAY);
			}
		}
	}
	
	private View composeLayout(String s, int i) {
		LinearLayout layout = new LinearLayout(this);
		layout.setOrientation(LinearLayout.VERTICAL);

		ImageView iv = new ImageView(this);
		iv.setImageResource(i);
		layout.addView(iv, new LinearLayout.LayoutParams(
				LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT));

		TextView tv = new TextView(this);
		tv.setGravity(Gravity.CENTER);
		tv.setSingleLine(true);
		tv.setTextColor(Color.WHITE);
		tv.setText(s);
		layout.addView(tv, new LinearLayout.LayoutParams(
				LinearLayout.LayoutParams.FILL_PARENT,
				LinearLayout.LayoutParams.WRAP_CONTENT));

		return layout;
	}
}
