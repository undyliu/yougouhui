package com.seekon.yougouhui.func.profile.shop.widget;

import android.content.Context;
import android.os.AsyncTask;

import com.seekon.yougouhui.func.profile.shop.TradeProcessor;
import com.seekon.yougouhui.func.widget.TaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;

public class GetTradesTask extends
		AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>> {

	private Context context;

	private TaskCallback<RestMethodResult<JSONArrayResource>> callback;

	public GetTradesTask(Context context,
			TaskCallback<RestMethodResult<JSONArrayResource>> callback) {
		super();
		this.context = context;
		this.callback = callback;
	}

	@Override
	protected RestMethodResult<JSONArrayResource> doInBackground(Void... params) {
		return TradeProcessor.getInstance(context).getTrades();
	}

	@Override
	protected void onPostExecute(RestMethodResult<JSONArrayResource> result) {
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
