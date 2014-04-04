package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;

import com.seekon.yougouhui.func.profile.shop.TradeEntity;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

public class TradeListAdapter extends BaseAdapter{

	private Context context;
	private List<TradeEntity> trades;
	
	public TradeListAdapter(Context context, List<TradeEntity> trades) {
		super();
		this.context = context;
		this.trades = trades;
	}

	@Override
	public int getCount() {
		return trades.size();
	}

	@Override
	public Object getItem(int position) {
		return trades.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		return null;
	}

}
