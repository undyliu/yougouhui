package com.seekon.yougouhui.func.radar.widget;

import java.util.List;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.widget.ChannelSaleListAdapter;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class RadarSaleListView extends RadarResultListView<SaleEntity> {

	public RadarSaleListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public RadarSaleListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public RadarSaleListView(Context context) {
		super(context);
	}

	@Override
	public EntityListAdapter<SaleEntity> getEntityListAdapter() {
		return new ChannelSaleListAdapter(context, dataList);
	}

	@Override
	protected List<SaleEntity> loadDataListFromRemote(int currentOffset,
			LocationEntity location) {
		return null;
	}

}
