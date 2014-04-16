package com.seekon.yougouhui.func.profile.favorit;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetShopFavoritesMethod extends JSONArrayResourceMethod {

	private static final String GET_SHOP_FAVORITES_URI = Const.SERVER_APP_URL
			+ "/getShopFavoritesByUser/";

	private String userId;

	public GetShopFavoritesMethod(Context context, String userId) {
		super(context);
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		String uri = GET_SHOP_FAVORITES_URI + userId;
		return new BaseRequest(Method.GET, uri, null, null);
	}
}
