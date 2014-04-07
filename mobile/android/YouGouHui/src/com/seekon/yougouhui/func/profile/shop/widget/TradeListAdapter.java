package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.CompoundButton;

import com.seekon.yougouhui.func.profile.shop.TradeEntity;

public class TradeListAdapter extends BaseAdapter {

	private TradeCheckedChangeActivity context;
	private List<TradeEntity> trades;

	public TradeListAdapter(TradeCheckedChangeActivity context,
			List<TradeEntity> trades) {
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
	public View getView(int position, View view, ViewGroup parent) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = new CheckBox(context);
			holder.view = (CheckBox) view;
			holder.view.setId(position);
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		TradeEntity trade = (TradeEntity) getItem(position);
		CheckBox tradeBox = holder.view;
		tradeBox.setText(trade.getName());
		tradeBox.setOnCheckedChangeListener(context);
		
		return view;
	}

	class ViewHolder {
		CheckBox view;
	}
}
