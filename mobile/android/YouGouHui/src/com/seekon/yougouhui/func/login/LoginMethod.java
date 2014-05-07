package com.seekon.yougouhui.func.login;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.BaseRestMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.Response;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ConnectionDetector;
import com.seekon.yougouhui.util.Logger;

/**
 * 登录rest访问
 * 
 * @author undyliu
 * 
 */
public class LoginMethod extends BaseRestMethod<JSONObjResource> {

	private final static String TAG = LoginMethod.class.getSimpleName();

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
	public RestMethodResult<JSONObjResource> execute() {
		ConnectionDetector detector = ConnectionDetector.getInstance(getContext());
		if (!detector.isConnectingToInternet()) {// 检测网络是否开启，可用
			return new RestMethodResult<JSONObjResource>(
					RestStatus.NETWORK_NOT_OPENED, getContext().getString(
							R.string.network_not_open), null);
		}

		Request request = buildRequest();
		addUserHeaders(request);
		
		Response response = null;
		try {
			response = doRequest(request);
		} catch (Exception ex) {
			Logger.warn(TAG, ex.getMessage());
			int status = RestStatus.SERVER_NOT_AVAILABLE;
			String statusMsg = getContext().getString(R.string.server_not_available);
			return new RestMethodResult<JSONObjResource>(status, statusMsg, null);
		}

		List<String> cookieValues = response.getHeaders().get("Set-Cookie");
		if (cookieValues != null && cookieValues.size() > 0) {
			String cookieValue = cookieValues.get(0);
			if (cookieValue != null && cookieValue.length() > 0) {
				RunEnv.getInstance().setSessionId(
						cookieValue.substring(0, cookieValue.indexOf(";")));
			}
		}
		try {
			return buildResult(response);
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
			int status = RestStatus.RUNTIME_ERROR;
			String statusMsg = getContext().getString(R.string.runtime_error);
			return new RestMethodResult<JSONObjResource>(status, statusMsg, null);
		}
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
