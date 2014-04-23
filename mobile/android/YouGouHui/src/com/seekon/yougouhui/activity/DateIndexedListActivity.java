package com.seekon.yougouhui.activity;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.ClearEditText;

public abstract class DateIndexedListActivity extends Activity implements
		IXListViewListener {

	protected List<DateIndexedEntity> dataList = new ArrayList<DateIndexedEntity>();

	protected XListView listView = null;

	protected ClearEditText mClearEditText;

	protected DateIndexedListAdapter listAdapter = null;

	private String searchWord = "";

	private Handler mHandler;

	private int currentOffset = 0;

	private String updateTime;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.searched_xlistview);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();
		loadDataList();
	}

	protected void initViews() {
		mHandler = new Handler();

		listView = (XListView) findViewById(R.id.listview_main);
		listView.setPullLoadEnable(true);
		listView.setXListViewListener(this);

		listAdapter = getListAdapter();
		listView.setAdapter(listAdapter);

		mClearEditText = (ClearEditText) findViewById(R.id.listview_filter_edit);
		mClearEditText.setOnKeyListener(new View.OnKeyListener() {
			@Override
			public boolean onKey(View v, int keyCode, KeyEvent event) {
				if (keyCode == KeyEvent.KEYCODE_ENTER) {
					String word = mClearEditText.getText().toString();
					// if (TextUtils.isEmpty(word)) {
					// mClearEditText.setError(getString(R.string.error_field_required));
					// return false;
					// }
					if (!searchWord.equals(word)) {
						filterData(word);
					}
					return true;
				}
				return false;
			}
		});

		mClearEditText.addTextChangedListener(new TextWatcher() {

			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (s == null || s.length() == 0) {
					filterData("");
				}
			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {

			}

			@Override
			public void afterTextChanged(Editable s) {

			}
		});
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void filterData(String word) {
		ViewUtils.hideInputMethodWindow(DateIndexedListActivity.this);
		searchWord = word;
		
		currentOffset = 0;
		searchWord = word;
		dataList.clear();
		loadDataListFromLocal();
		
		listAdapter.updateData(dataList);
	}

	protected void loadDataList() {
		updateTime = getUpdateTime();
		if (updateTime != null) {
			try {
				listView.setRefreshTime(DateUtils.formartTime(Long.valueOf(updateTime)));
			} catch (Exception e) {
			}
		}
		
		currentOffset = 0;
		dataList.clear();
		loadDataListFromLocal();
		if (dataList.isEmpty()) {
			loadDataListFromRemote();
		} else {
			listAdapter.updateData(dataList);
		}
	}

	private void loadDataListFromLocal() {
		String limitSql = " limit " + Const.PAGE_SIZE + " offset " + currentOffset;
		List<DateIndexedEntity> result = this.getDataListFromLocal(searchWord, limitSql);
		currentOffset += result.size();
		dataList.addAll(result);
	}

	private void loadDataListFromRemote() {
		updateTime = getUpdateTime();
		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"获取数据失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return getRemoteData(updateTime);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						currentOffset = 0;
						dataList.clear();
						loadDataListFromLocal();
						updateTime = getUpdateTime();
						listAdapter.updateData(dataList);
						onPostLoad();
					}

					@Override
					public void onFailed(String errorMessage) {
						onPostLoad();
						super.onFailed(errorMessage);
					}

					@Override
					public void onCancelled() {
						onPostLoad();
						super.onCancelled();
					}
				});
	}

	protected void onPostLoad() {
		listView.stopRefresh();
		listView.stopLoadMore();
		if (updateTime != null) {
			try {
				listView
						.setRefreshTime(DateUtils.formartTime(Long.valueOf(updateTime)));
			} catch (Exception e) {
			}
		}
	}

	@Override
	public void onRefresh() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				loadDataListFromRemote();
				onPostLoad();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				loadDataListFromLocal();
				onPostLoad();
			}
		}, 2000);
	}

	public abstract DateIndexedListAdapter getListAdapter();

	protected abstract List<DateIndexedEntity> getDataListFromLocal(
			String searchWord, String limitSql);

	protected abstract RestMethodResult<JSONObjResource> getRemoteData(
			String updateTime);

	protected abstract String getUpdateTime();

}
