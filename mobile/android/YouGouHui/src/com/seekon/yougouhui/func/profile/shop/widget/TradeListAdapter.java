package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;

import com.seekon.yougouhui.func.mess.ChannelEntity;

public class TradeListAdapter extends BaseAdapter {

	private Context context;
	private List<ChannelEntity> trades;

	public TradeListAdapter(Context context, List<ChannelEntity> trades) {
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
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}
		
		ChannelEntity trade = (ChannelEntity) getItem(position);
		CheckBox tradeBox = holder.view;
		tradeBox.setText(trade.getName());
		
		return view;
	}

	class ViewHolder {
		CheckBox view;
	}
}
