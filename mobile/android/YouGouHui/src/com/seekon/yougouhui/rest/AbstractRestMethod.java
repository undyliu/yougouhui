package com.seekon.yougouhui.rest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.sercurity.AuthorizationManager;
import com.seekon.yougouhui.sercurity.RequestSigner;
import com.seekon.yougouhui.service.ConnectionDetector;
import com.seekon.yougouhui.util.Logger;

public abstract class AbstractRestMethod<T extends Resource> implements
		RestMethod<T> {

	private static final String TAG = AbstractRestMethod.class.getSimpleName();

	private static final String DEFAULT_ENCODING = "UTF-8";

	public RestMethodResult<T> execute() {

		ConnectionDetector detector = ConnectionDetector.getInstance(getContext());
		if (!detector.isConnectingToInternet()) {// 检测网络是否开启，可用
			return new RestMethodResult<T>(RestStatus.NETWORK_NOT_OPENED,
					getContext().getString(R.string.network_not_open), null);
		}

		Request request = buildRequest();
		if (requiresAuthorization()) {
			RequestSigner signer = AuthorizationManager.getInstance(getContext());
			signer.authorize(request);
		}
		
		addUserHeaders(request);
		
		Response response = null;
		try {
			response = doRequest(request);
		} catch (Exception ex) {
			Logger.warn(TAG, ex.getMessage());
			int status = RestStatus.SERVER_NOT_AVAILABLE;
			String statusMsg = getContext().getString(R.string.server_not_available);
			return new RestMethodResult<T>(status, statusMsg, null);
		}
		try {
			return buildResult(response);
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
			int status = RestStatus.RUNTIME_ERROR;
			String statusMsg = getContext().getString(R.string.runtime_error);
			return new RestMethodResult<T>(status, statusMsg, null);
		}
	}

	protected abstract Context getContext();

	/**
	 * Subclasses can overwrite for full control, eg. need to do special
	 * inspection of response headers, etc.
	 * 
	 * @param response
	 * @return
	 */
	protected RestMethodResult<T> buildResult(Response response) throws Exception {

		int status = response.getStatus();
		String statusMsg = "";
		String responseBody = null;
		T resource = null;

		responseBody = new String(response.getBody(),
				getCharacterEncoding(response.getHeaders()));
		resource = parseResponseBody(responseBody);

		return new RestMethodResult<T>(status, statusMsg, resource);
	}

	protected void addUserHeaders(Request request){
		UserEntity user = RunEnv.getInstance().getUser();
		List<String> userInfo = new ArrayList<String>();
		userInfo.add(user.getPhone());
		request.addHeader(UserConst.COL_NAME_PHONE, userInfo);
	}
	
	protected abstract Request buildRequest();

	protected boolean requiresAuthorization() {
		return true;
	}

	protected abstract T parseResponseBody(String responseBody) throws Exception;

	protected abstract Response doRequest(Request request) throws Exception;

	private String getCharacterEncoding(Map<String, List<String>> headers) {
		return DEFAULT_ENCODING;
	}

}
