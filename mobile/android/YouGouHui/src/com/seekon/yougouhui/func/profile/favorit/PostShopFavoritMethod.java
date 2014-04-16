package com.seekon.yougouhui.func.profile.favorit;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

public class PostShopFavoritMethod extends JSONObjResourceMethod {

	private static final URI ADD_SALE_FAVORITE_URI = URI
			.create(Const.SERVER_APP_URL + "/addShopFavorit");

	private ShopEntity shop;
	private String userId;

	public PostShopFavoritMethod(Context context, ShopEntity shop, String userId) {
		super(context);
		this.shop = shop;
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(ShopFavoritConst.COL_NAME_SHOP_ID, shop.getUuid());
		params.put(ShopFavoritConst.COL_NAME_USER_ID, userId);

		return new BaseRequest(Method.POST, ADD_SALE_FAVORITE_URI, null, params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, ShopFavoritConst.COL_NAME_SHOP_ID, shop.getUuid());
		JSONUtils.putJSONValue(resource, DataConst.COL_NAME_TITLE, shop.getName());
		JSONUtils.putJSONValue(resource, DataConst.COL_NAME_IMG, shop.getShopImage());
		JSONUtils.putJSONValue(resource, ShopFavoritConst.COL_NAME_USER_ID, userId);
		return resource;
	}
}
