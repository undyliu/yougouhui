package com.seekon.yougouhui.func.sale;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class GetDiscussesMethod extends JSONArrayResourceMethod {

	private static final String GET_DISCUSSES_URI = Const.SERVER_APP_URL
			+ "/getSaleDiscusses/";

	private String saleId;

	public GetDiscussesMethod(Context context, String saleId) {
		super(context);
		this.saleId = saleId;
	}

	@Override
	protected Request buildRequest() {
		String uri = GET_DISCUSSES_URI + saleId;
		return new BaseRequest(Method.GET, URI.create(uri), null, null);
	}

}
