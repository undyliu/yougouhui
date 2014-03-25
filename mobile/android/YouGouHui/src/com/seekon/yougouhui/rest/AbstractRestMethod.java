package com.seekon.yougouhui.rest;

import java.util.List;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.sercurity.AuthorizationManager;
import com.seekon.yougouhui.sercurity.RequestSigner;

public abstract class AbstractRestMethod<T extends Resource> implements RestMethod<T> {

	private static final String DEFAULT_ENCODING = "UTF-8";

	public RestMethodResult<T> execute() {

		Request request = buildRequest();
		if (requiresAuthorization()) {
			RequestSigner signer = AuthorizationManager.getInstance(getContext());
			signer.authorize(request);
		}
		Response response = doRequest(request);
		return buildResult(response);
	}
	
	protected abstract Context getContext();

	/**
	 * Subclasses can overwrite for full control, eg. need to do special
	 * inspection of response headers, etc.
	 * 
	 * @param response
	 * @return
	 */
	protected RestMethodResult<T> buildResult(Response response) {

		int status = response.getStatus();
		String statusMsg = "";
		String responseBody = null;
		T resource = null;

		try {
			responseBody = new String(response.getBody(), getCharacterEncoding(response.getHeaders()));
			resource = parseResponseBody(responseBody);
		} catch (Exception ex) {
			// TODO Should we set some custom status code?
			status = 506; // spec only defines up to 505
			statusMsg = ex.getMessage();
		}
		return new RestMethodResult<T>(status, statusMsg, resource);
	}

	protected abstract Request buildRequest();
	
	protected boolean requiresAuthorization() {
		return true;
	}

	protected abstract T parseResponseBody(String responseBody) throws Exception;

	protected abstract Response doRequest(Request request);

	private String getCharacterEncoding(Map<String, List<String>> headers) {
		return DEFAULT_ENCODING;
	}

}
