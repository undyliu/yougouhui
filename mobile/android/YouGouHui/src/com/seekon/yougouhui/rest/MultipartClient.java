package com.seekon.yougouhui.rest;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.DefaultHttpClient;

import com.seekon.yougouhui.util.Logger;

/**
 * 支持附件的httpClient
 * 
 * @author undyliu
 * 
 */
public class MultipartClient {

	private static final String TAG = MultipartClient.class.getSimpleName();

	public void execute(MultipartRequest request) {

		try {
			MultipartEntity reqEntity = new MultipartEntity();

			Map<String, String> params = request.getParameters();
			if (params != null && !params.isEmpty()) {
				Iterator<Entry<String, String>> iterator = params.entrySet().iterator();
				while (iterator.hasNext()) {
					Entry<String, String> entry = iterator.next();
					reqEntity.addPart(entry.getKey(), new StringBody(entry.getValue()));
				}
			}

			List<File> files = request.getFiles();
			if (files != null && !files.isEmpty()) {
				for (File file : files) {
					reqEntity.addPart(file.getName(), new FileBody(file));
				}
			}

			HttpPost httppost = new HttpPost(request.getRequestUri().toString());
			httppost.setEntity(reqEntity);

			HttpClient httpclient = new DefaultHttpClient();
			HttpResponse response = httpclient.execute(httppost);
			HttpEntity resEntity = response.getEntity();
			if (resEntity != null) {
				// TODO:
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
	}
}
