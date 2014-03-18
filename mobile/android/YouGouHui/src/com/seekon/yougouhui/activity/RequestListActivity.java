package com.seekon.yougouhui.activity;

import java.util.List;
import java.util.Map;

import android.app.ListActivity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.AsyncTask;
import android.os.Bundle;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.util.Logger;

public abstract class RequestListActivity extends ListActivity {

	protected static final String TAG = RequestListActivity.class.getSimpleName();
	
	protected Long requestId;

	protected BroadcastReceiver requestReceiver;

	protected String requestResultType;

	protected boolean updated = false;
	
	public RequestListActivity(String requestResultType) {
		super();
		this.requestResultType = requestResultType;
	}

	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		requestReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context context, Intent intent) {
				Logger.debug(TAG, intent);
				long resultRequestId = intent.getLongExtra(
						RequestServiceHelper.EXTRA_REQUEST_ID, 0);
				if (resultRequestId == requestId) {
					int resultCode = intent.getIntExtra(
							RequestServiceHelper.EXTRA_RESULT_CODE, 0);
					if (resultCode == 200) {
						updateListItems();
					} else {
						// showToast(getString(R.string.error_occurred));
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};
		
		
		this.updateListItems();
	}
	
	@Override
	protected void onResume() {
		super.onResume();
		
		this.registerReceiver(requestReceiver, new IntentFilter(requestResultType));
		if(!updated){
			updateListItems();
		}
	}
	
	@Override
	protected void onPause() {
		super.onDestroy();
		this.unregisterReceiver(requestReceiver);
	}
	
	protected abstract void initRequestId();
	
	protected void updateListItems(){
		AsyncTask<Void, Void, List<Map<String, ?>>> task = new AsyncTask<Void, Void, List<Map<String,?>>>(){
			@Override
			protected List<Map<String, ?>> doInBackground(Void... params) {
				Logger.debug(TAG, "getListItemsFromLocal");
				return getListItemsFromLocal();
			}
			
			@Override
			protected void onPostExecute(List<Map<String, ?>> result) {
				updated = true;
				if(result.size() == 0 && requestId == null && RunEnv.getInstance().isConnectedToInternet()){
					Logger.debug(TAG, "getListItemsFromRemote");
					initRequestId();
				}else{
					updateListView(result);
				}
			}
			
			@Override
			protected void onCancelled() {
				updated = false;
			}
		};
		
		task.execute((Void)null);
	}

	protected abstract List<Map<String, ?>> getListItemsFromLocal();
	
	protected abstract void updateListView(List<Map<String, ?>> data);
}
