package com.seekon.yougouhui.func.sale.widget;

import android.content.Context;
import android.os.AsyncTask;

import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.widget.TaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class GetSaleTask extends AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>{

	private Context context;

	private TaskCallback<RestMethodResult<JSONObjResource>> callback;
	
	private String saleId;

	public GetSaleTask(Context context,
			TaskCallback<RestMethodResult<JSONObjResource>> callback, String saleId) {
		super();
		this.context = context;
		this.callback = callback;
		this.saleId = saleId;
	}

	@Override
	protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
		return SaleProcessor.getInstance(context).getSale(saleId);
	}

	@Override
	protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
		if (callback != null) {
			callback.onPostExecute(result);
		}
		super.onPostExecute(result);
	}

	@Override
	protected void onCancelled() {
		if (callback != null) {
			callback.onCancelled();
		}
		super.onCancelled();
	}
}
