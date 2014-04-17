package com.seekon.yougouhui.func.spi;

import java.util.Map;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ProcessorCallback;

public interface IShareProcessor {

	public void getShares(ProcessorCallback callback, String lastPublishTime,
			String minPublishTime, String lastCommentPublishTime,
			String minCommentPublishTime);

	public RestMethodResult<JSONObjResource> postShare(Map share);

	public RestMethodResult<JSONObjResource> postComment(
			Map<String, String> comment);

	public RestMethodResult<JSONObjResource> deleteShare(String shareId);

	public RestMethodResult<JSONObjResource> deleteComment(String commentId);
}
