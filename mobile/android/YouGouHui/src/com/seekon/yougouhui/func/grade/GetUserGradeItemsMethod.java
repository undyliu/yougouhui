package com.seekon.yougouhui.func.grade;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetUserGradeItemsMethod extends JSONArrayResourceMethod {

	private static final String GET_USER_GRADE_ITEMS_URI = Const.SERVER_APP_URL
			+ "/getUserGradeItems/";

	private String userId;

	public GetUserGradeItemsMethod(Context context, String userId) {
		super(context);
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		return new BaseRequest(Method.GET, GET_USER_GRADE_ITEMS_URI + userId, null,
				null);
	}

}
