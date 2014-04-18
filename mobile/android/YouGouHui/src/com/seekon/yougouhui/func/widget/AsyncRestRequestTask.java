package com.seekon.yougouhui.func.widget;

import android.os.AsyncTask;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.YouGouHuiApp;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.util.Logger;

public class AsyncRestRequestTask<T extends Resource> extends
		AsyncTask<Void, Void, RestMethodResult<T>> {

	private final static String TAG = AsyncRestRequestTask.class.getSimpleName();

	private AbstractRestTaskCallback<T> callback;

	public AsyncRestRequestTask(AbstractRestTaskCallback<T> callback) {
		super();
		this.callback = callback;
		if (callback == null) {
			throw new RuntimeException("AsyncRestRequestTask构造函数必须传递callback参数.");
		}
	}

	@Override
	protected RestMethodResult<T> doInBackground(Void... params) {
		try {
			return callback.doInBackground();
		} catch (Throwable e) {
			Logger.warn(TAG, e.getMessage());
		}
		return new RestMethodResult<T>(RestStatus.RUNTIME_ERROR, YouGouHuiApp
				.getAppContext().getString(R.string.runtime_error), null);
	}

	@Override
	protected void onPostExecute(RestMethodResult<T> result) {
		int status = result.getStatusCode();
		if (status == RestStatus.SC_OK) {
			callback.onSuccess(result);
		} else {
			String message = result.getStatusMsg();
			if (message == null || message.trim().length() == 0) {
				message = YouGouHuiApp.getAppContext()
						.getString(R.string.runtime_error);
			}
			callback.onFailed(message);
		}
	}

	@Override
	protected void onCancelled() {
		callback.onCancelled();
	}

}
