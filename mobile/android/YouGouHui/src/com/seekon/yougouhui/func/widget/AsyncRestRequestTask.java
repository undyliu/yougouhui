package com.seekon.yougouhui.func.widget;

import android.app.ProgressDialog;
import android.content.Context;
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

	private Context context;

	private AbstractRestTaskCallback<T> callback;

	private ProgressDialog progressDialog;

	public AsyncRestRequestTask(Context context,
			AbstractRestTaskCallback<T> callback) {
		super();
		this.context = context;
		this.callback = callback;
		if (callback == null) {
			throw new RuntimeException("AsyncRestRequestTask构造函数必须传递callback参数.");
		}
	}

	@Override
	protected void onPreExecute() {
		progressDialog = ProgressDialog.show(context, "",
				context.getString(R.string.default_progress_status_message), true,
				true);
		super.onPreExecute();
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
		if (progressDialog != null) {
			progressDialog.dismiss();
		}
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
		if (progressDialog != null) {
			progressDialog.dismiss();
		}
		callback.onCancelled();
	}

}
