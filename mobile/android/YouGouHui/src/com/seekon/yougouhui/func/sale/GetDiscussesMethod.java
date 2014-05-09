package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class GetDiscussesMethod extends JSONObjResourceMethod {

	private static final String GET_DISCUSSES_URI = Const.SERVER_APP_URL
			+ "/getSaleDiscusses/";

	private String saleId;

	private String updateTime;

	public GetDiscussesMethod(Context context, String saleId, String updateTime) {
		super(context);
		this.saleId = saleId;
		this.updateTime = updateTime;
	}

	@Override
	protected Request buildRequest() {
		String uri = GET_DISCUSSES_URI + saleId + "/" + updateTime;
		return new BaseRequest(Method.GET, URI.create(uri), null, null);
	}
	
	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		resource.put(SaleDiscussConst.COL_NAME_SALE_ID, saleId);
		return resource;
	}
	
}
