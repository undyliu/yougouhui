package com.seekon.yougouhui.func.widget;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.os.Handler;
import android.util.AttributeSet;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;

/**
 * 具有分页功能、并进行远程访问的xlistview
 * 
 * @author undyliu
 * 
 * @param <T>
 */
public abstract class PagedXListView<T extends Entity> extends XListView
		implements IXListViewListener {

	protected List<T> dataList = new ArrayList<T>();

	private EntityListAdapter<T> entityListAdapter;
	private String updateTime;
	protected int currentOffset = 0;
	protected Context context;
	private Handler mHandler;
	protected boolean inited = false;

	public PagedXListView(Context context) {
		super(context);
		this.context = context;
	}

	public PagedXListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		this.context = context;
	}

	public PagedXListView(Context context, AttributeSet attrs) {
		super(context, attrs);
		this.context = context;
	}

	public T getDataEntity(int position) {
		return dataList.get(position);
	}

	protected void init() {
		mHandler = new Handler();
		this.setPullLoadEnable(true);
		this.setXListViewListener(this);

		this.entityListAdapter = getEntityListAdapter();
		this.setAdapter(this.entityListAdapter);
		inited = true;
	}

	protected void loadDataList() {
		updateTime = getUpdateTime();
		if (updateTime != null) {
			try {
				this.setRefreshTime(DateUtils.formartTime(Long.valueOf(updateTime)));
			} catch (Exception e) {
			}
		}

		loadDataListFromLocal();
		if (dataList.isEmpty()) {
			loadDataListFromRemote();
		} else {
			entityListAdapter.updateData(dataList);
		}
	}

	private void loadDataListFromLocal() {
		String limitSql = " limit " + Const.PAGE_SIZE + " offset " + currentOffset;
		List<T> result = this.getDataListFromLocal(limitSql);
		if (result != null && !result.isEmpty()) {
			currentOffset += result.size();
			dataList.addAll(result);
		}
	}

	protected abstract List<T> getDataListFromLocal(String limitSql);

	protected abstract RestMethodResult<JSONObjResource> getRemoteData(
			String updateTime);

	protected abstract String getUpdateTime();

	public abstract EntityListAdapter<T> getEntityListAdapter();

	private void loadDataListFromRemote() {
		RestUtils.executeAsyncRestTask(context,
				new AbstractRestTaskCallback<JSONObjResource>("获取数据失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						updateTime = getUpdateTime();
						return getRemoteData(updateTime);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						currentOffset = 0;
						dataList.clear();
						loadDataListFromLocal();
						updateTime = getUpdateTime();
						entityListAdapter.updateData(dataList);
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

	private void onPostLoad() {
		this.stopRefresh();
		this.stopLoadMore();
		if (updateTime != null) {
			try {
				this.setRefreshTime(DateUtils.formartTime(Long.valueOf(updateTime)));
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
				entityListAdapter.updateData(dataList);
				onPostLoad();
			}
		}, 2000);
	}
}
