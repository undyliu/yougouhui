package com.seekon.yougouhui.func.widget;

import android.view.MenuItem;

import com.seekon.yougouhui.rest.resource.JSONObjResource;

public abstract class ChangeTextInfoTaskCallback extends
		AbstractRestTaskCallback<JSONObjResource> {
	private MenuItem item;


	public ChangeTextInfoTaskCallback(MenuItem item) {
		super("修改失败.");
		this.item = item;
	}

	@Override
	public void onFailed(String errorMessage) {
		item.setEnabled(true);
		super.onFailed(errorMessage);
	}
	
	@Override
	public void onCancelled() {
		item.setEnabled(true);
		super.onCancelled();
	}
}
