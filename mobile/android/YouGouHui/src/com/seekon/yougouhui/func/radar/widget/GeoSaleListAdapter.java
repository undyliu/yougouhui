package com.seekon.yougouhui.func.radar.widget;

import java.text.DecimalFormat;
import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

import com.seekon.yougouhui.func.sale.GeoSaleEntity;
import com.seekon.yougouhui.func.sale.widget.ChannelSaleListAdapter;

public class GeoSaleListAdapter extends ChannelSaleListAdapter<GeoSaleEntity> {

	public GeoSaleListAdapter(Context context, List<GeoSaleEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup arg2) {
		View view = super.getView(position, convertView, arg2);

		ViewHolder holder = (ViewHolder) view.getTag();
		GeoSaleEntity entity = (GeoSaleEntity) getItem(position);
		holder.distanceView.setText(new DecimalFormat("###,###.##").format(entity.getDistance()));

		return view;
	}

}
