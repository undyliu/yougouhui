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

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.user.UserProfileActivity;
import com.seekon.yougouhui.fragment.ChannelFragment;
import com.seekon.yougouhui.fragment.DiscoverFragment;
import com.seekon.yougouhui.fragment.ProfileFragment;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.util.LocationUtils;

/**
 * 主窗口界面
 * 
 * @author undyliu
 * 
 */
public class MainActivity extends FragmentActivity {

	public final static int REGISTER_USER_REQUEST_CODE = 1;

	private LocationClient mLocationClient = null;

	private FragmentTabHost mTabHost;
	private Menu menu;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);

		initView();

		mLocationClient = new LocationClient(getApplicationContext()); // 声明LocationClient类
		mLocationClient.registerLocationListener(new MyLocationListener());
		mLocationClient.setLocOption(LocationUtils.getDefaultLocationOption());
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.main, menu);
		this.menu = menu;
		updateMenu();
		return true;
	}

	private void updateMenu() {
		if (menu == null) {
			return;
		}

		UserEntity user = RunEnv.getInstance().getUser();
		if (user != null) {
			MenuItem item = menu.findItem(R.id.menu_user_profile);
			String userIcon = user.getPhoto();
			if (userIcon != null) {
				// item.setIcon(FileHelper.getDrawableFromFileCache(userIcon));
			}
			String userName = user.getName();
			item.setTitle(userName);
		}
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

	@Override
	protected void onStart() {
		mLocationClient.start();// 开始定位
		super.onStart();
	}

	@Override
	protected void onStop() {
		if (mLocationClient != null && this.mLocationClient.isStarted()) {
			mLocationClient.stop();
		}

		super.onStop();
	}

	@Override
	protected void onDestroy() {
		if (mLocationClient != null) {
			mLocationClient = null;
		}
		super.onDestroy();
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case REGISTER_USER_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				UserEntity user = (UserEntity) data
						.getSerializableExtra(UserConst.KEY_REGISTER_USER);
				RunEnv.getInstance().setUser(user);
				updateMenu();

				View view = mTabHost.getCurrentView();
				view.invalidate();
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void initView() {
		mTabHost = (FragmentTabHost) findViewById(android.R.id.tabhost);
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

	private void openUserProfile() {
		Intent intent = new Intent(this, UserProfileActivity.class);
		this.startActivity(intent);
	}

	class MyLocationListener implements BDLocationListener {

		@Override
		public void onReceiveLocation(BDLocation location) {
			if (location == null) {
				return;
			}

			Intent intent = new Intent(Const.KEY_BROAD_LOCATION);
			intent.putExtra(Const.DATA_BROAD_LOCATION, location);
			sendBroadcast(intent);
		}

		@Override
		public void onReceivePoi(BDLocation poiLocation) {

		}

	}
}
