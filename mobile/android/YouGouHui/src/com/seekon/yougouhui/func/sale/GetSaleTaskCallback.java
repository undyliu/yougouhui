package com.seekon.yougouhui.func.sale;

import android.content.Context;

import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public abstract class GetSaleTaskCallback extends
		AbstractRestTaskCallback<JSONObjResource> {

	private Context context;
	private String saleId;

	public GetSaleTaskCallback(Context context, String saleId) {
		super("获取活动数据失败.");
		this.context = context;
		this.saleId = saleId;
	}

	@Override
	public RestMethodResult<JSONObjResource> doInBackground() {
		return SaleProcessor.getInstance(context).getSale(saleId);
	}

}
