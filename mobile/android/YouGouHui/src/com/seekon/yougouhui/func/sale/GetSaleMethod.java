package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetSaleMethod extends JSONObjResourceMethod{
	
	private static final String GET_SALE_URI = Const.SERVER_APP_URL
			+ "/getSaleData/";
	
	private String saleId;

	public GetSaleMethod(Context context, String saleId) {
		super(context);
		this.saleId = saleId;
	}

	@Override
	protected Request buildRequest() {
		String uri = GET_SALE_URI + saleId;
		return new BaseRequest(Method.GET, URI.create(uri), null, null);
	}
	
}
