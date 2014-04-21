package com.seekon.yougouhui.func.sale;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class CancelSaleMethod extends JSONObjResourceMethod {

	private final static URI CANCEL_SALE_URI = URI.create(Const.SERVER_APP_URL
			+ "/cancelSale");
	private SaleEntity sale;

	public CancelSaleMethod(Context context, SaleEntity sale) {
		super(context);
		this.sale = sale;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(SaleImgConst.COL_NAME_SALE_ID, sale.getUuid());
		
		return new BaseRequest(Method.PUT, CANCEL_SALE_URI, null, params);
	}

}
