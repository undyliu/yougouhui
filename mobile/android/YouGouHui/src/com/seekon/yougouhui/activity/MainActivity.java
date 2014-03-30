package com.seekon.yougouhui.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTabHost;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TabHost.TabSpec;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.fragment.ChannelFragment;
import com.seekon.yougouhui.fragment.DiscoverFragment;
import com.seekon.yougouhui.fragment.ProfileFragment;

/**
 * 主窗口界面
 * 
 * @author undyliu
 * 
 */
public class MainActivity extends FragmentActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		initView();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case R.id.menu_search:
			break;
		case R.id.menu_user_profile:
			openUserProfile();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void initView() {
		FragmentTabHost mTabHost = (FragmentTabHost) findViewById(android.R.id.tabhost);
		mTabHost.setup(this, getSupportFragmentManager(), R.id.realtabcontent);

		Class<Fragment>[] fragmentArray = new Class[] { ChannelFragment.class,
				DiscoverFragment.class, ProfileFragment.class };
		int[] imgArray = new int[] { R.drawable.tab_home_btn,
				R.drawable.tab_square_btn, R.drawable.tab_selfinfo_btn };
		String[] titleArray = new String[] { "活动", "发现", "我" };
		for (int i = 0; i < fragmentArray.length; i++) {
			TabSpec tabSpec = mTabHost.newTabSpec(titleArray[i]).setIndicator(
					getTabItemView(imgArray[i], titleArray[i]));
			mTabHost.addTab(tabSpec, fragmentArray[i], null);
			mTabHost.getTabWidget().getChildAt(i)
					.setBackgroundResource(R.drawable.selector_tab_background);
		}
	}

	private View getTabItemView(int img, String text) {
		LayoutInflater layoutInflater = LayoutInflater.from(this);
		View view = layoutInflater.inflate(R.layout.main_tab_item, null);

		ImageView imageView = (ImageView) view.findViewById(R.id.imageview);
		imageView.setImageResource(img);

		TextView textView = (TextView) view.findViewById(R.id.textview);
		textView.setText(text);

		return view;
	}
	
	private void openUserProfile(){
		Intent intent = new Intent(this, UserProfileActivity.class);
		this.startActivity(intent);
	}
}
