package com.seekon.yougouhui.func.profile.shop;

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

public class LoginShopMethod extends JSONObjResourceMethod{

	private static final URI LOGIN_URI = URI.create(Const.SERVER_APP_URL
			+ "/loginShop");
	
	private String userId;
	private String pwd;

	public LoginShopMethod(Context context, String userId, String pwd) {
		super(context);
		this.userId = userId;
		this.pwd = pwd;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(ShopConst.NAME_REQUEST_PARAMETER_USER_ID, userId);
		params.put(UserConst.COL_NAME_PWD, pwd);
		return new BaseRequest(Method.POST, LOGIN_URI, null, params);
	}

}
