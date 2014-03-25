package com.seekon.yougouhui.rest;

import java.io.File;
import java.net.URI;
import java.util.List;
import java.util.Map;

/**
 * 支持多附件的请求，主要用于post请求
 * @author undyliu
 *
 */
public class MultipartRequest extends BaseRequest {

	private List<File> files = null;

	public MultipartRequest(URI requestUri, Map<String, List<String>> headers,
			Map<String, String> parameters, List<File> files) {
		super(Method.POST, requestUri, headers, parameters);
		this.files = files;
	}

	public List<File> getFiles() {
		return files;
	}

}
