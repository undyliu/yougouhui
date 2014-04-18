package com.seekon.yougouhui.rest;

import java.net.URI;
import java.util.List;
import java.util.Map;

public interface Request {

	public Method getMethod();

	public URI getRequestUri();

	public Map<String, List<String>> getHeaders();

	public void addHeader(String key, List<String> value);

	public byte[] getBody();

	public Map<String, String> getParameters();
}
