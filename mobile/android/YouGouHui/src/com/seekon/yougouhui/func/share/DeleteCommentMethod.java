package com.seekon.yougouhui.func.share;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class DeleteCommentMethod extends JSONObjResourceMethod {

	private static final String DELETE_COMMENT_URI = Const.SERVER_APP_URL
			+ "/deleteComment";

	private String commentId;

	public DeleteCommentMethod(Context context, String commentId) {
		super(context);
		this.commentId = commentId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(DELETE_COMMENT_URI + "/" + commentId);
		return new BaseRequest(Method.DELETE, uri, null, null);
	}

}
