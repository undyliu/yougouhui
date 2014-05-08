package com.seekon.yougouhui.func.grade;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetUserTotalGradeMethod extends JSONObjResourceMethod {

	private static final String GET_USER_TOTAL_GRADE_URI = Const.SERVER_APP_URL
			+ "/getUserTotalGrade/";

	private String userId;

	public GetUserTotalGradeMethod(Context context, String userId) {
		super(context);
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		return new BaseRequest(Method.GET, GET_USER_TOTAL_GRADE_URI + userId, null,
				null);
	}

}
