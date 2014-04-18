package com.seekon.yougouhui.rest;

import java.net.HttpURLConnection;

public class BaseRestClient extends RestClient {

	@Override
	protected void processHttpConnection(HttpURLConnection conn, Request request)
			throws Exception {
		if (request.getHeaders() != null) {
			for (String header : request.getHeaders().keySet()) {
				for (String value : request.getHeaders().get(header)) {
					conn.addRequestProperty(header, value);
				}
			}
		}

		conn.setConnectTimeout(5 * 1000);// 超时时间3秒
		//conn.setReadTimeout(5 * 1000);

		switch (request.getMethod()) {
		case GET:
			conn.setRequestMethod("GET");
			conn.setDoOutput(false);
			break;
		case DELETE:
			conn.setRequestMethod("DELETE");
			conn.setDoOutput(false);
			break;
		case PUT:
			conn.setRequestMethod("PUT");
			putRequestDataToConnection(conn, request);
			break;
		case POST:
			conn.setRequestMethod("POST");
			putRequestDataToConnection(conn, request);
		default:
			break;
		}

	}

	private void putRequestDataToConnection(HttpURLConnection conn,
			Request request) throws Exception {
		byte[] payload = request.getBody();

		conn.setDoOutput(true);
		conn.setFixedLengthStreamingMode(payload.length);
		conn.getOutputStream().write(payload);
	}
}
