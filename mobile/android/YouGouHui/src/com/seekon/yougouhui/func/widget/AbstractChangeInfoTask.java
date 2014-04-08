package com.seekon.yougouhui.func.widget;

import android.os.AsyncTask;
import android.view.MenuItem;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public abstract class AbstractChangeInfoTask extends
		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> {

	private MenuItem item;

	public AbstractChangeInfoTask(MenuItem item) {
		super();
		this.item = item;
	}

	@Override
	protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
		showProgressInner(false);
		int status = result.getStatusCode();
		if (status == 200) {
			doSuccess(result);
		} else {
			ViewUtils.showToast("修改失败.");
		}
		item.setEnabled(true);
		super.onPostExecute(result);
	}

	@Override
	protected void onCancelled() {
		showProgressInner(false);
		item.setEnabled(true);
		super.onCancelled();
	}

	protected abstract void showProgressInner(boolean show);

	protected abstract void doSuccess(RestMethodResult<JSONObjResource> result);
}
