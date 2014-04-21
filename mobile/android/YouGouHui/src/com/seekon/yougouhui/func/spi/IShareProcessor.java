package com.seekon.yougouhui.func.spi;

import java.util.Map;

import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShareProcessor {

	public RestMethodResult<JSONArrayResource> getShares(String lastPublishTime,
			String minPublishTime, String lastCommentPublishTime,
			String minCommentPublishTime);

	public RestMethodResult<JSONObjResource> postShare(ShareEntity share);

	public RestMethodResult<JSONObjResource> postComment(
			Map<String, String> comment);

	public RestMethodResult<JSONObjResource> deleteShare(String shareId);

	public RestMethodResult<JSONObjResource> deleteComment(String commentId);
}
