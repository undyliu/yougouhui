package com.seekon.yougouhui.rest;

import java.net.URI;
import java.util.List;
import java.util.Map;

/**
 * 支持多附件的请求，主要用于post请求
 * 
 * @author undyliu
 * 
 */
public class MultipartRequest extends BaseRequest {

	private List<String> fileNames = null;

	public MultipartRequest(URI requestUri, Map<String, List<String>> headers,
			Map<String, String> parameters, List<String> fileNames) {
		super(Method.POST, requestUri, headers, parameters);
		this.fileNames = fileNames;
	}

	public List<String> getFileNames() {
		return fileNames;
	}

}
