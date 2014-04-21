package com.seekon.yougouhui.func.favorit;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

public class DeleteSaleFavoritMethod extends JSONObjResourceMethod {

	private static final String DEL_SALE_FAVORIT_URI = Const.SERVER_APP_URL
			+ "/deleteSaleFavorit/";

	private String saleId;
	private String userId;

	public DeleteSaleFavoritMethod(Context context, String saleId, String userId) {
		super(context);
		this.saleId = saleId;
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		String uri = DEL_SALE_FAVORIT_URI + userId + "/" + saleId;
		return new BaseRequest(Method.DELETE, uri, null, null);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, SaleFavoritConst.COL_NAME_SALE_ID, saleId);
		JSONUtils.putJSONValue(resource, SaleFavoritConst.COL_NAME_USER_ID, userId);
		return resource;
	}
}
