package com.seekon.yougouhui.fragment;

import java.util.LinkedList;
import java.util.List;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;

import com.baidu.location.BDLocation;
import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.sale.SaleDetailActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.ChannelEntity;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sale.widget.ChannelSaleListAdapter;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;

public class SaleListFragment extends Fragment implements IXListViewListener {

	private ChannelEntity channel;

	private List<SaleEntity> saleList = new LinkedList<SaleEntity>();

	protected Activity attachedActivity = null;

	private XListView listView;

	private SaleData saleData;

	private ChannelSaleListAdapter saleListAdapter;

	private Handler mHandler;

	private BroadcastReceiver locationReceiver;

	private int currentOffset = 0;// 分页用的当前的数据偏移

	private boolean updateLocation = true;
	
	public void setChannel(ChannelEntity channel) {
		this.channel = channel;
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = this.getActivity();
		saleData = new SaleData(attachedActivity);
		saleListAdapter = new ChannelSaleListAdapter(attachedActivity, saleList);
		mHandler = new Handler();

		locationReceiver = new BroadcastReceiver() {

			@Override
			public void onReceive(Context context, Intent intent) {
				LocationEntity locationEntity = new LocationEntity();
				BDLocation location = intent
						.getParcelableExtra(Const.DATA_BROAD_LOCATION);
				if (location.getLocType() == BDLocation.TypeNetWorkLocation) {
					locationEntity.setAddress(location.getAddrStr());
				}

				locationEntity.setLatitude(location.getLatitude());
				locationEntity.setLontitude(location.getLongitude());
				locationEntity.setRadius(location.getRadius());

				LocationEntity currentLocation = RunEnv.getInstance()
						.getLocationEntity();
				if (currentLocation == null || !currentLocation.equals(locationEntity)) {
					RunEnv.getInstance().setLocationEntity(locationEntity);			
					updateLocation = true;
				}
				if(updateLocation){
					saleListAdapter.notifyDataSetChanged();
					updateLocation = false;
				}
			}
		};
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);
		View view = inflater.inflate(R.layout.base_xlistview, container, false);

		updateViews(view);
		return view;
	}

	@Override
	public void onResume() {
		attachedActivity.registerReceiver(locationReceiver, new IntentFilter(
				Const.KEY_BROAD_LOCATION));
		super.onResume();
	}

	@Override
	public void onPause() {
		attachedActivity.unregisterReceiver(locationReceiver);
		super.onPause();
	}

	private void updateViews(View view) {
		listView = (XListView) view.findViewById(R.id.listview_main);
		listView.setAdapter(saleListAdapter);
		listView.setPullLoadEnable(true);
		listView.setXListViewListener(this);

		listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				SaleEntity sale = saleList.get(position - 1);
				Intent intent = new Intent(attachedActivity, SaleDetailActivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, sale.getUuid());
				attachedActivity.startActivity(intent);
			}

		});

		if (saleList.isEmpty() && channel != null) {
			loadSaleList();
		}
	}

	private void loadSaleList() {
		saleList.addAll(getSaleListFromLocal());
		if (saleList.isEmpty()) {
			loadSaleListFromRemote();
		} else {
			updateListView();
		}
	}

	private void loadSaleListFromRemote() {
		if (channel == null) {
			return;
		}

		saleList.clear();
		currentOffset = 0;

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONArrayResource>() {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return SaleProcessor.getInstance(attachedActivity)
								.getSalesByChannel(channel.getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						saleList.addAll(getSaleListFromLocal());
						updateListView();
					}
				});
	}

	private List<SaleEntity> getSaleListFromLocal() {
		String channelId = channel.getUuid();
		if (channelId.equals("0")) {
			channelId = null;
		}
		String limitSql = " limit " + Const.PAGE_SIZE + " offset " + currentOffset;

		List<SaleEntity> result = saleData
				.getSaleListByChannel(channelId, limitSql);
		currentOffset += result.size();
		return result;
	}

	protected void updateListView() {
		listView.stopRefresh();
		listView.stopLoadMore();

		saleListAdapter.updateData(saleList);
	}

	@Override
	public void onRefresh() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				loadSaleListFromRemote();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				saleList.addAll(getSaleListFromLocal());
				updateListView();
			}
		}, 2000);
	}
}
