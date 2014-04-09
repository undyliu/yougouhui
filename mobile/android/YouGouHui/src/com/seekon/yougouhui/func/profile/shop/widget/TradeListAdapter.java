package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;
import java.util.Map;

import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.TradeConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;

public class TradeListAdapter extends BaseAdapter {

	private TradeCheckedChangeActivity context;
	private List<Map<String, ?>> trades;

	public TradeListAdapter(TradeCheckedChangeActivity context,
			List<Map<String, ?>> trades) {
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
	
	public void updateData(List<Map<String, ?>> trades){
		this.trades = trades;
		this.notifyDataSetChanged();
	}
	
	private boolean itemChecked(int position){
		Map item = (Map) getItem(position);
		return Boolean.valueOf(item.get(DataConst.NAME_CHECKED).toString());
	}
	
	private TradeEntity getTrade(int position){
		Map item = (Map) getItem(position);
		return (TradeEntity) item.get(TradeConst.DATA_TRADE_KEY);
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

		CheckBox tradeBox = holder.view;
		tradeBox.setText(getTrade(position).getName());
		tradeBox.setOnCheckedChangeListener(context);
		tradeBox.setChecked(itemChecked(position));
		
		return view;
	}

	class ViewHolder {
		CheckBox view;
	}
}
