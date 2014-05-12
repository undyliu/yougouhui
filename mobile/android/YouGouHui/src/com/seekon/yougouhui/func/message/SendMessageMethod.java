package com.seekon.yougouhui.func.message;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_RECEIVER;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_SENDER;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

public class SendMessageMethod extends JSONObjResourceMethod {

	private static final URI uri = URI.create(Const.SERVER_APP_URL
			+ "/sendMessage");

	private UserEntity sender;

	private UserEntity receiver;

	private String content;

	private Map<String, String> params = new HashMap<String, String>();

	public SendMessageMethod(Context context, UserEntity sender,
			UserEntity receiver, String content) {
		super(context);
		this.sender = sender;
		this.receiver = receiver;
		this.content = content;
	}

	@Override
	protected Request buildRequest() {
		params.put(COL_NAME_SENDER, sender.getUuid());
		params.put(COL_NAME_RECEIVER, receiver.getUuid());
		params.put(COL_NAME_CONTENT, content);

		return new BaseRequest(Method.POST, uri, null, params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.mergerMap(resource, params, false);
		return resource;
	}
}
