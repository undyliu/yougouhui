package com.seekon.yougouhui.func.radar.widget;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Handler;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public abstract class RadarResultListView<T extends Entity> extends XListView
		implements IXListViewListener {
	
	protected static final String TAG = RadarResultListView.class.getSimpleName();
	
	protected List<T> dataList = new ArrayList<T>();

	private EntityListAdapter<T> entityListAdapter;
	private String updateTime;
	private int currentOffset = 0;
	protected Context context;
	private Handler mHandler;
	protected boolean inited = false;
	private LocationEntity location;
	private int distance;

	public RadarResultListView(Context context) {
		super(context);
		this.context = context;
	}

	public RadarResultListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		this.context = context;
	}

	public RadarResultListView(Context context, AttributeSet attrs) {
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

	public void loadDataList(LocationEntity location, int distance, boolean reload) {
		if (!inited) {
			init();
		}

		if (this.dataList.isEmpty() || reload || this.distance != distance) {
			updateTime = getUpdateTime();
			if (updateTime != null) {
				try {
					this.setRefreshTime(DateUtils.formartTime(Long.valueOf(updateTime)));
				} catch (Exception e) {
				}
			}

			this.distance = distance;
			this.location = location;
			loadNewestDataList();
		}
	}

	private String getUpdateTime() {
		return String.valueOf(System.currentTimeMillis());
	}

	private void loadNewestDataList() {		
		AsyncTask<Void, Void, List<T>> task = new AsyncTask<Void, Void, List<T>>(){
			@Override
			protected List<T> doInBackground(Void... params) {
				try{
					return loadDataListFromRemote(0, location, distance);
				}catch(Throwable e){
					Logger.warn(TAG, e.getMessage(), e);
				}
				return null;
			}
			
			@Override
			protected void onPostExecute(List<T> result) {
				if(result == null){
					ViewUtils.showToast("加载数据失败.");
				}else{
					currentOffset = 0;
					dataList.clear();
					
					dataList.addAll(result);
					currentOffset += result.size();
					entityListAdapter.updateData(dataList);
				}
			}			
		};
		
		task.execute((Void)null);
	}

	private void loadMoreDataList() {
		AsyncTask<Void, Void, List<T>> task = new AsyncTask<Void, Void, List<T>>(){
			@Override
			protected List<T> doInBackground(Void... params) {
				try{
					return loadDataListFromRemote(currentOffset, location, distance);
				}catch(Throwable e){
					Logger.warn(TAG, e.getMessage(), e);
				}
				return null;
			}
			
			@Override
			protected void onPostExecute(List<T> result) {
				if(result == null){
					ViewUtils.showToast("加载数据失败.");
				}else{
					dataList.addAll(result);
					currentOffset += result.size();
					entityListAdapter.updateData(dataList);
				}
			}			
		};
		
		task.execute((Void)null);
	}

	public abstract EntityListAdapter<T> getEntityListAdapter();

	protected abstract List<T> loadDataListFromRemote(int currentOffset,
			LocationEntity location, int distance);

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
				loadNewestDataList();
				onPostLoad();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				loadMoreDataList();
				onPostLoad();
			}
		}, 2000);
	}
}
