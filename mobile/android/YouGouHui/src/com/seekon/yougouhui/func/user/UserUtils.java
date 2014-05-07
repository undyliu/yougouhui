package com.seekon.yougouhui.func.user;

import java.util.List;
import java.util.UUID;

import org.apache.http.client.UserTokenHandler;
import org.json.JSONObject;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.util.DeviceUtils;
import com.seekon.yougouhui.util.JSONUtils;

public class UserUtils {
	private UserUtils() {
	}

	public static UserEntity createFromJSONObject(JSONObject jsonObj) {
		UserEntity user = new UserEntity();
		user.setName(JSONUtils.getJSONStringValue(jsonObj, UserConst.COL_NAME_NAME));
		user.setUuid(JSONUtils.getJSONStringValue(jsonObj, DataConst.COL_NAME_UUID));
		user.setPhone(JSONUtils.getJSONStringValue(jsonObj,
				UserConst.COL_NAME_PHONE));
		user.setPhoto(JSONUtils.getJSONStringValue(jsonObj,
				UserConst.COL_NAME_USER_ICON));
		user.setPwd(JSONUtils.getJSONStringValue(jsonObj, UserConst.COL_NAME_PWD));
		user.setRegisterTime(JSONUtils.getJSONStringValue(jsonObj,
				UserConst.COL_NAME_REGISTER_TIME));
		user.setType(JSONUtils.getJSONStringValue(jsonObj, DataConst.COL_NAME_TYPE));
		return user;
	}

	public static UserEntity updateUserEntity(UserEntity user, JSONObject jsonObj) {
		if (jsonObj == null) {
			return user;
		}
		List<String> keys = JSONUtils.getKeyList(jsonObj);
		if (keys.contains(UserConst.COL_NAME_NAME)) {
			user.setName(JSONUtils.getJSONStringValue(jsonObj,
					UserConst.COL_NAME_NAME));
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
		JSONUtils.putJSONValue(jsonObj, UserConst.COL_NAME_NAME, user.getName());
		JSONUtils.putJSONValue(jsonObj, UserConst.COL_NAME_PWD, user.getPwd());
		JSONUtils.putJSONValue(jsonObj, UserConst.COL_NAME_USER_ICON,
				user.getPhoto());
		return jsonObj;
	}
	
	public static UserEntity getAnonymousUser(){
		String phone = DeviceUtils.getTelephoneNumber();

		UserEntity user = new UserEntity();
		user.setUuid(UUID.randomUUID().toString());
		user.setPhone(phone);
		user.setName("匿名" + phone);
		user.setRegisterTime(String.valueOf(System.currentTimeMillis()));
		return user;
	}
	
	public static boolean isAnonymousUser(){
		UserEntity user = RunEnv.getInstance().getUser();
		return user == null || UserConst.TYPE_USER_ANONYMOUS.equals(user.getType());
	}
}
