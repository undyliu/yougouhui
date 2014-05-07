package com.seekon.yougouhui.func.sale.widget;

import java.util.List;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.ChannelEntity;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.func.widget.PagedXListView;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ChannelSaleListView extends PagedXListView<SaleEntity> {

	private ChannelEntity channel;
	private SaleData saleData;

	public ChannelSaleListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public ChannelSaleListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public ChannelSaleListView(Context context) {
		super(context);
	}

	public void loadData(ChannelEntity channel) {
		if (saleData == null) {
			saleData = new SaleData(context);
			super.init();
		}

		this.channel = channel;
		super.loadDataList();
	}

	@Override
	protected List<SaleEntity> getDataListFromLocal(String limitSql) {
		String channelId = channel.getUuid();
		if (channelId.equals("0")) {
			channelId = null;
		}
		return saleData.getSaleListByChannel(channelId, limitSql);
	}

	@Override
	protected RestMethodResult<JSONObjResource> getRemoteData(String updateTime) {
		return SaleProcessor.getInstance(context).getSalesByChannel(
				channel.getUuid(), updateTime);
	}

	@Override
	protected String getUpdateTime() {
		String result = SyncData.getInstance(context).getUpdateTime(
				SaleConst.TABLE_NAME, "*");
		if (result == null) {
			result = "-1";//RunEnv.getInstance().getUser().getRegisterTime();
		}
		return result;
	}

	@Override
	public EntityListAdapter<SaleEntity> getEntityListAdapter() {
		return new ChannelSaleListAdapter(context, dataList);
	}

}
