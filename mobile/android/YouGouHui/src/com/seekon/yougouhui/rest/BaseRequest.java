package com.seekon.yougouhui.rest;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BaseRequest implements Request {

	private URI requestUri;
	private Map<String, List<String>> headers;
	private Map<String, String> parameters;
	private Method method;

	public BaseRequest(Method method, String requestUri,
			Map<String, List<String>> headers, Map<String, String> parameters) {
		super();
		this.requestUri = URI.create(requestUri);
		this.headers = headers;
		this.parameters = parameters;
		this.method = method;
	}

	public BaseRequest(Method method, URI requestUri,
			Map<String, List<String>> headers, Map<String, String> parameters) {
		super();
		this.requestUri = requestUri;
		this.headers = headers;
		this.parameters = parameters;
		this.method = method;
	}

	@Override
	public Method getMethod() {
		return method;
	}

	@Override
	public URI getRequestUri() {
		return requestUri;
	}

	@Override
	public Map<String, List<String>> getHeaders() {
		return headers;
	}

	@Override
	public byte[] getBody() {
		return RestUtils.wrapRequestBody(parameters);
	}

	@Override
	public Map<String, String> getParameters() {
		return parameters;
	}

	@Override
	public void addHeader(String key, List<String> value) {
		if (headers == null) {
			headers = new HashMap<String, List<String>>();
		}
		headers.put(key, value);
	}

}
