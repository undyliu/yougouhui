package com.seekon.yougouhui.func.share;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetUserSharesMethod extends JSONArrayResourceMethod {
	private final static String GET_SHARES = Const.SERVER_APP_URL
			+ "/getUserShares/";

	private UserEntity publisher;

	public GetUserSharesMethod(Context context, UserEntity publisher) {
		super(context);
		this.publisher = publisher;
	}

	@Override
	protected Request buildRequest() {
		return new BaseRequest(Method.GET, GET_SHARES + publisher.getUuid(), null,
				null);
	}

}
