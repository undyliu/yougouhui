package com.seekon.yougouhui.rest;

import org.apache.http.HttpStatus;

public interface RestStatus extends HttpStatus{
	
	public static final int NETWORK_NOT_OPENED = 9001;
	
	public static final int SERVER_NOT_AVAILABLE = 9002;
	
	public static final int RUNTIME_ERROR = 9003;
}
