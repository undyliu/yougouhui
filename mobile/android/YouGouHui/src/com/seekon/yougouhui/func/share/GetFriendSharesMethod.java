package com.seekon.yougouhui.func.share;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

/**
 * 根据最新的发布时间获取最新的分享和评论数据 同时，根据最早的发布书剑获取已经删除了的分享和评论数据
 * 
 * @author undyliu
 * 
 */
public class GetFriendSharesMethod extends JSONObjResourceMethod {

	private static final String GET_FRIEND_SHARES_URI = Const.SERVER_APP_URL
			+ "/getFriendShares/";

	private String updateTime;

	private String userId;

	public GetFriendSharesMethod(Context context, String userId, String updateTime) {
		super(context);
		this.userId = userId;
		this.updateTime = updateTime;
		if (this.updateTime == null || this.updateTime.length() == 0) {
			this.updateTime = "-1";
		}
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_FRIEND_SHARES_URI + userId + "/" + updateTime);
		return new BaseRequest(Method.GET, uri, null, null);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		resource.put(DataConst.NAME_TYPE, ShareConst.RequestType.FRIEND_SHARE);
		return resource;
	}
}
