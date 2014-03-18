package com.seekon.yougouhui.rest;

import android.content.Context;

import com.seekon.yougouhui.rest.resource.JSONObjResource;

public abstract class JSONObjResourceMethod extends AbstractRestMethod<JSONObjResource>{
	
	protected Context context;

	public JSONObjResourceMethod(Context context) {
		super();
		this.context = context.getApplicationContext();
	}
	
	@Override
	protected Context getContext() {
		return this.context;
	}
	
}
