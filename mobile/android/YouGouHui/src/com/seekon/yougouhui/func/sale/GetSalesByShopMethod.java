package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class GetSalesByShopMethod extends JSONObjResourceMethod {

	private static final String GET_SALES_URI = Const.SERVER_APP_URL
			+ "/getSalesByShop/";

	private String shopId;

	private String updateTime;

	public GetSalesByShopMethod(Context context, String shopId, String updateTime) {
		super(context);
		this.shopId = shopId;
		this.updateTime = updateTime;
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(GET_SALES_URI + shopId + "/" + updateTime);
		return new BaseRequest(Method.GET, uri, null, null);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		resource.put(DataConst.NAME_TYPE, SaleConst.RequetsType.SHOP_SALE);
		resource.put(SaleConst.COL_NAME_SHOP_ID, shopId);
		return resource;
	}

}
