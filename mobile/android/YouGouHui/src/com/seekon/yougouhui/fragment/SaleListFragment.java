package com.seekon.yougouhui.fragment;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
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
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.widget.ChannelSaleListView;

public class SaleListFragment extends Fragment {

	private static final int SALE_DETAIL_REQUEST_CODE = 1;
	
	private ChannelEntity channel;

	protected Activity attachedActivity = null;

	private ChannelSaleListView listView;

	private BroadcastReceiver locationReceiver;

	private boolean updateLocation = true;

	private SaleEntity selectedSale = null;
	
	public void setChannel(ChannelEntity channel) {
		this.channel = channel;
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = this.getActivity();
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
				if (updateLocation && listView != null) {
					listView.getEntityListAdapter().notifyDataSetChanged();
					updateLocation = false;
				}
			}
		};
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);
		View view = inflater.inflate(R.layout.channel_sale_list, container, false);

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
		listView = (ChannelSaleListView) view.findViewById(R.id.listview_main);

		listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				selectedSale = listView.getDataEntity(position - 1);
				Intent intent = new Intent(attachedActivity, SaleDetailActivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, selectedSale.getUuid());
				attachedActivity.startActivityForResult(intent, SALE_DETAIL_REQUEST_CODE);
			}

		});

		if (channel != null) {
			listView.loadData(channel);
		}
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case SALE_DETAIL_REQUEST_CODE:
			if(resultCode == Activity.RESULT_OK && data != null && selectedSale != null){
				selectedSale = (SaleEntity) data.getSerializableExtra(SaleConst.DATA_SALE_KEY);
				listView.getEntityListAdapter().notifyDataSetChanged();
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
}
