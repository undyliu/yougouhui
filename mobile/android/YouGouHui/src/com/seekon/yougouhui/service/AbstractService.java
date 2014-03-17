package com.seekon.yougouhui.service;

import android.app.IntentService;
import android.content.Intent;
import android.os.Bundle;
import android.os.ResultReceiver;

public abstract class AbstractService extends IntentService{

	protected ResultReceiver mCallback;

	protected Intent mOriginalRequestIntent;
	
	public AbstractService(String name) {
		super(name);
	}

	protected Bundle getOriginalIntentBundle() {
		Bundle originalRequest = new Bundle();
		originalRequest.putParcelable(ServiceConst.ORIGINAL_INTENT_EXTRA, mOriginalRequestIntent);
		return originalRequest;
	}
	
	@Override
	protected void onHandleIntent(Intent intent) {
		mOriginalRequestIntent = intent;
		mCallback = intent.getParcelableExtra(ServiceConst.SERVICE_CALLBACK);
		handlerIntent(intent);
	}
	
	protected abstract void handlerIntent(Intent intent);
	
	protected ProcessorCallback makeProcessorCallback() {
		ProcessorCallback callback = new ProcessorCallback() {

			@Override
			public void send(int resultCode) {
				if (mCallback != null) {
					mCallback.send(resultCode, getOriginalIntentBundle());
				}
			}
		};
		return callback;
	}
}
