package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class DeleteDiscussMethod extends JSONObjResourceMethod {

	private static final String DELETE_DISCUSS_URI = Const.SERVER_APP_URL
			+ "/deleteSaleDiscuss/";

	private String discussId;

	public DeleteDiscussMethod(Context context, String discussId) {
		super(context);
		this.discussId = discussId;
	}

	@Override
	protected Request buildRequest() {
		String uri = DELETE_DISCUSS_URI + discussId;
		return new BaseRequest(Method.DELETE, URI.create(uri), null, null);
	}

}
