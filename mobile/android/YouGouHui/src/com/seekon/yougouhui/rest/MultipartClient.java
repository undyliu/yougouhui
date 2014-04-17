package com.seekon.yougouhui.rest;

import java.io.DataOutputStream;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import android.graphics.Bitmap;

import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;

//import android.util.Log;

/**
 * 支持附件的httpClient
 * 
 * @author undyliu
 * 
 */
public class MultipartClient extends RestClient {

	private static final String TAG = MultipartClient.class.getSimpleName();

	private int readTimeOut = 10 * 1000; // 读取超时
	private int connectTimeout = 10 * 1000; // 超时时间

	private static final String BOUNDARY = UUID.randomUUID().toString(); // 边界标识
																																				// 随机生成
	private static final String PREFIX = "--";
	private static final String LINE_END = "\r\n";
	private static final String CHARSET = "utf-8"; // 设置编码
	private static final String CONTENT_TYPE = "multipart/form-data"; // 内容类型

	@Override
	protected void processHttpConnection(HttpURLConnection conn, Request request)
			throws Exception {
		if (!(request instanceof MultipartRequest)) {
			throw new Exception("request必须为MultipartRequest类型.");
		}

		setConnectionProperties(conn);

		DataOutputStream dos = new DataOutputStream(conn.getOutputStream());

		setRequestParams(conn, request, dos);

		dos.write((PREFIX + BOUNDARY).getBytes());// 重要

		setMultipartFiles(conn, request, dos);

		dos.write((PREFIX + LINE_END).getBytes());// 结束

		dos.flush();
	}

	/**
	 * 设置请求的基本属性，如：编码等
	 * 
	 * @param conn
	 * @throws Exception
	 */
	private void setConnectionProperties(HttpURLConnection conn) throws Exception {
		conn.setReadTimeout(readTimeOut);
		conn.setConnectTimeout(connectTimeout);
		conn.setDoInput(true); // 允许输入流
		conn.setDoOutput(true); // 允许输出流
		conn.setUseCaches(false); // 不允许使用缓存
		conn.setRequestMethod("POST"); // 请求方式
		conn.setRequestProperty("Charset", CHARSET); // 设置编码
		conn.setRequestProperty("connection", "keep-alive");
		conn.setRequestProperty("user-agent",
				"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
		conn.setRequestProperty("Content-Type", CONTENT_TYPE + ";boundary="
				+ BOUNDARY);
		conn.setConnectTimeout(30 * 1000);//30秒
	}

	/**
	 * 设置传递的参数
	 * 
	 * @param conn
	 * @param request
	 * @throws Exception
	 */
	private void setRequestParams(HttpURLConnection conn, Request request,
			DataOutputStream dos) throws Exception {

		StringBuffer sb = null;
		String params = "";

		Map<String, String> param = request.getParameters();
		sb = new StringBuffer();
		List<FileEntity> fileEntities = ((MultipartRequest) request)
				.getFileEntities();
		if (fileEntities == null) {
			fileEntities = new ArrayList<FileEntity>();
		}

		for (FileEntity fileEntity : fileEntities) {
			sb.append("|" + fileEntity.getAliasName());
		}
		if (sb.length() > 0) {
			param.put("fileNameList", sb.substring(1));
		} else {
			param.put("fileNameList", "");
		}
		/***
		 * 以下是用于上传参数
		 */
		if (param != null && param.size() > 0) {
			Iterator<String> it = param.keySet().iterator();
			while (it.hasNext()) {
				sb = null;
				sb = new StringBuffer();
				String key = it.next();
				String value = param.get(key);
				value = value == null ? "" : URLEncoder.encode(value, CHARSET);// 对参数值进行编码
				sb.append(PREFIX).append(BOUNDARY).append(LINE_END);
				sb.append("Content-Disposition: form-data; name=\"").append(key)
						.append("\"").append(LINE_END).append(LINE_END);
				sb.append(value).append(LINE_END);
				params = sb.toString();
				// Log.i(TAG, key + "=" + params + "##");
				dos.write(params.getBytes());
				// dos.flush();
			}
		}
	}

	private void setMultipartFiles(HttpURLConnection conn, Request request,
			DataOutputStream dos) throws Exception {
		List<FileEntity> fileEntities = ((MultipartRequest) request)
				.getFileEntities();
		if (fileEntities == null || fileEntities.isEmpty()) {
			return;
		}

		StringBuffer sb = new StringBuffer();
		String params = null;
		/**
		 * 这里重点注意： name里面的值为服务器端需要key 只有这个key 才可以得到对应的文件 filename是文件的名字，包含后缀名的
		 * 比如:abc.png
		 */
		for (FileEntity fileEntity : fileEntities) {
			sb = null;
			sb = new StringBuffer();
			sb.append(LINE_END);
			sb.append("Content-Disposition:form-data; name=\""
					+ fileEntity.getAliasName() + "\"; filename=\""
					+ fileEntity.getAliasName() + "\"" + LINE_END);
			sb.append("Content-Type:image/pjpeg" + LINE_END); // 这里配置的Content-type很重要的
																												// ，用于服务器端辨别文件的类型的
			sb.append(LINE_END);
			params = sb.toString();

			// Log.i(TAG, file.getName() + "=" + params + "##");
			dos.write(params.getBytes());
			/** 上传文件 */
			// InputStream is = new FileInputStream(fileEntity.getFileUri());//
			// 对图片进行压缩处理
			// byte[] bytes = new byte[1024];
			// int len = 0;
			// while ((len = is.read(bytes)) != -1) {
			// dos.write(bytes, 0, len);
			// }
			// is.close();
			dos.write(compressImageFile(fileEntity.getFileUri()));

			dos.write(LINE_END.getBytes());
			byte[] end_data = (PREFIX + BOUNDARY).getBytes();
			dos.write(end_data);
		}
	}

	private byte[] compressImageFile(String fileUri) {
		Bitmap bitmap = FileHelper.decodeFileByDisplaySize(fileUri);
		return FileHelper.compressByQuality(bitmap, 300);
	}

}
