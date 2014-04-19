package com.seekon.yougouhui;

import android.app.Application;
import android.content.Context;
import android.content.Intent;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.seekon.yougouhui.util.Logger;

public class YouGouHuiApp extends Application {

	private static Context mAppContext;

	private LocationClient mLocationClient = null;

	@Override
	public void onCreate() {
		super.onCreate();

		mAppContext = getApplicationContext();

		Logger.setAppTag(getString(R.string.app_log_tag));
		Logger.setLevel(Logger.DEBUG);

		// //FileCache.getInstance().clear();

		mLocationClient = new LocationClient(getApplicationContext()); // 声明LocationClient类
		mLocationClient.registerLocationListener(new MyLocationListener());
		setLocationOption();
		mLocationClient.start();// 开始定位

	}

	public static Context getAppContext() {
		return mAppContext;
	}

	@Override
	public void onTerminate() {
		if (mLocationClient != null && this.mLocationClient.isStarted()) {
			mLocationClient.stop();
			mLocationClient = null;
		}
		super.onTerminate();
	}

	private void setLocationOption() {
		LocationClientOption option = new LocationClientOption();
		option.setOpenGps(true);
		option.setIsNeedAddress(true);// 返回的定位结果包含地址信息
		option.setAddrType("all");// 返回的定位结果包含地址信息
		option.setCoorType("bd09ll");// 返回的定位结果是百度经纬度,默认值gcj02
		option.setScanSpan(60* 1000);// 设置发起定位请求的间隔时间为5000ms
		//option.disableCache(true);// 禁止启用缓存定位
		option.setPoiNumber(5); // 最多返回POI个数
		option.setPoiDistance(1000); // poi查询距离
		option.setPoiExtraInfo(true); // 是否需要POI的电话和地址等详细信息
		mLocationClient.setLocOption(option);
	}

	class MyLocationListener implements BDLocationListener {

		@Override
		public void onReceiveLocation(BDLocation location) {
			if (location == null) {
				return;
			}

			Intent intent = new Intent(Const.KEY_BROAD_LOCATION);
			intent.putExtra(Const.DATA_BROAD_LOCATION, location);
			mAppContext.sendBroadcast(intent);
		}

		@Override
		public void onReceivePoi(BDLocation poiLocation) {

		}

	}
}
