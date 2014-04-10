package com.seekon.yougouhui.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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
}
