package com.seekon.yougouhui.func.profile.favorit;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

public class PostSaleFavoritMethod extends JSONObjResourceMethod {

	private static final URI ADD_SALE_FAVORITE_URI = URI
			.create(Const.SERVER_APP_URL + "/addSaleFavorit");

	private SaleEntity sale;
	private String userId;

	public PostSaleFavoritMethod(Context context, SaleEntity sale, String userId) {
		super(context);
		this.sale = sale;
		this.userId = userId;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(SaleFavoritConst.COL_NAME_SALE_ID, sale.getUuid());
		params.put(SaleFavoritConst.COL_NAME_USER_ID, userId);

		return new BaseRequest(Method.POST, ADD_SALE_FAVORITE_URI, null, params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, SaleFavoritConst.COL_NAME_SALE_ID,
				sale.getUuid());
		JSONUtils.putJSONValue(resource, DataConst.COL_NAME_TITLE, sale.getTitle());
		JSONUtils.putJSONValue(resource, DataConst.COL_NAME_IMG, sale.getImg());
		JSONUtils.putJSONValue(resource, SaleFavoritConst.COL_NAME_USER_ID, userId);
		return resource;
	}
}
