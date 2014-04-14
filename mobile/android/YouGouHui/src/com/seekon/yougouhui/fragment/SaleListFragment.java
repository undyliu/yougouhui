package com.seekon.yougouhui.fragment;

import java.util.LinkedList;
import java.util.List;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.sale.SaleDetailActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.ChannelEntity;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleServiceHelper;
import com.seekon.yougouhui.func.sale.widget.ChannelSaleListAdapter;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class SaleListFragment extends Fragment implements IXListViewListener {

	private static final String TAG = SaleListFragment.class.getSimpleName();

	private ChannelEntity channel;

	private List<SaleEntity> saleList = new LinkedList<SaleEntity>();

	private Long requestId;

	private BroadcastReceiver requestReceiver;

	protected Activity attachedActivity = null;

	protected String requestResultType;

	private XListView listView;

	private SaleData saleData;

	private ChannelSaleListAdapter saleListAdapter;

	private Handler mHandler;

	private int currentOffset = 0;// 分页用的当前的数据偏移

	public void setChannel(ChannelEntity channel) {
		this.channel = channel;
		requestResultType = SaleServiceHelper.SALE_REQUEST_RESULT + "_"
				+ channel.hashCode();
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = this.getActivity();
		saleData = new SaleData(attachedActivity);
		saleListAdapter = new ChannelSaleListAdapter(attachedActivity, saleList);
		mHandler = new Handler();

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
						ViewUtils.showToast("获取数据失败.");
					}
				} else {
					Logger.debug(TAG, "Result is NOT for our request ID");
				}

			}
		};
		updateListItems();
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);
		View view = inflater.inflate(R.layout.base_xlistview, container, false);
		listView = (XListView) view.findViewById(R.id.listview_main);
		listView.setAdapter(saleListAdapter);
		listView.setPullLoadEnable(true);
		listView.setXListViewListener(this);

		listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				SaleEntity sale = saleList.get(position - 1 );
				Intent intent = new Intent(attachedActivity, SaleDetailActivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, sale.getUuid());
				attachedActivity.startActivity(intent);
			}

		});

		return view;
	}

	@Override
	public void onResume() {
		super.onResume();
		attachedActivity.registerReceiver(requestReceiver, new IntentFilter(
				requestResultType));
	}

	@Override
	public void onPause() {
		super.onPause();
		if (attachedActivity != null && requestReceiver != null) {
			attachedActivity.unregisterReceiver(requestReceiver);
		}
	}

	protected void initRequestId() {
		AsyncTask<Void, Void, Long> task = new AsyncTask<Void, Void, Long>() {
			@Override
			protected Long doInBackground(Void... params) {
				requestId = SaleServiceHelper.getInstance(attachedActivity)
						.getMessages(channel.getUuid(), requestResultType);
				return requestId;
			}

		};
		currentOffset = 0;
		task.execute((Void) null);
	}

	protected List<SaleEntity> getListItemsFromLocal() {
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

	protected void updateListItems() {

		AsyncTask<Void, Void, List<SaleEntity>> task = new AsyncTask<Void, Void, List<SaleEntity>>() {
			@Override
			protected List<SaleEntity> doInBackground(Void... params) {
				Logger.debug(TAG, "getListItemsFromLocal");
				return getListItemsFromLocal();
			}

			@Override
			protected void onPostExecute(List<SaleEntity> result) {

				if (result.size() == 0 && requestId == null
						&& RunEnv.getInstance().isConnectedToInternet()) {
					Logger.debug(TAG, "getListItemsFromRemote");
					initRequestId();
				} else {
					saleList = result;
					updateListView();
				}
			}

			@Override
			protected void onCancelled() {

			}
		};

		task.execute((Void) null);
	}

	@Override
	public void onRefresh() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				initRequestId();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				saleList.addAll(getListItemsFromLocal());
				updateListView();
			}
		}, 2000);
	}
}
