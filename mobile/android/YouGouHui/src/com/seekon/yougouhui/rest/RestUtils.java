package com.seekon.yougouhui.rest;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.AsyncRestRequestTask;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;

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
	static byte[] readStream(InputStream in) throws IOException {
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
	static byte[] wrapRequestBody(Map<String, String> params) {
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

	public static void executeAsyncRestTask(Context context,
			AbstractRestTaskCallback<?> callback) {
		AsyncRestRequestTask<?> task = new AsyncRestRequestTask(context, callback);
		task.execute((Void) null);
	}

	private static String processResultErrorMessage(JSONObject resource,
			String defStatusMsg) throws Exception {
		if (resource.has(DataConst.NAME_ERROR)) {
			String errorMsg = resource.getString(DataConst.NAME_ERROR);
			if (errorMsg != null) {
				String statusMsg = defStatusMsg;
				if (statusMsg == null || statusMsg.length() == 0) {
					statusMsg = errorMsg;
				}
				return statusMsg;
			}
		}
		return null;
	}

	public static <T extends Resource> RestMethodResult<T> processResultErrorMessage(
			RestMethodResult<T> result) throws Exception {
		String errorMsg = null;
		if (result.getStatusCode() == RestStatus.SC_OK) {
			Resource res = result.getResource();
			if (res instanceof JSONObjResource) {
				errorMsg = processResultErrorMessage((JSONObjResource) res,
						result.getStatusMsg());
			} else if (res instanceof JSONArrayResource) {
				JSONArrayResource resource = (JSONArrayResource) res;
				for (int i = 0; i < resource.length(); i++) {
					Object obj = resource.get(i);
					if (obj instanceof JSONObject) {
						errorMsg = processResultErrorMessage((JSONObject) obj,
								result.getStatusMsg());
						if (errorMsg != null) {
							break;
						}
					}
				}
			}
		}

		if (errorMsg != null) {
			RunEnv.getInstance().setSessionId(null);// todo: why?
			return new RestMethodResult<T>(RestStatus.SERVER_REMOTE_ERROR,
					errorMsg, result.getResource());
		}
		return result;
	}

}
