package com.seekon.yougouhui.func.radar.widget;

import java.util.List;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.widget.ShopListAdapter;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class RadarShopListView extends RadarResultListView<ShopEntity>{

	public RadarShopListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public RadarShopListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public RadarShopListView(Context context) {
		super(context);
	}

	@Override
	public EntityListAdapter<ShopEntity> getEntityListAdapter() {
		return new ShopListAdapter(context, dataList);
	}

	@Override
	protected List<ShopEntity> loadDataListFromRemote(int currentOffset,
			LocationEntity location) {
		return null;
	}
	
	
}
