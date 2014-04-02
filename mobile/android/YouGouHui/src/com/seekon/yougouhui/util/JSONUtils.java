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

	public static String getJSONStringValue(JSONObject jsonObj, String key) {
		try {
			return jsonObj.getString(key);
		} catch (JSONException e) {
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
}
