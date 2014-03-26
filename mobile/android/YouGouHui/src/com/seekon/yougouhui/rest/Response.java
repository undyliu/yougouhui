package com.seekon.yougouhui.rest;

import java.util.List;
import java.util.Map;

public class Response {

	/**
	 * The HTTP status code
	 */
	private int status;

	/**
	 * The HTTP headers received in the response
	 */
	private Map<String, List<String>> headers;

	/**
	 * The response body, if any
	 */
	private byte[] body;

	protected Response(int status, Map<String, List<String>> headers, byte[] body) {
		this.status = status;
		this.headers = headers;
		this.body = body;
	}

	public int getStatus() {
		return status;
	}

	public Map<String, List<String>> getHeaders() {
		return headers;
	}

	public byte[] getBody() {
		return body;
	}

}
