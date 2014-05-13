package com.seekon.yougouhui.func.message;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetMessagesMethod extends JSONObjResourceMethod {
	private final static String GET_MESSAGES = Const.SERVER_APP_URL
			+ "/getUserMessages/";

	private UserEntity receiver;
	private String updateTime;

	public GetMessagesMethod(Context context, UserEntity receiver,
			String updateTime) {
		super(context);
		this.receiver = receiver;
		this.updateTime = updateTime;
	}

	@Override
	protected Request buildRequest() {
		StringBuffer sb = new StringBuffer();
		sb.append(GET_MESSAGES + receiver.getUuid());
		sb.append("/" + updateTime);
		return new BaseRequest(Method.GET, sb.toString(), null, null);
	}

}
