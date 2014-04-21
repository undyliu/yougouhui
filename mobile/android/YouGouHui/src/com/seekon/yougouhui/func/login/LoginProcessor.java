package com.seekon.yougouhui.func.login;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.spi.ILoginProcessor;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.Logger;

public class LoginProcessor extends ContentProcessor implements ILoginProcessor {

	private static final String TAG = LoginProcessor.class.getSimpleName();

	private static ILoginProcessor instance = null;
	private final static Object lock = new Object();

	public static ILoginProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (ILoginProcessor) proxy.bind(new LoginProcessor(mContext));
			}
		}
		return instance;
	}

	private LoginProcessor(Context mContext) {
		super(mContext, UserData.COL_NAMES, UserConst.CONTENT_URI);
	}

	@Override
	public RestMethodResult<JSONObjResource> login(String phone, String pwd) {
		return (RestMethodResult) this.execMethod(new LoginMethod(mContext, phone,
				pwd));
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result) {
		if (result == null) {
			return;
		}
		Resource resource = result.getResource();
		if (resource instanceof JSONObjResource) {
			boolean authed = false;
			try {
				authed = ((JSONObjResource) resource)
						.getBoolean(LoginConst.LOGIN_RESULT_AUTHED);
				if (authed) {
					JSONObject user = null;
					user = ((JSONObjResource) resource)
							.getJSONObject(LoginConst.LOGIN_RESULT_USER);
					if (user != null) {
						super.updateContentProvider(user, colNames, contentUri);
					}
				}
			} catch (JSONException e) {
				Logger.error(TAG, e.getMessage(), e);
				throw new RuntimeException(e);
			}
		}
	}

}
