package com.seekon.yougouhui.func.login;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.BaseRestMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

/**
 * 登录rest访问
 * 
 * @author undyliu
 * 
 */
public class LoginMethod extends BaseRestMethod<JSONObjResource> {

	private Context context = null;
	private String phone;
	private String pwd;

	private static final URI LOGIN_URI = URI.create(Const.SERVER_APP_URL
			+ "/login");

	public LoginMethod(Context context, String phone, String pwd) {
		super();
		this.context = context;
		this.phone = phone;
		this.pwd = pwd;
	}

	@Override
	protected Context getContext() {
		return context;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(UserConst.COL_NAME_PHONE, phone);
		params.put(UserConst.COL_NAME_PWD, pwd);
		return new BaseRequest(Method.POST, LOGIN_URI, null, params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(responseBody);
	}

}
