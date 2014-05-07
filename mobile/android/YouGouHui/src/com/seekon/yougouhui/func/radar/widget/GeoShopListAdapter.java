package com.seekon.yougouhui.func.radar.widget;

import java.text.DecimalFormat;
import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

import com.seekon.yougouhui.func.shop.GeoShopEntity;
import com.seekon.yougouhui.func.shop.widget.ShopListAdapter;

public class GeoShopListAdapter extends ShopListAdapter<GeoShopEntity> {

	public GeoShopListAdapter(Context context, List<GeoShopEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);

		ViewHolder holder = (ViewHolder) view.getTag();
		GeoShopEntity entity = (GeoShopEntity) getItem(position);
		holder.distanceView.setText(new DecimalFormat("###,###.##米").format(entity
				.getDistance()));

		return view;
	}

}
