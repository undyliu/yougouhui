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
		byte[] payload = null;

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
			payload = request.getBody();
			conn.setRequestMethod("PUT");
			conn.setDoOutput(true);
			conn.setFixedLengthStreamingMode(payload.length);
			conn.getOutputStream().write(payload);
			break;
		case POST:
			payload = request.getBody();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setFixedLengthStreamingMode(payload.length);
			conn.getOutputStream().write(payload);
		default:
			break;
		}
	}

}
