package com.seekon.yougouhui.func.sale.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CompoundButton;
import android.widget.RadioButton;

import com.seekon.yougouhui.func.profile.shop.TradeEntity;

/**
 * 促销信息发布时，选择所属业务的列表
 * 
 * @author undyliu
 * 
 */
public class SaleTradeListAdapter extends BaseAdapter {

	private Context context;
	private List<TradeEntity> tradeList;
	private TradeEntity checkedTrade = null;

	public SaleTradeListAdapter(Context context, List<TradeEntity> tradeList) {
		super();
		this.context = context;
		this.tradeList = tradeList;
	}

	@Override
	public int getCount() {
		return this.tradeList.size();
	}

	@Override
	public Object getItem(int position) {
		return this.tradeList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public TradeEntity getCheckedTrade() {
		return checkedTrade;
	}

	@Override
	public View getView(final int position, View view, ViewGroup parent) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = new RadioButton(context);
			holder.view = (RadioButton) view;
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		holder.view.setText(tradeList.get(position).getName());
		holder.view
				.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {

					@Override
					public void onCheckedChanged(CompoundButton buttonView,
							boolean isChecked) {
						if (isChecked) {
							checkedTrade = tradeList.get(position);
						}
					}
				});
		if (getCount() == 1) {
			holder.view.setChecked(true);
			checkedTrade = tradeList.get(0);
		}
		
		return view;
	}

	class ViewHolder {
		RadioButton view;
	}
}
