package com.seekon.yougouhui.func.sale.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CompoundButton;
import android.widget.RadioButton;

import com.seekon.yougouhui.func.shop.TradeEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

/**
 * 促销信息发布时，选择所属业务的列表
 * 
 * @author undyliu
 * 
 */
public class SaleTradeListAdapter extends EntityListAdapter<TradeEntity> {

	private TradeEntity checkedTrade = null;
	private boolean readonly = false;

	public SaleTradeListAdapter(Context context, List<TradeEntity> dataList,
			boolean readonly) {
		super(context, dataList);
		this.readonly = readonly;
	}

	public void setDefaultCheckedTrade(TradeEntity defaultCheckedTrade) {
		this.checkedTrade = defaultCheckedTrade;
		this.notifyDataSetChanged();
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

		final TradeEntity trade = (TradeEntity) getItem(position);
		holder.view.setText(trade.getName());
		if (!readonly) {
			holder.view.setEnabled(true);
			holder.view
					.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {

						@Override
						public void onCheckedChanged(CompoundButton buttonView,
								boolean isChecked) {
							if (isChecked) {
								checkedTrade = trade;
							}
							SaleTradeListAdapter.this.notifyDataSetChanged();
						}
					});
		}else{
			holder.view.setEnabled(false);
		}
		
		if (getCount() == 1) {
			holder.view.setChecked(true);
			checkedTrade = dataList.get(0);
		}

		if (checkedTrade != null && checkedTrade.equals(trade)) {
			holder.view.setChecked(true);
		} else {
			holder.view.setChecked(false);
		}

		return view;
	}

	class ViewHolder {
		RadioButton view;
	}
}
