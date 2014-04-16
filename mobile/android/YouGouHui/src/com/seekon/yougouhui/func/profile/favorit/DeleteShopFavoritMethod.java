package com.seekon.yougouhui.func.profile.favorit;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

public class DeleteShopFavoritMethod extends JSONObjResourceMethod{
	private static final String DEL_SHOP_FAVORIT_URI = Const.SERVER_APP_URL
			+ "/deleteShopFavorit/";

	private String shopId;
	private String userId;

	public DeleteShopFavoritMethod(Context context, String shopId, String userId) {
		super(context);
		this.shopId = shopId;
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		String uri = DEL_SHOP_FAVORIT_URI + userId + "/" + shopId;
		return new BaseRequest(Method.DELETE, uri, null, null);
	}
	
	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, ShopFavoritConst.COL_NAME_SHOP_ID, shopId);
		JSONUtils.putJSONValue(resource, ShopFavoritConst.COL_NAME_USER_ID, userId);
		return resource;
	}
}
