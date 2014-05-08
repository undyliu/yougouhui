package com.seekon.yougouhui.util;

import org.json.JSONObject;

import com.baidu.location.LocationClientOption;
import com.seekon.yougouhui.func.LocationEntity;

public class LocationUtils {
	private static final String TAG = LocationUtils.class.getSimpleName();

	public static final String key_latitude = "latitude";
	public static final String key_longitude = "longitude";
	public static final String key_radius = "radius";
	public static final String key_address = "address";

	private LocationUtils() {

	}

	private static final double EARTH_RADIUS = 6378137;

	private static double rad(double d) {
		return d * Math.PI / 180.0;
	}

	/**
	 * 根据两点间经纬度坐标（double值），计算两点间距离，
	 * 
	 * @param lat1
	 * @param lng1
	 * @param lat2
	 * @param lng2
	 * @return 距离：单位为米
	 */
	public static double distanceOfTwoPoints(double lat1, double lng1,
			double lat2, double lng2) {
		double radLat1 = rad(lat1);
		double radLat2 = rad(lat2);
		double a = radLat1 - radLat2;
		double b = rad(lng1) - rad(lng2);
		double s = 2 * Math
				.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1)
						* Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
		s = s * EARTH_RADIUS;
		s = Math.round(s * 10000) / 10000;
		return s;
	}

	public static double distance(LocationEntity location1,
			LocationEntity location2) {
		return distanceOfTwoPoints(location1.getLatitude(),
				location1.getLongitude(), location2.getLatitude(),
				location2.getLongitude());
	}

	public static JSONObject toJSONObject(LocationEntity location) {
		JSONObject jsonObj = new JSONObject();
		try {
			jsonObj.put(key_latitude, location.getLatitude());
			jsonObj.put(key_longitude, location.getLongitude());
			jsonObj.put(key_radius, location.getRadius());
			jsonObj.put(key_address, location.getAddress());
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		}
		return jsonObj;
	}

	public static LocationEntity fromJSONObject(JSONObject jsonObj) {
		if(jsonObj == null){
			return null;
		}
		LocationEntity location = new LocationEntity();
		try {
			location.setLatitude(jsonObj.getDouble(key_latitude));
			location.setLongitude(jsonObj.getDouble(key_longitude));
			location.setRadius(jsonObj.getDouble(key_radius));
			location.setAddress(jsonObj.getString(key_address));
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		}
		return location;
	}

	public static LocationClientOption getDefaultLocationOption() {
		LocationClientOption option = new LocationClientOption();
		option.setOpenGps(true);
		option.setIsNeedAddress(true);// 返回的定位结果包含地址信息
		option.setAddrType("all");// 返回的定位结果包含地址信息
		option.setCoorType("bd09ll");// 返回的定位结果是百度经纬度,默认值gcj02
		option.setScanSpan(60 * 1000);// 设置发起定位请求的间隔时间为5000ms
		// option.disableCache(true);// 禁止启用缓存定位
		option.setPoiNumber(5); // 最多返回POI个数
		option.setPoiDistance(1000); // poi查询距离
		option.setPoiExtraInfo(true); // 是否需要POI的电话和地址等详细信息
		return option;
	}
}
