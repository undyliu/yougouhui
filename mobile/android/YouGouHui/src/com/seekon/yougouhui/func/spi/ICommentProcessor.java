package com.seekon.yougouhui.func.spi;

import java.util.Map;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface ICommentProcessor {

	public RestMethodResult<JSONObjResource> postComment(
			Map<String, String> comment);

	public RestMethodResult<JSONObjResource> deleteComment(String commentId);
}
