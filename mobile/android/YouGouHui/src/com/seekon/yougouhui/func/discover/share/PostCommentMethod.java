package com.seekon.yougouhui.func.discover.share;

import java.net.URI;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

/**
 * 提交对分享信息的评论
 * 
 * @author undyliu
 * 
 */
public class PostCommentMethod extends JSONObjResourceMethod {

	private static final String POST_COMMENT_URI = Const.SERVER_APP_URL
			+ "/saveComment";

	private Map<String, String> comment;

	public PostCommentMethod(Context context, Map<String, String> comment) {
		super(context);
		this.comment = comment;
	}

	@Override
	protected Request buildRequest() {

		return new BaseRequest(Method.POST, URI.create(POST_COMMENT_URI), null,
				comment);
	}

}
