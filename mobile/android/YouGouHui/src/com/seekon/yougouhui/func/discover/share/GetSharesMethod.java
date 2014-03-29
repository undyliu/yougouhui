package com.seekon.yougouhui.func.discover.share;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

/**
 * 根据最新的发布时间获取最新的分享和评论数据
 * 同时，根据最早的发布书剑获取已经删除了的分享和评论数据
 * @author undyliu
 *
 */
public class GetSharesMethod extends JSONObjResourceMethod {

	private static final String GET_FRIEND_SHARES_URI = Const.SERVER_APP_URL
			+ "/getFriendShares";

	private String lastPublishTime;

	private String minPublishTime;

	private String lastCommentPublishTime;
	
	public GetSharesMethod(Context context, String lastPublishTime,
			String minPublishTime, String lastCommentPublishTime) {
		super(context);
		this.lastPublishTime = lastPublishTime;
		if (this.lastPublishTime == null || this.lastPublishTime.length() == 0) {
			this.lastPublishTime = "-1";
		}
		this.minPublishTime = minPublishTime;
		if (this.minPublishTime == null || this.minPublishTime.length() == 0) {
			this.minPublishTime = "-1";
		}
		this.lastCommentPublishTime = lastCommentPublishTime;
		if (this.lastCommentPublishTime == null || this.lastCommentPublishTime.length() == 0) {
			this.lastCommentPublishTime = "-1";
		}
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_FRIEND_SHARES_URI);
		Map<String, String> params = new HashMap<String, String>();
		params.put("last-pub-time", lastPublishTime);
		params.put("min-pub-time", minPublishTime);
		params.put("last-comm-pub-time", lastCommentPublishTime);
		return new BaseRequest(Method.POST, uri, null, params);
	}

}
