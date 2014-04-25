package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

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

/**
 * 修改用户基本信息：昵称、手机号、密码等
 * 
 * @author undyliu
 * 
 */
public class PutUserNameMethod extends JSONObjResourceMethod {

	private static final URI PUT_USER_NAME_URI = URI.create(Const.SERVER_APP_URL
			+ "/updateUserName");

	private String nickName = null;

	public PutUserNameMethod(Context context, String nickName) {
		super(context);
		this.nickName = nickName;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_UUID, RunEnv.getInstance().getUser().getUuid());
		params.put(COL_NAME_NAME, nickName);

		return new BaseRequest(Method.PUT, PUT_USER_NAME_URI, null, params);
	}

}
