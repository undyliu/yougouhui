package com.seekon.yougouhui.func.user;

import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;

public class UserProcessor extends ContentProcessor {

	public UserProcessor(Context mContext) {
		super(mContext, UserData.COL_NAMES, UserConst.CONTENT_URI);
	}

	public RestMethodResult<JSONObjResource> registerUser(Map<String, String> user) {
		return (RestMethodResult)this.execMethod(new RegisterUserMethod(mContext, user));
	}
}
