package com.seekon.yougouhui.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONException;
import org.json.JSONObject;

public class JSONUtils {
	private static final String TAG = JSONUtils.class.getSimpleName();

	private JSONUtils() {
	}

	public static String[] getKeys(JSONObject json) {
		List<String> keys = getKeyList(json);
		return keys.toArray(new String[keys.size()]);
	}

	public static List<String> getKeyList(JSONObject json) {
		List<String> keys = new ArrayList<String>();
		Iterator<String> keyItera = json.keys();
		while (keyItera.hasNext()) {
			keys.add(keyItera.next());
		}
		return keys;
	}

	public static void putJSONValue(JSONObject jsonObj, String key, Object value) {
		try {
			jsonObj.put(key, value);
		} catch (JSONException e) {
			Logger.warn(TAG, e.getMessage());
		}
	}

	public static String getJSONStringValue(JSONObject jsonObj, String key) {
		try {
			String value = jsonObj.getString(key);
			return value.equalsIgnoreCase("null") ? null : value;
		} catch (JSONException e) {
			Logger.warn(TAG, e.getMessage());
		}
		return null;
	}

	public static JSONObject cloneJSONObject(JSONObject from, String[] keys)
			throws JSONException {
		if (from == null) {
			return null;
		}

		if (keys == null) {
			keys = getKeys(from);
		}
		JSONObject obj = new JSONObject();
		for (String key : keys) {
			obj.put(key, from.get(key));
		}
		return obj;
	}

	public static JSONObject createJSONObject(String value) {
		if (value == null) {
			return null;
		}
		try {
			return new JSONObject(value);
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage(), e);
		}
		return null;
	}

	public static void mergerMap(JSONObject jsonObj, Map params, boolean replace) {
		Iterator<String> keys = params.keySet().iterator();
		while (keys.hasNext()) {
			String key = keys.next();
			if (!jsonObj.has(key) || replace) {
				JSONUtils.putJSONValue(jsonObj, key, params.get(key));
			}
		}
	}
}
