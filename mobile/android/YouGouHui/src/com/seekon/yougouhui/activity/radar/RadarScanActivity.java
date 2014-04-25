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
import android.app.Dialog;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.NumberPicker;
import android.widget.NumberPicker.OnValueChangeListener;

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
import com.seekon.yougouhui.func.setting.SettingProcessor;
import com.seekon.yougouhui.func.setting.SettingUtils;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.LocationUtils;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.BasePagerAdapter;

public class RadarScanActivity extends Activity implements
		OnPageChangeListener, OnValueChangeListener {

	private static final String TAG = RadarScanActivity.class.getSimpleName();

	private ViewPager viewPager;
	private View saleView;
	private RadarSaleListView saleListView;
	private View shopView;
	private RadarShopListView shopListView;
	private View friendView;
	private RadarFriendListView friendListView;

	private EditText distanceView;
	private EditText targetView;
	private List<RadarResultListView> resultViewList = new ArrayList<RadarResultListView>();

	private SettingEntity settings;
	private LocationClient mLocationClient = null;
	private LocationEntity locationEntity = null;

	boolean saleCheck = false;
	boolean shopCheck = false;
	boolean friendCheck = false;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.radar_scan);

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
		distanceView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				showNumberPickerDialog();
			}
		});

		targetView = (EditText) findViewById(R.id.radar_target);
		ViewUtils.setEditTextReadOnly(targetView);
		targetView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				showRadarTargetDialog();
			}
		});

		LayoutInflater mInflater = LayoutInflater.from(this);

		saleView = mInflater.inflate(R.layout.radar_scan_sale, null);
		saleListView = (RadarSaleListView) saleView
				.findViewById(R.id.listview_main);
		saleListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {

			}
		});

		shopView = mInflater.inflate(R.layout.radar_scan_shop, null);
		shopListView = (RadarShopListView) shopView
				.findViewById(R.id.listview_main);
		shopListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {

			}
		});

		friendView = mInflater.inflate(R.layout.radar_scan_friend, null);
		friendListView = (RadarFriendListView) friendView
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

		settings = SettingUtils.getRadarSettingsWithDefaultValue(this);
		if (settings != null) {
			updateViewpager(settings);
		} else {
			RestUtils.executeAsyncRestTask(this,
					new AbstractRestTaskCallback<JSONArrayResource>("获取设置信息失败.") {

						@Override
						public RestMethodResult<JSONArrayResource> doInBackground() {
							return SettingProcessor.getInstance(RadarScanActivity.this)
									.getSettings();
						}

						@Override
						public void onSuccess(RestMethodResult<JSONArrayResource> result) {
							settings = SettingUtils
									.getRadarSettingsWithDefaultValue(RadarScanActivity.this);
							updateViewpager(settings);
						}
					});
		}
	}

	private void updateViewpager(SettingEntity settings) {
		try {
			JSONObject settingValue = SettingUtils.parseSettingValue(settings);
			if (settingValue != null) {
				distanceView.setText(settingValue.getString(RADAR_VAL_FIELD_DISTANCE));
				saleCheck = settingValue.getBoolean(RADAR_VAL_FIELD_SALE);
				shopCheck = settingValue.getBoolean(RADAR_VAL_FIELD_SHOP);
				friendCheck = settingValue.getBoolean(RADAR_VAL_FIELD_FRIEND);

				updateViewpager();
			}
		} catch (JSONException e) {
			Logger.warn(TAG, e.getMessage(), e);
		}
	}

	private void updateViewpager() {
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
		targetView.setText(radarTaget.length() > 0 ? radarTaget.substring(1) : "");
	}

	private void doLoadData(boolean reload) {
		if (locationEntity != null) {
			RadarResultListView resultView = resultViewList.get(viewPager
					.getCurrentItem());
			resultView.loadDataList(locationEntity, reload);
		}
	}

	public void showNumberPickerDialog() {

		final Dialog d = new Dialog(this);
		d.setTitle(R.string.title_number_picker);
		View view = LayoutInflater.from(this).inflate(R.layout.base_dialog, null);
		d.setContentView(view);

		Button cancelButton = (Button) d.findViewById(R.id.b_cancel);
		Button setButton = (Button) d.findViewById(R.id.b_set);

		final NumberPicker np = new NumberPicker(this);
		np.setLayoutParams(new LinearLayout.LayoutParams(LayoutParams.WRAP_CONTENT,
				LayoutParams.WRAP_CONTENT));
		((LinearLayout) view.findViewById(R.id.content_main)).addView(np);

		np.setMaxValue(10000);
		np.setMinValue(0);
		np.setValue(Integer.valueOf(distanceView.getText().toString()));
		np.setWrapSelectorWheel(false);
		np.setOnValueChangedListener(this);
		setButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				np.clearFocus();
				distanceView.setText(String.valueOf(np.getValue()));
				doLoadData(true);
				d.dismiss();
			}
		});
		cancelButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				d.dismiss();
			}
		});
		d.show();

	}

	private void showRadarTargetDialog() {
		final Dialog d = new Dialog(this);
		d.setTitle(R.string.title_radar_choose_target);
		View view = LayoutInflater.from(this).inflate(R.layout.base_dialog, null);
		d.setContentView(view);

		LinearLayout contentView = (LinearLayout) view
				.findViewById(R.id.content_main);

		final CheckBox saleCheckBox = new CheckBox(this);
		saleCheckBox.setText(R.string.label_radar_sale);
		saleCheckBox.setChecked(saleCheck);
		saleCheckBox.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
				saleCheck = isChecked;
			}
		});
		saleCheckBox.setLayoutParams(new LinearLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
		contentView.addView(saleCheckBox);

		CheckBox shopCheckBox = new CheckBox(this);
		shopCheckBox.setText(R.string.label_radar_shop);
		shopCheckBox.setChecked(shopCheck);
		shopCheckBox.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
				shopCheck = isChecked;
			}
		});
		shopCheckBox.setLayoutParams(new LinearLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
		contentView.addView(shopCheckBox);

		CheckBox friendCheckBox = new CheckBox(this);
		friendCheckBox.setText(R.string.label_radar_friends);
		friendCheckBox.setChecked(friendCheck);
		friendCheckBox.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
				friendCheck = isChecked;
			}
		});
		friendCheckBox.setLayoutParams(new LinearLayout.LayoutParams(
				LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT));
		contentView.addView(friendCheckBox);

		Button cancelButton = (Button) d.findViewById(R.id.b_cancel);
		Button setButton = (Button) d.findViewById(R.id.b_set);
		setButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (!saleCheck && !shopCheck && !friendCheck) {
					// saleCheckBox.setError("请至少选择一个扫描目标.");
					ViewUtils.showToast("请至少选择一个扫描目标.");
					return;
				}
				updateViewpager();
				d.dismiss();
			}
		});
		cancelButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				if (settings != null) {
					try {
						JSONObject settingValue = SettingUtils.parseSettingValue(settings);
						if (settingValue != null) {
							saleCheck = settingValue.getBoolean(RADAR_VAL_FIELD_SALE);
							shopCheck = settingValue.getBoolean(RADAR_VAL_FIELD_SHOP);
							friendCheck = settingValue.getBoolean(RADAR_VAL_FIELD_FRIEND);
						}
					} catch (JSONException e) {
						Logger.warn(TAG, e.getMessage(), e);
					}
				}
				d.dismiss();
			}
		});
		d.show();
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
	public void onValueChange(NumberPicker picker, int oldVal, int newVal) {
		// //distanceView.setText(String.valueOf(newVal));
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

	}

	@Override
	public void onPageScrolled(int arg0, float arg1, int arg2) {

	}

	@Override
	public void onPageSelected(int arg0) {
		doLoadData(false);
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
				doLoadData(false);
			}
		}

		@Override
		public void onReceivePoi(BDLocation poiLocation) {

		}

	}
}
