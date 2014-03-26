package com.seekon.yougouhui.sercurity;

import com.seekon.yougouhui.rest.Request;

public interface RequestSigner {

	/**
	 * Adds the required OAuth information to a Request
	 * 
	 * @param conn
	 */
	public void authorize(Request request);

}
