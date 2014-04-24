package com.seekon.yougouhui.activity.radar;

import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_DISTANCE;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_FRIEND;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_SALE;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_SHOP;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.radar.widget.RadarFriendListView;
import com.seekon.yougouhui.func.radar.widget.RadarResultListView;
import com.seekon.yougouhui.func.radar.widget.RadarSaleListView;
import com.seekon.yougouhui.func.radar.widget.RadarShopListView;
import com.seekon.yougouhui.func.setting.SettingEntity;
import com.seekon.yougouhui.func.setting.SettingUtils;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.util.LocationUtils;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.BasePagerAdapter;

public class RadarScanActivity extends Activity implements
		OnPageChangeListener, IXListViewListener {

	private ViewPager viewPager;
	private EditText distanceView;
	private EditText targetView;
	private List<RadarResultListView> resultViewList = new ArrayList<RadarResultListView>();

	private SettingEntity settings;
	private LocationClient mLocationClient = null;
	private LocationEntity locationEntity = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.radar_scan);

		settings = SettingUtils.getRadarSettingsWithDefaultValue(this);
		initView();

		mLocationClient = new LocationClient(getApplicationContext()); // 声明LocationClient类
		mLocationClient.registerLocationListener(new MyLocationListener());
		mLocationClient.setLocOption(LocationUtils.getDefaultLocationOption());

	}

	private void initView() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		distanceView = (EditText) findViewById(R.id.radar_distance);
		ViewUtils.setEditTextReadOnly(distanceView);

		targetView = (EditText) findViewById(R.id.radar_target);
		ViewUtils.setEditTextReadOnly(targetView);

		LayoutInflater mInflater = LayoutInflater.from(this);

		View saleView = mInflater.inflate(R.layout.radar_scan_sale, null);
		RadarSaleListView saleListView = (RadarSaleListView) saleView
				.findViewById(R.id.listview_main);
		saleListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {

			}
		});

		View shopView = mInflater.inflate(R.layout.radar_scan_shop, null);
		RadarShopListView shopListView = (RadarShopListView) shopView
				.findViewById(R.id.listview_main);
		shopListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {

			}
		});

		View friendView = mInflater.inflate(R.layout.radar_scan_friend, null);
		RadarFriendListView friendListView = (RadarFriendListView) friendView
				.findViewById(R.id.listview_main);
		friendListView
				.setOnItemClickListener(new AdapterView.OnItemClickListener() {

					@Override
					public void onItemClick(AdapterView<?> arg0, View arg1, int position,
							long arg3) {

					}
				});

		viewPager = (ViewPager) findViewById(R.id.radar_scan_viewpager);
		viewPager.setOnPageChangeListener(this);
		viewPager.setCurrentItem(0);

		try {
			JSONObject settingValue = SettingUtils.parseSettingValue(settings);
			if (settingValue != null) {
				distanceView.setText(settingValue.getString(RADAR_VAL_FIELD_DISTANCE));
				boolean saleCheck = settingValue.getBoolean(RADAR_VAL_FIELD_SALE);
				boolean shopCheck = settingValue.getBoolean(RADAR_VAL_FIELD_SHOP);
				boolean friendCheck = settingValue.getBoolean(RADAR_VAL_FIELD_FRIEND);

				List<String> pageTitles = new ArrayList<String>();
				List<View> pageViews = new ArrayList<View>();
				if (saleCheck) {
					pageViews.add(saleView);
					pageTitles.add(getString(R.string.label_radar_sale));
					resultViewList.add(saleListView);
				}
				if (shopCheck) {
					pageViews.add(shopView);
					pageTitles.add(getString(R.string.label_radar_shop));
					resultViewList.add(shopListView);
				}
				if (friendCheck) {
					pageViews.add(friendView);
					pageTitles.add(getString(R.string.label_radar_friends));
					resultViewList.add(friendListView);
				}
				viewPager.setAdapter(new BasePagerAdapter(pageViews, pageTitles));

				String radarTaget = "";
				for (String title : pageTitles) {
					radarTaget += "-" + title;
				}
				targetView.setText(radarTaget.length() > 0 ? radarTaget.substring(1)
						: "");
			}
		} catch (JSONException e) {

		}
	}

	private void doLoadData() {
		if (locationEntity != null) {
			RadarResultListView resultView = resultViewList.get(viewPager
					.getCurrentItem());
			resultView.loadDataList(locationEntity);
		}
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
			mLocationClient = null;
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

	@Override
	public void onPageScrollStateChanged(int arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onPageScrolled(int arg0, float arg1, int arg2) {
		// TODO Auto-generated method stub

	}

	@Override
	public void onPageSelected(int arg0) {
		doLoadData();
	}

	@Override
	public void onRefresh() {

	}

	@Override
	public void onLoadMore() {

	}

	class MyLocationListener implements BDLocationListener {

		@Override
		public void onReceiveLocation(BDLocation location) {
			if (location == null) {
				return;
			}

			LocationEntity newLocation = new LocationEntity();
			if (location.getLocType() == BDLocation.TypeNetWorkLocation) {
				newLocation.setAddress(location.getAddrStr());
			}

			newLocation.setLatitude(location.getLatitude());
			newLocation.setLontitude(location.getLongitude());
			newLocation.setRadius(location.getRadius());
			if (locationEntity == null || !newLocation.equals(locationEntity)) {
				locationEntity = newLocation;
				doLoadData();
			}
		}

		@Override
		public void onReceivePoi(BDLocation poiLocation) {

		}

	}
}
