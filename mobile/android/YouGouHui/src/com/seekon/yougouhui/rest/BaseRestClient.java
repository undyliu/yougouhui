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

		switch (request.getMethod()) {
		case GET:
			conn.setDoOutput(false);
			break;
		case POST:
			byte[] payload = request.getBody();
			conn.setDoOutput(true);
			conn.setFixedLengthStreamingMode(payload.length);
			conn.getOutputStream().write(payload);
		default:
			break;
		}
	}

}
