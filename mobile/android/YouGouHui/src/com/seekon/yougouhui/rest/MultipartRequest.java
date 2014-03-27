package com.seekon.yougouhui.rest;

import java.net.URI;
import java.util.List;
import java.util.Map;

import com.seekon.yougouhui.file.FileEntity;

/**
 * 支持多附件的请求，主要用于post请求
 * 
 * @author undyliu
 * 
 */
public class MultipartRequest extends BaseRequest {

	private List<FileEntity> fileEntities = null;

	public MultipartRequest(URI requestUri, Map<String, List<String>> headers,
			Map<String, String> parameters, List<FileEntity> fileEntities) {
		super(Method.POST, requestUri, headers, parameters);
		this.fileEntities = fileEntities;
	}

	public List<FileEntity> getFileEntities() {
		return fileEntities;
	}

}
