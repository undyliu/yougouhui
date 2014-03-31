package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class PutUserPwdMethod extends JSONObjResourceMethod {

	private static final URI PUT_USER_PWD_URI = URI.create(Const.SERVER_APP_URL
			+ "/updateUserPwd");

	private String pwd = null;

	public PutUserPwdMethod(Context context, String pwd) {
		super(context);
		this.pwd = pwd;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_UUID,
				RunEnv.getInstance().getUser().getAsString(COL_NAME_UUID));
		params.put(COL_NAME_PWD, pwd);

		return new BaseRequest(Method.PUT, PUT_USER_PWD_URI, null, params);
	}

}
