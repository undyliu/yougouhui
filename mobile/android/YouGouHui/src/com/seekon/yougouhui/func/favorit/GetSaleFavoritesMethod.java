package com.seekon.yougouhui.func.favorit;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetSaleFavoritesMethod extends JSONArrayResourceMethod {

	private static final String GET_SALE_FAVORITES_URI = Const.SERVER_APP_URL
			+ "/getSaleFavoritesByUser/";

	private String userId;

	public GetSaleFavoritesMethod(Context context, String userId) {
		super(context);
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		String uri = GET_SALE_FAVORITES_URI + userId;
		return new BaseRequest(Method.GET, uri, null, null);
	}

}
