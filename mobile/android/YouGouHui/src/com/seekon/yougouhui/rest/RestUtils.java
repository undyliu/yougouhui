package com.seekon.yougouhui.rest;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class RestUtils {

	private RestUtils() {
	}

	/**
	 * 读取输入流
	 * 
	 * @param in
	 * @return
	 * @throws IOException
	 */
	public static byte[] readStream(InputStream in) throws IOException {
		byte[] buf = new byte[1024];
		int count = 0;
		ByteArrayOutputStream out = new ByteArrayOutputStream(1024);
		while ((count = in.read(buf)) != -1)
			out.write(buf, 0, count);
		return out.toByteArray();
	}

	/**
	 * 将map类型的参数转换为byte类型的数组，支持请求体的格式要求
	 * 
	 * @param params
	 * @return
	 */
	public static byte[] wrapRequestBody(Map<String, String> params) {
		if (params == null || params.isEmpty()) {
			return null;
		}

		StringBuffer result = new StringBuffer();
		Iterator<Entry<String, String>> iterator = params.entrySet().iterator();
		while (iterator.hasNext()) {
			Entry<String, String> entry = iterator.next();
			result.append("&" + entry.getKey() + "=" + entry.getValue());
		}
		return result.substring(1).getBytes();
	}
}
