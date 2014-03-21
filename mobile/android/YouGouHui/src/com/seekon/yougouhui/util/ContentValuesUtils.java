package com.seekon.yougouhui.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentValues;

public class ContentValuesUtils {

	public static ContentValues fromMap(Map<String, ?> data, String[] keys) {
		ContentValues result = new ContentValues();
		if (keys == null) {
			Set<String> keySet = data.keySet();
			keys = keySet.toArray(new String[keySet.size()]);
		}
		if (keys != null) {
			for (String key : keys) {
				setContentValue(result, key, data.get(key));
			}
		}
		return result;
	}

	/**
	 * 将jsonObject转换为ContentValues对象
	 * 
	 * @param jsonObj
	 * @param keys
	 * @return
	 * @throws JSONException
	 */
	public static ContentValues fromJSONObject(JSONObject jsonObj, String[] keys)
			throws JSONException {
		ContentValues result = new ContentValues();
		if (keys != null) {
			for (int i = 0; i < keys.length; i++) {
				setContentValue(result, keys[i], jsonObj.get(keys[i]));
			}
		} else {
			Iterator<String> iterator = jsonObj.keys();
			while (iterator.hasNext()) {
				String key = iterator.next();
				setContentValue(result, key, jsonObj.get(key));
			}
		}

		return result;
	}

	static void setContentValue(ContentValues values, String key, Object value) {
		if (value == null) {
			values.putNull(key);
		} else if (value instanceof String) {
			if (value.toString().equalsIgnoreCase("null")) {
				values.putNull(key);
			} else {
				values.put(key, (String) value);
			}
		} else if (value instanceof Integer) {
			values.put(key, (Integer) value);
		} else if (value instanceof Boolean) {
			values.put(key, (Boolean) value);
		} else if (value instanceof Double) {
			values.put(key, (Double) value);
		} else {
			if (value.toString().equalsIgnoreCase("null")) {
				values.putNull(key);
			} else {
				values.put(key, value.toString());
			}
		}
	}

	public static Map toMap(ContentValues values, String[] keys){
		Map result = new HashMap();
		if(keys == null){
			Set keySet = values.keySet();
			keys = values.keySet().toArray(new String[keySet.size()]);
		}
		for(String key : keys){
			result.put(key, values.get(key));
		}
		return result;
	}
}
