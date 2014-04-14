package com.seekon.yougouhui.func.user;

import java.util.List;

import org.json.JSONObject;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.util.JSONUtils;

public class UserUtils {
	private UserUtils() {
	}

	public static UserEntity createFromJSONObject(JSONObject jsonObj) {
		UserEntity user = new UserEntity();
		user.setName(JSONUtils.getJSONStringValue(jsonObj,
				UserConst.COL_NAME_USER_NAME));
		user.setUuid(JSONUtils.getJSONStringValue(jsonObj, DataConst.COL_NAME_UUID));
		user.setPhone(JSONUtils.getJSONStringValue(jsonObj,
				UserConst.COL_NAME_PHONE));
		user.setPhoto(JSONUtils.getJSONStringValue(jsonObj,
				UserConst.COL_NAME_USER_ICON));
		user.setPwd(JSONUtils.getJSONStringValue(jsonObj, UserConst.COL_NAME_PWD));
		user.setRegisterTime(JSONUtils.getJSONStringValue(jsonObj,
				UserConst.COL_NAME_REGISTER_TIME));
		return user;
	}

	public static UserEntity updateUserEntity(UserEntity user, JSONObject jsonObj) {
		if (jsonObj == null) {
			return user;
		}
		List<String> keys = JSONUtils.getKeyList(jsonObj);
		if (keys.contains(UserConst.COL_NAME_USER_NAME)) {
			user.setName(JSONUtils.getJSONStringValue(jsonObj,
					UserConst.COL_NAME_USER_NAME));
		}
		if (keys.contains(UserConst.COL_NAME_PHONE)) {
			user.setPhone(JSONUtils.getJSONStringValue(jsonObj,
					UserConst.COL_NAME_PHONE));
		}
		if (keys.contains(UserConst.COL_NAME_USER_ICON)) {
			user.setPhoto(JSONUtils.getJSONStringValue(jsonObj,
					UserConst.COL_NAME_USER_ICON));
		}
		if (keys.contains(UserConst.COL_NAME_PWD)) {
			user.setPwd(JSONUtils.getJSONStringValue(jsonObj, UserConst.COL_NAME_PWD));
		}
		return user;
	}

	public static JSONObject toJSONObject(UserEntity user) {
		JSONObject jsonObj = new JSONObject();
		JSONUtils.putJSONValue(jsonObj, DataConst.COL_NAME_UUID, user.getUuid());
		JSONUtils.putJSONValue(jsonObj, UserConst.COL_NAME_PHONE, user.getPhone());
		JSONUtils.putJSONValue(jsonObj, UserConst.COL_NAME_USER_NAME,
				user.getName());
		JSONUtils.putJSONValue(jsonObj, UserConst.COL_NAME_PWD, user.getPwd());
		JSONUtils.putJSONValue(jsonObj, UserConst.COL_NAME_USER_ICON,
				user.getPhoto());
		return jsonObj;
	}
}
