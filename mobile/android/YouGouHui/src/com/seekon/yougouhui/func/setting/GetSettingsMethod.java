package com.seekon.yougouhui.func.setting;

import java.net.URI;

import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.JSONUtils;

public class GetSettingsMethod extends JSONArrayResourceMethod {

	private final URI GET_SETTINGS_URI = URI.create(Const.SERVER_APP_URL
			+ "/getSettings");

	public GetSettingsMethod(Context context) {
		super(context);
	}

	@Override
	protected Request buildRequest() {
		return new BaseRequest(Method.GET, GET_SETTINGS_URI, null, null);
	}

	@Override
	protected JSONArrayResource parseResponseBody(String responseBody)
			throws Exception {
		JSONArrayResource resource = super.parseResponseBody(responseBody);
		for (int i = 0; i < resource.length(); i++) {
			JSONObject jsonObj = resource.getJSONObject(i);
			JSONUtils.putJSONValue(jsonObj, SettingConst.COL_NAME_USER_ID, RunEnv
					.getInstance().getUser().getUuid());
		}
		return resource;
	}
}
