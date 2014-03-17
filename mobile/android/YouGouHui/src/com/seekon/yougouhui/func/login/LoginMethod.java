package com.seekon.yougouhui.func.login;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.db.UserHelper;
import com.seekon.yougouhui.rest.AbstractRestMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

/**
 * 登录rest访问
 * @author undyliu
 *
 */
public class LoginMethod extends AbstractRestMethod<JSONObjResource> {

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
		String params = UserHelper.COL_NAME_PHONE + "=" + phone + "&"
				+ UserHelper.COL_NAME_PWD + "=" + pwd;
		return new Request(Method.POST, LOGIN_URI, null, params.getBytes());
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(responseBody);
	}

}
