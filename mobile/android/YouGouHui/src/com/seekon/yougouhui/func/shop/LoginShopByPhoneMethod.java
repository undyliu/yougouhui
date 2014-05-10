package com.seekon.yougouhui.func.shop;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class LoginShopByPhoneMethod extends JSONObjResourceMethod {

	private static final URI LOGIN_URI = URI.create(Const.SERVER_APP_URL
			+ "/loginShopByPhone");

	private String phone;
	private String pwd;

	public LoginShopByPhoneMethod(Context context, String phone, String pwd) {
		super(context);
		this.phone = phone;
		this.pwd = pwd;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(UserConst.COL_NAME_PHONE, phone);
		params.put(UserConst.COL_NAME_PWD, pwd);
		return new BaseRequest(Method.POST, LOGIN_URI, null, params);
	}
}