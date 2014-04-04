package com.seekon.yougouhui.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;

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
			return jsonObj.getString(key);
		} catch (JSONException e) {
			Logger.warn(TAG, e.getMessage());
		}
		return null;
	}

	public static UserEntity createUserEntity(JSONObject jsonObj) {
		UserEntity user = new UserEntity();
		user.setName(getJSONStringValue(jsonObj, UserConst.COL_NAME_USER_NAME));
		user.setUuid(getJSONStringValue(jsonObj, DataConst.COL_NAME_UUID));
		user.setPhone(getJSONStringValue(jsonObj, UserConst.COL_NAME_PHONE));
		user.setPhoto(getJSONStringValue(jsonObj, UserConst.COL_NAME_USER_ICON));
		user.setPwd(getJSONStringValue(jsonObj, UserConst.COL_NAME_PWD));
		user.setRegisterTime(getJSONStringValue(jsonObj,
				UserConst.COL_NAME_REGISTER_TIME));
		return user;
	}

	public static UserEntity updateUserEntity(UserEntity user, JSONObject jsonObj) {
		if (jsonObj == null) {
			return user;
		}
		List<String> keys = getKeyList(jsonObj);
		if (keys.contains(UserConst.COL_NAME_USER_NAME)) {
			user.setName(getJSONStringValue(jsonObj, UserConst.COL_NAME_USER_NAME));
		}
		if (keys.contains(UserConst.COL_NAME_PHONE)) {
			user.setPhone(getJSONStringValue(jsonObj, UserConst.COL_NAME_PHONE));
		}
		if (keys.contains(UserConst.COL_NAME_USER_ICON)) {
			user.setPhoto(getJSONStringValue(jsonObj, UserConst.COL_NAME_USER_ICON));
		}
		if (keys.contains(UserConst.COL_NAME_PWD)) {
			user.setPwd(getJSONStringValue(jsonObj, UserConst.COL_NAME_PWD));
		}
		return user;
	}

	public static JSONObject fromUserEntity(UserEntity user) {
		JSONObject jsonObj = new JSONObject();
		putJSONValue(jsonObj, DataConst.COL_NAME_UUID, user.getUuid());
		putJSONValue(jsonObj, UserConst.COL_NAME_PHONE, user.getPhone());
		putJSONValue(jsonObj, UserConst.COL_NAME_USER_NAME, user.getName());
		putJSONValue(jsonObj, UserConst.COL_NAME_PWD, user.getPwd());
		putJSONValue(jsonObj, UserConst.COL_NAME_USER_ICON, user.getPhoto());
		return jsonObj;
	}
}
