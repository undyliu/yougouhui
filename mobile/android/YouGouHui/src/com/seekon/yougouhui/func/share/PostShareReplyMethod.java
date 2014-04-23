package com.seekon.yougouhui.func.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_GRADE;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_REPLIER;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_SHARE_ID;
import static com.seekon.yougouhui.func.share.ShopReplyConst.COL_NAME_SHOP_ID;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class PostShareReplyMethod extends JSONObjResourceMethod {

	private static final URI POST_SHARE_REPLY_URI = URI
			.create(Const.SERVER_APP_URL + "/saveShareReply");

	private ShopReplyEntity reply;

	public PostShareReplyMethod(Context context, ShopReplyEntity reply) {
		super(context);
		this.reply = reply;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_SHARE_ID, reply.getShareId());
		params.put(COL_NAME_SHOP_ID, reply.getShopId());
		params.put(COL_NAME_CONTENT, reply.getContent());
		params.put(COL_NAME_GRADE, reply.getGrade() + "");
		params.put(COL_NAME_REPLIER, reply.getReplier());

		return new BaseRequest(Method.POST, POST_SHARE_REPLY_URI, null, params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		resource.put(COL_NAME_SHARE_ID, reply.getShareId());
		resource.put(COL_NAME_SHOP_ID, reply.getShopId());
		resource.put(COL_NAME_CONTENT, reply.getContent());
		resource.put(COL_NAME_GRADE, reply.getGrade() + "");
		resource.put(COL_NAME_REPLIER, reply.getReplier());
		return resource;
	}
}
