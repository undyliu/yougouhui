package com.seekon.yougouhui.util;

import org.json.JSONObject;

import com.seekon.yougouhui.func.LocationEntity;

public class LocationUtils {
	private static final String TAG = LocationUtils.class.getSimpleName();

	public static final String key_latitude = "latitude";
	public static final String key_lontitude = "lontitude";
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
				location1.getLontitude(), location2.getLatitude(),
				location2.getLontitude());
	}

	public static JSONObject toJSONObject(LocationEntity location) {
		JSONObject jsonObj = new JSONObject();
		try {
			jsonObj.put(key_latitude, location.getLatitude());
			jsonObj.put(key_lontitude, location.getLontitude());
			jsonObj.put(key_radius, location.getRadius());
			jsonObj.put(key_address, location.getAddress());
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		}
		return jsonObj;
	}

	public static LocationEntity fromJSONObject(JSONObject jsonObj) {
		LocationEntity location = new LocationEntity();
		try {
			location.setLatitude(jsonObj.getDouble(key_latitude));
			location.setLontitude(jsonObj.getDouble(key_lontitude));
			location.setRadius(jsonObj.getDouble(key_radius));
			location.setAddress(jsonObj.getString(key_address));
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		}
		return location;
	}
}
