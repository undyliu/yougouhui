package com.seekon.yougouhui.func.login;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.util.Logger;

public class LoginProcessor extends ContentProcessor {

	private static final String TAG = LoginProcessor.class.getSimpleName();

	public LoginProcessor(Context mContext) {
		super(mContext, UserData.COL_NAMES, UserConst.CONTENT_URI);
	}

	@SuppressWarnings("rawtypes")
	public RestMethodResult<JSONObjResource> login(String phone, String pwd) {
		return (RestMethodResult) this.execMethod(new LoginMethod(mContext, phone,
				pwd));
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result, String[] colNames) {
		if (result == null) {
			return;
		}
		Resource resource = result.getResource();
		if (resource instanceof JSONObjResource) {
			boolean authed = false;
			try {
				authed = ((JSONObjResource) resource)
						.getBoolean(LoginConst.LOGIN_RESULT_AUTHED);
			} catch (JSONException e) {
				Logger.debug(TAG, e.getMessage());
			}

			if (authed) {
				JSONObject user = null;
				try {
					user = ((JSONObjResource) resource)
							.getJSONObject(LoginConst.LOGIN_RESULT_USER);
				} catch (JSONException e) {
					Logger.debug(TAG, e.getMessage());
				}
				if (user != null) {
					try {
						super.updateContentProvider(user, colNames, contentUri);
					} catch (JSONException e) {
						Logger.error(TAG, e.getMessage(), e);
					}
				}
			}
		}
	}

}
