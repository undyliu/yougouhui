package com.seekon.yougouhui.rest;

import java.io.BufferedInputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import android.os.Build;

public abstract class RestClient {

	public Response execute(Request request) {
		HttpURLConnection conn = null;
		Response response = null;
		int status = -1;
		try {

			URL url = request.getRequestUri().toURL();
			conn = (HttpURLConnection) url.openConnection();
			
			if (Build.VERSION.SDK != null && Build.VERSION.SDK_INT > 13) {
				//conn.setRequestProperty("Connection", "close");
			}
			
			processHttpConnection(conn, request);

			status = conn.getResponseCode();

			if (conn.getContentLength() > 0) {
				BufferedInputStream in = new BufferedInputStream(conn.getInputStream());
				byte[] body = RestUtils.readStream(in);
				response = new Response(conn.getResponseCode(), conn.getHeaderFields(),
						body);
			} else {
				response = new Response(status, conn.getHeaderFields(), new byte[] {});
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			if (conn != null)
				conn.disconnect();
		}

		if (response == null) {
			response = new Response(status, new HashMap<String, List<String>>(),
					new byte[] {});
		}

		return response;
	}

	protected abstract void processHttpConnection(HttpURLConnection conn,
			Request request) throws Exception;
}
