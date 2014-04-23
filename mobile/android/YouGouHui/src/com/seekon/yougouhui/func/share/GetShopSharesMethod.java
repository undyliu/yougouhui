package com.seekon.yougouhui.func.share;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class GetShopSharesMethod extends JSONObjResourceMethod {

	private static final String GET_SHOP_SHARES_URI = Const.SERVER_APP_URL
			+ "/getShopShares/";

	private String updateTime;

	private String shopId;

	public GetShopSharesMethod(Context context, String shopId, String updateTime) {
		super(context);
		this.shopId = shopId;
		this.updateTime = updateTime;
		if (this.updateTime == null || this.updateTime.length() == 0) {
			this.updateTime = "-1";
		}
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_SHOP_SHARES_URI + shopId + "/" + updateTime);
		return new BaseRequest(Method.GET, uri, null, null);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		resource.put(DataConst.NAME_TYPE, ShareConst.RequestType.SHOP_SHARE);
		resource.put(ShareConst.COL_NAME_SHOP_ID, shopId);
		return resource;
	}
}

